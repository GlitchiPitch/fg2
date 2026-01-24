local Services = require(script.Services)
---@class ShootingServerApp
---@field services ShootingServerAppServices
---@field controllers ShootingServerControllers
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return ShootingServerApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
    self.diContainer = diContainer
    self.services = Services.new(self.diContainer)
	return self
end

function Application:init()
	self.services:init()
end

return Application