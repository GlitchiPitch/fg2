---@class CrossbowShootingClientApp
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return CrossbowShootingClientApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
    self.diContainer = diContainer
	return self
end

function Application:init()
end

return Application