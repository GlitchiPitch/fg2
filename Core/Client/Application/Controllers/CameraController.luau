---@class CameraController
---@field diContainer DIContainer
---@field camera Camera
---@field eventBus EventBus
local CameraController = {}
CameraController.__index = CameraController

---@param diContainer DIContainer
---@return CameraController
function CameraController.new(diContainer)
	local self = setmetatable({}, CameraController)
	self.diContainer = diContainer
	self.camera = workspace.CurrentCamera
	return self
end

function CameraController:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.eventBus = shared.eventBus

	self.eventBus:connectToEvents({
		[shared.constants.CLIENT_EVENTS.SET_MODE] = function(data)
			self:setCameraType(data)
		end,
	})
end

function CameraController:update() end

---@param data setModeData
function CameraController:setCameraType(data)
	self.camera.CameraType = data.type
end

---@class setModeData
---@field type Enum.CameraType

return CameraController
