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

	self.application = self.diContainer:resolve("Application")
    self:_setupRemoteEventListeners()
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

function PlayerService:onPlayerJoinedFoodEating()
	warn("onPlayerJoinedFoodEating")
	self.eventBus:fire(self.constants.CLIENT_EVENTS.PLAYER_JOINED_FOOD_EATING, {})
	self.application:start()
end

function PlayerService:onPlayerLeftFoodEating()
	warn("onPlayerLeftFoodEating")
	self.eventBus:fire(self.constants.CLIENT_EVENTS.PLAYER_LEFT_FOOD_EATING, {})
	self.application:stop()
end

return PlayerService