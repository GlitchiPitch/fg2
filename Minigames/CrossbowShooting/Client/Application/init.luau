local Services = require(script.Services)

---@class CrossbowShootingClientApp
---@field services CrossbowShootingClientAppServices
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return CrossbowShootingClientApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
    self.diContainer = diContainer
    self.services = Services.new(diContainer)
	return self
end

function Application:init()
    self.services:init()
end

return Application