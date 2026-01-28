---@class ClientFoodServiceService
local FoodService = {}
FoodService.__index = FoodService

---@param diContainer DIContainer
---@return ClientFoodServiceService
function FoodService.new(diContainer)
	local self = setmetatable({}, FoodService)
	self.diContainer = diContainer
	return self
end

function FoodService:init()
    ---@type SharedFoodEating
    local shared = self.diContainer:resolve("Shared")
    self.constants = shared.constants
    self.remoteEventService = shared.remoteEventService
    self.eventBus = shared.eventBus

    self:_setupRemoteEventListeners()
end

function FoodService:_setupRemoteEventListeners()
    self.remoteEventService:connectToEvents({
        [self.constants.REMOTE_EVENTS.SPAWN_FOOD] = function(data)
            self:onSpawnFood(data)
        end,
    })
end

function FoodService:onSpawnFood(data)
    local eatingType = data.eatingType
    self.eventBus:fire(self.constants.CLIENT_EVENTS.SPAWN_FOOD, {
        eatingType = eatingType,
    })
end

return FoodService