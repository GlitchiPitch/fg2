local FoodService = require(script.FoodService)
local PlayerService = require(script.PlayerService)
local ChairService = require(script.ChairService)

---@class ServerFoodEatingServices
---@field foodService ServerFoodEatingFoodService
---@field playerService ServerFoodEatingPlayerService
---@field chairService ServerFoodEatingChairService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ServerFoodEatingServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
	self.foodService = FoodService.new(diContainer)
	self.playerService = PlayerService.new(diContainer)
	self.chairService = ChairService.new(diContainer)
	return self
end

function Services:init()
	self.foodService:init()
	self.playerService:init()
	self.chairService:init()
end

return Services