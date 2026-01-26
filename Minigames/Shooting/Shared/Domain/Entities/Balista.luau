---@class BalistaEntity
---@field model Model
---@field seat Seat
---@field alignOrientation AlignOrientation
---@field owner Player
---@field ownerId number
---@field _cameraCFrameConnection RBXScriptConnection
---@field shootAttachment Attachment
---@field _ammo Model[]
---@field id string
---@field _destroyCallback function () -> void
local Balista = {}
Balista.__index = Balista

---@class balistaNewData
---@field id string
---@field ownerId number
---@field model Model
---@field ammo Model[]
---@field isReloading boolean

---@param data balistaNewData
---@return BalistaEntity
function Balista.new(data)
	local self = setmetatable({}, Balista)
	self.model = data.model
	self.id = data.id
	self.seat = self.model.Seat :: Seat
	self.owner = nil
	self.ownerId = nil
	self._cameraCFrameConnection = nil
	self._ammo = {}
	self.alignOrientation = self.seat.AlignOrientation :: AlignOrientation
	self.shootAttachment = self.model.PrimaryPart.ShootAttachment :: Attachment
	self._isReloading = false
	return self
end

---@class balistaInitData
---@field destroyCallback function () -> void

---@param data balistaInitData
function Balista:init(data)
	self._destroyCallback = data.destroyCallback
end

---@class balistaSetupData
---@field activateCallback function (occupant: Humanoid) -> void
---@field deactivateCallback function (ownerId: number) -> void

---@param data balistaSetupData
function Balista:setup(data)
	self.seat.Changed:Connect(function(property)
		if property == "Occupant" then
			local occupant = self.seat.Occupant
			if occupant then
				local player = data.activateCallback(occupant)
				self.owner = player
				self.ownerId = player.UserId
				self:_activate()
			else
				data.deactivateCallback(self.ownerId)
				self:_deactivate()
			end
		end
	end)
end

---@return table
function Balista:toData()
	return {
		id = self.id,
		ownerId = self.ownerId,
		model = self.model,
		ammo = self._ammo,
		isReloading = self._isReloading,
	}
end

function Balista:destroy()
	for _, ammo in self._ammo do
		ammo:Destroy()
	end
	
	if self._cameraCFrameConnection then
		self._cameraCFrameConnection:Disconnect()
		self._cameraCFrameConnection = nil
	end

	self._destroyCallback()
end

---@return table
function Balista:shoot()
	if self._isReloading then
		return
	end

	local bullet = self:_getRandomAmmo()
	if not bullet then
		return { reload = true }
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
		touchConnection:Disconnect()
		bulletModel:Destroy()
	end)

	self._isReloading = #self._ammo == 0

	return { reload = self._isReloading }
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

---@return Model?
function Balista:_getRandomAmmo()
	if #self._ammo == 0 then
		return nil
	end

	local ammo = self._ammo[math.random(1, #self._ammo)]
	table.remove(self._ammo, math.random(1, #self._ammo))
	return ammo
end

return Balista
