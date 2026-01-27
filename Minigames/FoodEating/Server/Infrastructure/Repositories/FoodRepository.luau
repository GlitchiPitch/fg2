local HttpService = game:GetService("HttpService")
---@class ServerFoodEatingFoodRepository
---@field diContainer DIContainer
---@field foodEntities table<string, FoodEntity>
---@field foodEntity FoodEntity
---@field itemsRepository SharedFoodEatingItemsRepository
local FoodRepository = {}
FoodRepository.__index = FoodRepository

---@param diContainer DIContainer
---@return ServerFoodEatingFoodRepository
function FoodRepository.new(diContainer)
	local self = setmetatable({}, FoodRepository)
	self.diContainer = diContainer
	return self
end

function FoodRepository:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.itemsRepository = shared.infrastructure.itemsRepository
	self.foodEntity = shared.domain.Entities.Food
end

---@param food Model
---@return FoodEntity
function FoodRepository:createFoodEntity(food)
	local id = HttpService:GenerateGUID(false)
	local foodEntity = self.foodEntity.new(food, id)
	return foodEntity
end

return FoodRepository