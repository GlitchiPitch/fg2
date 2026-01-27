local RunService = game:GetService("RunService")
local TargetController = require(script.TargetController)
local GameController = require(script.GameController)
---@class ServerShootingControllers
---@field targetController ServerShootingTargetController
---@field gameController ServerShootingGameController
---@field heartbeatConnection RBXScriptSignal
local Controllers = {}
Controllers.__index = Controllers

---@param diContainer DIContainer
---@return ServerShootingControllers
function Controllers.new(diContainer)
	local self = setmetatable({}, Controllers)
	self.diContainer = diContainer
	self.targetController = TargetController.new(diContainer)
	self.gameController = GameController.new(diContainer)
	return self
end

function Controllers:init()
	self.targetController:init()
	self.gameController:init()
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
	self.gameController:update(deltaTime)
end

return Controllers
