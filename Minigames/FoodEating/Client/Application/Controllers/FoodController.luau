---@class ClientFoodEatingFoodController
local FoodController = {}
FoodController.__index = FoodController

---@param diContainer DIContainer
---@return ClientFoodEatingFoodController
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
        self:updateMinigame()
    end
end

function FoodController:updateMinigame()
    self.eventBus:fire(self.constants.CLIENT_EVENTS.UPDATE_MINIGAME, {})
end

return FoodController