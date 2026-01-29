local FoodService = require(script.FoodService)
local PlayerService = require(script.PlayerService)
local ChairService = require(script.ChairService)
local GameService = require(script.GameService)
---@class ServerFoodEatingServices
---@field foodService ServerFoodEatingFoodService
---@field playerService ServerFoodEatingPlayerService
---@field chairService ServerFoodEatingChairService
---@field gameService ServerFoodEatingGameService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ServerFoodEatingServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
	self.foodService = FoodService.new(diContainer)
	self.playerService = PlayerService.new(diContainer)
	self.chairService = ChairService.new(diContainer)
	self.gameService = GameService.new(diContainer)
	return self
end

function Services:init()
	self.foodService:init()
	self.playerService:init()
	self.chairService:init()
	self.gameService:init()
end

function Services:stop()
	self.gameService:finish()
	
end

return Services