local Services = require(script.Services)

---@class ShootingClientApp
---@field services ShootingClientAppServices
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return ShootingClientApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
    self.diContainer = diContainer
    self.services = Services.new(diContainer)
	return self
end

function Application:init()
    self.services:init()
end

-- function Application:start()
--     self.services:start()
-- end

-- function Application:stop()
--     self.services:stop()
-- end

return Application