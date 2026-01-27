---@class TargetEntity
---@field _model Model
---@field id string
---@field _destroyCallback function () -> void
---@field _alignOrientation AlignOrientation
---@field _alignPosition AlignPosition
---@field _attachment Attachment
local TargetEntity = {}
TargetEntity.__index = TargetEntity

---@param model Model
---@param id string
---@param score number
---@return TargetEntity
function TargetEntity.new(model, id, score)
	local self = setmetatable({}, TargetEntity)
	self._model = model
	self.id = id
	self.score = score
	return self
end

---@class targetEntityInitData
---@field destroyCallback function () -> void
---@param data targetEntityInitData
function TargetEntity:init(data)
	self._destroyCallback = data.destroyCallback
	self._model:AddTag("Target")
	self._model:SetAttribute("TargetId", self.id)
end

---@class targetEntitySpawnData
---@field startAttachment Attachment
---@field finishAttachment Attachment

---@param data targetEntitySpawnData
function TargetEntity:spawn(data)
	self._model.Parent = workspace
	self._model:PivotTo(data.startAttachment.WorldCFrame)
	self:_startMoving(data)
end

---@param data targetEntitySpawnData
function TargetEntity:_startMoving(data)
	self._alignOrientation = Instance.new("AlignOrientation")
	self._alignOrientation.Parent = self._model.PrimaryPart
    self._alignPosition = Instance.new("AlignPosition")
    self._alignPosition.Parent = self._model.PrimaryPart

    self._attachment = Instance.new("Attachment")
    self._attachment.Parent = self._model.PrimaryPart
    
    self._alignOrientation.Attachment0 = self._attachment
    self._alignOrientation.Attachment1 = data.finishAttachment

    self._alignPosition.MaxVelocity = 20
    self._alignPosition.Responsiveness = 5
    self._alignPosition.Attachment0 = self._attachment
    self._alignPosition.Attachment1 = data.finishAttachment

	task.delay(20, function()
		self:destroy()
	end)
end

function TargetEntity:destroy()
	self._model:Destroy()
	self:_playDestroyAnimation()
	self._destroyCallback()
end

function TargetEntity:_playDestroyAnimation() end

return TargetEntity
