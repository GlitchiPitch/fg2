local Services = require(script.Services)

---@class FoodEatingClientApp
---@field services FoodEatingClientServices
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return FoodEatingClientApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
	self.services = Services.new(diContainer)
	return self
end

function Application:init()
	self.services:init()
end

return Application