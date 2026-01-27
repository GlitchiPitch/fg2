local Services = require(script.Services)
local Controllers = require(script.Controllers)
---@class FoodEatingServerApp
---@field services ServerFoodEatingServices
---@field playerService ServerFoodEatingPlayerService
---@field controllers ServerFoodEatingControllers
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return FoodEatingServerApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
	self.services = Services.new(diContainer)
	self.controllers = Controllers.new(diContainer)
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
