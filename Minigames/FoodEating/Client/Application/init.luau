---@class FoodEatingClientApp
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return FoodEatingClientApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
	return self
end

function Application:init()
end

return Application