local CameraController = require(script.CameraController)
local RunService = game:GetService("RunService")
---@class ClientControllers
---@field heartbeatConnection RBXScriptSignal
---@field diContainer DIContainer
---@field cameraController CameraController
local Controllers = {}
Controllers.__index = Controllers

---@param diContainer DIContainer
---@return ClientControllers
function Controllers.new(diContainer)
	local self = setmetatable({}, Controllers)
	self.cameraController = CameraController.new(diContainer)
    self.diContainer = diContainer
	return self
end

function Controllers:init()

	self.heartbeatConnection = RunService.Heartbeat:Connect(function(deltaTime)
		self:_update(deltaTime)
	end)

	self.cameraController:init()
end

function Controllers:_update(deltaTime)
	self.cameraController:update(deltaTime)
end

return Controllers
