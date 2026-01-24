local Services = require(script.Services)
---@class CrossbowShootingServerApp
---@field services CrossbowShootingServerAppServices
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return CrossbowShootingServerApp
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