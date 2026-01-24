local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
---@class ShootingServerBalistaService
---@field diContainer DIContainer
---@field constants SharedConstants
---@field balistaRepository ServerShootingBalistaRepository
---@field eventBus EventBus
local BalistaService = {}
BalistaService.__index = BalistaService

---@param diContainer DIContainer
---@return ShootingServerBalistaService
function BalistaService.new(diContainer)
	local self = setmetatable({}, BalistaService)
	self.diContainer = diContainer
	self._balistaEntities = {}
	return self
end

function BalistaService:init()
	---@type ShootingShared
	local shared = self.diContainer:resolve("Shared")
	---@type ShootingServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.balistaRepository = infrastructure.repositories.balistaRepository

	self.constants = shared.constants
	self.eventBus = shared.eventBus

	self.ammo = {
		shared.assets.Box,
		shared.assets.SpaceGirl,
		shared.assets.SpaceMan,
	}

	self.remoteEventService = shared.remoteEventService

	self.balistas = workspace.Workspace.Maps.Shooting.Balistas:GetChildren()

	self.remoteEventService:connectToEvents({
		[self.constants.REMOTE_EVENTS.SHOOT] = function(player, eventData)
			eventData.data.player = player
			self:onShoot(eventData.data)
		end,
	})
	self:_setup()
end

function BalistaService:_setup()
	---@param balista Model
	for _, balista in self.balistas do
		-- local seat = balista.Seat :: Seat
		local balistaEntity = self.balistaRepository:getBalistaEntity(balista)
		balistaEntity:init({
			---@param occupant Humanoid
			activateCallback = function(occupant)
				local player = Players:GetPlayerFromCharacter(occupant.Parent)

				self.eventBus:fire(self.constants.SERVER_EVENTS.PLAYER_JOINED_BALISTA, {
					player = player,
				})
				balistaEntity:setAmmo(self.ammo)
				self._balistaEntities[player.UserId] = balistaEntity
				return player
			end,
			deactivateCallback = function(ownerId)
				local player = Players:GetPlayerByUserId(ownerId)
				if player then
					self.eventBus:fire(self.constants.SERVER_EVENTS.PLAYER_LEFT_BALISTA, {
						player = player,
					})
				end
				self._balistaEntities[ownerId] = nil
			end,
		})

		-- seat.Changed:Connect(function(property)
		-- 	if property == "Occupant" then
		-- 		local occupant = seat.Occupant
		-- 		if occupant then
		-- 			local player = Players:GetPlayerFromCharacter(occupant.Parent)

		-- 			self.eventBus:fire(self.constants.SERVER_EVENTS.PLAYER_JOINED_BALISTA, {
		-- 				player = player,
		-- 			})
		-- 			self:_activateBalista(player, balista)
		-- 		else
		-- 			local playerId = balista:GetAttribute("PlayerId")
		-- 			local player = Players:GetPlayerByUserId(playerId)
		-- 			if player then
		-- 				self.eventBus:fire(self.constants.SERVER_EVENTS.PLAYER_LEFT_BALISTA, {
		-- 					player = player,
		-- 				})
		-- 			end
		-- 			self:_deactivateBalista(balista)
		-- 		end
		-- 	end
		-- end)
	end
end

-- function BalistaService:_activateBalista(player, balista)
-- 	balista:SetAttribute("PlayerId", player.UserId)
-- 	local alignOrientation = balista.Seat.AlignOrientation :: AlignOrientation
-- 	alignOrientation.CFrame = CFrame.new(0, 0, 0)

-- 	self._balistaOwners[balista] = player
-- 	self._connections[balista] = player:GetAttributeChangedSignal("CameraCFrame"):Connect(function()
-- 		local cameraCFrame = player:GetAttribute("CameraCFrame")
-- 		alignOrientation.CFrame = cameraCFrame
-- 	end)
-- end

-- function BalistaService:_deactivateBalista(balista)
-- 	local alignOrientation = balista.Seat.AlignOrientation :: AlignOrientation
-- 	alignOrientation.CFrame = CFrame.new(0, 0, 0)

-- 	self._balistaOwners[balista] = nil
-- 	self._connections[balista]:Disconnect()
-- 	self._connections[balista] = nil
-- 	balista:SetAttribute("PlayerId", nil)
-- end

function BalistaService:onShoot(eventData)
	local player = eventData.player
	warn(player)
	local balistaEntity = self:getBalistaByOwner(player)
	warn(balistaEntity)
	if not balistaEntity then
		return
	end

	balistaEntity:shoot()
end

function BalistaService:getBalistaByOwner(player)
	return self._balistaEntities[player.UserId]
end

return BalistaService
