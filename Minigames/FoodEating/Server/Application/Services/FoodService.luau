---@class ServerFoodEatingFoodService
---@field diContainer DIContainer
---@field foodRepository ServerFoodEatingFoodRepository
---@field eventBus EventBus
---@field constants SharedFoodEatingConstants
---@field remoteEventService RemoteEventService
local FoodService = {}
FoodService.__index = FoodService

---@param diContainer DIContainer
---@return ServerFoodEatingFoodService
function FoodService.new(diContainer)
	local self = setmetatable({}, FoodService)
	self.diContainer = diContainer
	return self
end

function FoodService:init()
	---@type ServerFoodEatingInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.foodRepository = infrastructure.repositories.foodRepository
	self.chairRepository = infrastructure.repositories.chairRepository
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus
	self.remoteEventService = shared.remoteEventService

	self:_setupEventListeners()
	self:_setupRemoteEventListener()
end

function FoodService:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.SERVER_EVENTS.SPAWN_FOOD] = function()
			self:_spawnFood()
		end,
	})
end

function FoodService:_setupRemoteEventListener()
	self.remoteEventService:connectToEvents({
		[self.constants.REMOTE_EVENTS.EAT_FOOD] = function(player)
			warn("eatFood")
			self:_eatFood(player)
		end,
	})
end

function FoodService:_eatFood(player)
	local chair = self.chairRepository:getChairByPlayer(player)
	warn("chair", chair)
	if not chair then
		return
	end
	warn("eating food")
	chair:eatFood()
end

function FoodService:_spawnFood()
	local chairs = self.chairRepository:getChairs()

	---@param chair ChairEntity
	for _, chair in chairs do
		if chair.occupant and not chair.currentFood then
			local foodName = self.foodRepository:getRandomFoodName()
			local food = self.foodRepository:createFoodEntity(foodName)
			chair:spawnFood(food)
			self.remoteEventService:fireClient(chair.occupant, {
				eventName = self.constants.REMOTE_EVENTS.SPAWN_FOOD,
				data = {
					eatingType = food.eatingType,
				},
			})
		end
	end
end

return FoodService
