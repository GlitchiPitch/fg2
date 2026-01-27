---@class ServerFoodEatingFoodController
---@field diContainer DIContainer
---@field foodService ServerFoodEatingFoodService
---@field eventBus EventBus
---@field constants SharedFoodEatingConstants
local FoodController = {}
FoodController.__index = FoodController

---@param diContainer DIContainer
---@return ServerFoodEatingFoodController
function FoodController.new(diContainer)
	local self = setmetatable({}, FoodController)
	self.diContainer = diContainer
	self._deltaTime = 0
    self._updateInterval = 1
	return self
end

function FoodController:init()
    ---@type SharedFoodEating
    local shared = self.diContainer:resolve("Shared")
    
    self.constants = shared.constants
    self.eventBus = shared.eventBus
end
function FoodController:update(deltaTime)
    self._deltaTime += deltaTime
    if self._deltaTime >= self._updateInterval then
        self._deltaTime = 0
        self:spawnFood()
    end
end

function FoodController:spawnFood()
    self.eventBus:fire(self.constants.SERVER_EVENTS.SPAWN_FOOD)
end

return FoodController