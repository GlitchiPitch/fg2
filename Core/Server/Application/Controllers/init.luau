local RunService = game:GetService("RunService")
local ZoneController = require(script.ZoneController)

---@class ServerControllers
---@field zoneController ZoneController
local Controllers = {}
Controllers.__index = Controllers

---@param diContainer DIContainer
---@return ServerControllers
function Controllers.new(diContainer)
	local self = setmetatable({}, Controllers)
    self.diContainer = diContainer
    self.zoneController = ZoneController.new(diContainer)
	return self
end

function Controllers:init()
	self.heartbeatConnection = RunService.Heartbeat:Connect(function(deltaTime)
		self:_update(deltaTime)
	end)

	self.zoneController:init()
end

function Controllers:_update(deltaTime) 
	self.zoneController:update(deltaTime)
end

return Controllers
