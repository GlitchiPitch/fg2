local RunService = game:GetService("RunService")
local TargetController = require(script.TargetController)

---@class ShootingServerControllers
---@field targetController TargetController
local Controllers = {}
Controllers.__index = Controllers

---@param diContainer DIContainer
---@return ShootingServerControllers
function Controllers.new(diContainer)
	local self = setmetatable({}, Controllers)
	self.diContainer = diContainer
	self.targetController = TargetController.new(diContainer)
	return self
end

function Controllers:init()
	self.targetController:init()
end

function Controllers:start()
	self.heartbeatConnection = RunService.Heartbeat:Connect(function(deltaTime)
		self:_update(deltaTime)
	end)
end

function Controllers:stop()
	self.heartbeatConnection:Disconnect()
end

function Controllers:_update(deltaTime)
	self.targetController:update(deltaTime)
end

return Controllers
