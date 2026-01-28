local HttpService = game:GetService("HttpService")
---@class ServerFoodEatingFoodRepository
---@field diContainer DIContainer
---@field foodEntities table<string, FoodEntity>
---@field foodEntity FoodEntity
---@field data SharedFoodEatingData
local FoodRepository = {}
FoodRepository.__index = FoodRepository

---@param diContainer DIContainer
---@return ServerFoodEatingFoodRepository
function FoodRepository.new(diContainer)
	local self = setmetatable({}, FoodRepository)
	self.diContainer = diContainer
	self.foodEntities = {}
	self.foodNames = {}
	return self
end

function FoodRepository:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.foodEntity = shared.domain.Entities.Food
	self.data = shared.data.Food

	for foodName, _ in self.data do
		table.insert(self.foodNames, foodName)
	end
end

---@return string
function FoodRepository:getRandomFoodName()
	return self.foodNames[math.random(1, #self.foodNames)]
end

---@param foodName string
---@return FoodEntity
function FoodRepository:createFoodEntity(foodName)
	local id = HttpService:GenerateGUID(false)
	local foodModel = self.data[foodName].model:Clone()
	local eatingType = self.data[foodName].eatingType
	local combo = self.data[foodName].combo
	local score = self.data[foodName].score
	
	local foodEntity = self.foodEntity.new({
		foodModel = foodModel,
		eatingType = eatingType,
		id = id,
		combo = combo,
		score = score,
	})
	self.foodEntities[id] = foodEntity
	return foodEntity
end

function FoodRepository:getFoodEntity(id)
	return self.foodEntities[id]
end

function FoodRepository:removeFoodEntity(id)
	self.foodEntities[id] = nil
end

return FoodRepository
