---@class BalistaEntity
---@field model Model
---@field seat Seat
---@field alignOrientation AlignOrientation
---@field owner Player
---@field ownerId number
---@field _cameraCFrameConnection RBXScriptConnection
---@field shootAttachment Attachment
---@field _ammo Model[]
local Balista = {}
Balista.__index = Balista

---@param balista Model
---@return BalistaEntity
function Balista.new(balista)
	local self = setmetatable({}, Balista)
	self.model = balista
	self.seat = balista.Seat :: Seat
	self.owner = nil
	self.ownerId = nil
	self._cameraCFrameConnection = nil
	self._ammo = {}
	self.alignOrientation = self.seat.AlignOrientation :: AlignOrientation
	self.shootAttachment = self.model.PrimaryPart.ShootAttachment :: Attachment
	return self
end

---@class balistaServiceCallbackData
---@field activateCallback function (occupant: Humanoid) -> void
---@field deactivateCallback function (ownerId: number) -> void

---@param balistaServiceCallbacks balistaServiceCallbackData
function Balista:init(balistaServiceCallbacks)
	self.seat.Changed:Connect(function(property)
		if property == "Occupant" then
			local occupant = self.seat.Occupant
			if occupant then
				local player = balistaServiceCallbacks.activateCallback(occupant)
				self.owner = player
				self.ownerId = player.UserId
				self:_activate()
			else
				balistaServiceCallbacks.deactivateCallback(self.ownerId)
				self:_deactivate()
			end
		end
	end)
end

---@param ammo Model[]
function Balista:setAmmo(ammo)
	self._ammo = ammo
end

function Balista:_activate()
	self.alignOrientation.CFrame = CFrame.new(0, 0, 0)

	self._cameraCFrameConnection = self.owner:GetAttributeChangedSignal("CameraCFrame"):Connect(function()
		local cameraCFrame = self.owner:GetAttribute("CameraCFrame")
		self.alignOrientation.CFrame = cameraCFrame
	end)
end

function Balista:_deactivate()
	self.alignOrientation.CFrame = CFrame.new(0, 0, 0)

	self._cameraCFrameConnection:Disconnect()
	self._cameraCFrameConnection = nil
	self.owner = nil
	self.ownerId = nil
end

function Balista:shoot()
	local bullet = self:_getRandomAmmo()
	print(bullet)
	if not bullet then
		return
	end

	local origin = self.shootAttachment.WorldCFrame
	local bulletModel = bullet:Clone() :: Model
	bulletModel:PivotTo(origin)
	bulletModel.Parent = workspace

	-- Calculate initial velocity for parabolic trajectory
	local shootDirection = origin.LookVector -- Use WorldCFrame's LookVector for world-space direction
	local speed = 300 -- Overall speed magnitude
	local additionalVerticalSpeed = 50 -- Additional upward velocity for arc effect

	-- Use the full shoot direction scaled by speed, preserving both horizontal and vertical components
	local velocity = shootDirection * speed

	-- Add additional upward velocity for arc effect
	velocity = velocity + Vector3.new(0, additionalVerticalSpeed, 0)

	local touchConnection

	-- Set initial velocity using AssemblyLinearVelocity (physics engine handles gravity automatically)
	bulletModel.PrimaryPart.AssemblyLinearVelocity = velocity

	touchConnection = bulletModel.PrimaryPart.Touched:Connect(function(hit)
		print(hit.Name)
		touchConnection:Disconnect()
		bulletModel:Destroy()
	end)
end

---@return Model?
function Balista:_getRandomAmmo()
	if #self._ammo == 0 then
		return nil
	end

	return self._ammo[math.random(1, #self._ammo)]
end

return Balista
