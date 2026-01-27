---@class ServerFoodEatingPlayerService
local PlayerService = {}
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ServerFoodEatingPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable({}, PlayerService)
    self.diContainer = diContainer
	return self
end

function PlayerService:init()
    ---@type Shared
    local coreShared = self.diContainer:resolve("CoreShared")
    self.coreConstants = coreShared.constants
    self.coreEventBus = coreShared.eventBus
    ---@type SharedFoodEating
    local shared = self.diContainer:resolve("Shared")
    self.constants = shared.constants
    self.eventBus = shared.eventBus
	
    self:_setupEventListeners()
end

function PlayerService:_setupEventListeners()
    self.eventBus:connectToEvents({
        [self.constants.SERVER_EVENTS.PLAYER_JOINED_FOOD_EATING] = function(data)
            self:_onPlayerJoinedFoodEating(data)
        end,
        [self.constants.SERVER_EVENTS.PLAYER_LEFT_FOOD_EATING] = function(data)
            self:_onPlayerLeftFoodEating(data)
        end,
    })
end

function PlayerService:_onPlayerJoinedFoodEating(data)
    local player = data.player
    if not player then
        return
    end

    self.coreEventBus:fire(self.coreConstants.SERVER_EVENTS.SET_PLAYER_CAMERA_MODE, {
		player = player,
		mode = self.coreConstants.CAMERA_MODES.FIXED,
	})
end

function PlayerService:_onPlayerLeftFoodEating(data)
    local player = data.player
    if not player then
        return
    end
    
end

return PlayerService