local InputService = require(script.InputService)
local PlayerService = require(script.PlayerService)
local FoodService = require(script.FoodService)
---@class FoodEatingClientServices
---@field inputService FoodEatingInputService
---@field playerService ClientFoodEatingPlayerService
---@field foodService ClientFoodServiceService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return FoodEatingClientServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
	self.inputService = InputService.new(diContainer)
	self.playerService = PlayerService.new(diContainer)
	self.foodService = FoodService.new(diContainer)
	return self
end

function Services:init()
	self.inputService:init()
	self.playerService:init()
	self.foodService:init()
end

return Services