---@class ClientFoodEatingPlayerService
---@field application FoodEatingClientApp
local PlayerService = {}
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ClientFoodEatingPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable({}, PlayerService)
	self.diContainer = diContainer
	return self
end

function PlayerService:init()
    ---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.eventBus = shared.eventBus
	self.constants = shared.constants
	self.remoteEventService = shared.remoteEventService

	---@type Shared
	local coreShared = self.diContainer:resolve("CoreShared")
	self.coreConstants = coreShared.constants
	self.coreEventBus = coreShared.eventBus

	self.application = self.diContainer:resolve("Application")
    self:_setupRemoteEventListeners()
	self:_setupEventListeners()
end

function PlayerService:onPlayerJoinedFoodEating()
	warn("onPlayerJoinedFoodEating")
	self.application:start()
	self.eventBus:fire(self.constants.CLIENT_EVENTS.PLAYER_JOINED_FOOD_EATING, {})
end

function PlayerService:onPlayerLeftFoodEating()
	warn("onPlayerLeftFoodEating")
	self.application:stop()
	self.eventBus:fire(self.constants.CLIENT_EVENTS.PLAYER_LEFT_FOOD_EATING, {})
end

function PlayerService:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.CLIENT_EVENTS.TOGGLE_TAPER_MINIGAME] = function(data)
			self:_onToggleTaperMinigame(data)
		end,
	})
end

function PlayerService:_setupRemoteEventListeners()
	self.remoteEventService:connectToEvents({
		[self.constants.REMOTE_EVENTS.PLAYER_JOINED_FOOD_EATING] = function()
			self:onPlayerJoinedFoodEating()
		end,
		[self.constants.REMOTE_EVENTS.PLAYER_LEFT_FOOD_EATING] = function()
			self:onPlayerLeftFoodEating()
		end,
	})
end

function PlayerService:_onToggleTaperMinigame(data)
	self.coreEventBus:fire(self.coreConstants.CLIENT_EVENTS.SET_FREE_MOUSE, data)
end

return PlayerService