local Services = require(script.Services)
local Controllers = require(script.Controllers)
---@class ServerShootingApp
---@field services ServerShootingAppServices
---@field controllers ServerShootingControllers
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return ServerShootingApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
	self.diContainer = diContainer
	self.services = Services.new(self.diContainer)
	self.controllers = Controllers.new(self.diContainer)
	return self
end

function Application:init()
	self.services:init()
	self.controllers:init()
end

function Application:start()
	self.controllers:start()
end

function Application:stop()
	self.controllers:stop()
end

return Application
