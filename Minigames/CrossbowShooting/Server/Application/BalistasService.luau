local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
---@class CrossbowShootingServerBalistasService
---@field diContainer DIContainer
---@field constants SharedConstants
---@field eventBus EventBus
local BalistasService = {}
BalistasService.__index = BalistasService

---@param diContainer DIContainer
---@return CrossbowShootingServerBalistasService
function BalistasService.new(diContainer)
	local self = setmetatable({}, BalistasService)
	self.diContainer = diContainer
	self._connections = {}
	self._balistaOwners = {}
	return self
end

function BalistasService:init()
	---@type CrossbowShootingShared
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus
	self.box = shared.assets.Box
	self.remoteEventService = shared.remoteEventService

	self.balistas = workspace.Workspace.Balistas:GetChildren()

	self.remoteEventService:connectToEvents({
		[self.constants.REMOTE_EVENTS.SHOOT] = function(player, eventData)
			eventData.data.player = player
			self:onShoot(eventData.data)
		end,
	})
	self:_setup()
end

function BalistasService:_setup()
	---@param balista Model
	for _, balista in self.balistas do
		local seat = balista.Seat :: Seat

		seat.Changed:Connect(function(property)
			if property == "Occupant" then
				local occupant = seat.Occupant
				local alignOrientation = seat.AlignOrientation :: AlignOrientation
				if occupant then
					local player = Players:GetPlayerFromCharacter(occupant.Parent)
					balista:SetAttribute("PlayerId", player.UserId)
					self.eventBus:fire(self.constants.SERVER_EVENTS.PLAYER_JOINED_BALISTA, {
						player = player,
					})
					alignOrientation.CFrame = CFrame.new(0, 0, 0)

					self._balistaOwners[balista] = player
					self._connections[balista] = player:GetAttributeChangedSignal("CameraCFrame"):Connect(function()
						local cameraCFrame = player:GetAttribute("CameraCFrame")
						alignOrientation.CFrame = cameraCFrame
					end)
				else
					local playerId = balista:GetAttribute("PlayerId")
					local player = Players:GetPlayerByUserId(playerId)
					if player then
						self.eventBus:fire(self.constants.SERVER_EVENTS.PLAYER_LEFT_BALISTA, {
							player = player,
						})
					end
					alignOrientation.CFrame = CFrame.new(0, 0, 0)
					self._balistaOwners[balista] = nil
					self._connections[balista]:Disconnect()
					self._connections[balista] = nil
					balista:SetAttribute("PlayerId", nil)
				end
			end
		end)
	end
end

function BalistasService:onShoot(eventData)
	local player = eventData.player
	local balista = self:getBalistaByOwner(player)
	if not balista then
		return
	end

	local origin = balista.PrimaryPart.ShootAttachment.WorldCFrame :: CFrame
	local box = self.box:Clone() :: Model
	box:PivotTo(origin)
	box.Parent = workspace

	-- Calculate initial velocity for parabolic trajectory
	local shootDirection = origin.LookVector -- Use WorldCFrame's LookVector for world-space direction
	local speed = 300 -- Overall speed magnitude
	local additionalVerticalSpeed = 50 -- Additional upward velocity for arc effect

	-- Use the full shoot direction scaled by speed, preserving both horizontal and vertical components
	local velocity = shootDirection * speed

	-- Add additional upward velocity for arc effect
	velocity = velocity + Vector3.new(0, additionalVerticalSpeed, 0)

	-- Track position and time for parabolic motion
	local currentPosition = origin.Position
	local gravity = workspace.Gravity
	local connection
	local lastTime = tick()

	connection = RunService.Heartbeat:Connect(function()
		if not box.PrimaryPart or not box.PrimaryPart.Parent then
			connection:Disconnect()
			return
		end

		local currentTime = tick()
		local deltaTime = currentTime - lastTime
		lastTime = currentTime

		-- Update velocity with gravity (apply to vertical component)
		velocity = velocity - Vector3.new(0, gravity * deltaTime, 0)

		-- Update position based on velocity
		currentPosition = currentPosition + velocity * deltaTime

		-- Move the box to new position
		local currentCFrame = box:GetPivot()
		box:PivotTo(CFrame.new(currentPosition, currentPosition + currentCFrame.LookVector))
	end)

	-- Clean up after 2 seconds
	task.delay(2, function()
		if connection then
			connection:Disconnect()
		end
	end)

	Debris:AddItem(box, 10)
end

function BalistasService:getBalistaByOwner(player)
	for balista, owner in self._balistaOwners do
		if owner == player then
			return balista
		end
	end
	return nil
end

return BalistasService
