local InputService = require(script.InputService)
local PlayerService = require(script.PlayerService)
local FoodService = require(script.FoodService)
local GameService = require(script.GameService)
---@class FoodEatingClientServices
---@field inputService FoodEatingInputService
---@field playerService ClientFoodEatingPlayerService
---@field foodService ClientFoodServiceService
---@field gameService ClientFoodEatingGameService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return FoodEatingClientServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
	self.inputService = InputService.new(diContainer)
	self.playerService = PlayerService.new(diContainer)
	self.foodService = FoodService.new(diContainer)
	self.gameService = GameService.new(diContainer)
	return self
end

function Services:init()
	self.inputService:init()
	self.playerService:init()
	self.foodService:init()
	self.gameService:init()
end

function Services:stop()
	self.foodService:stop()
end

return Services