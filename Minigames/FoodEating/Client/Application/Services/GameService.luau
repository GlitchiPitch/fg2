---@class ClientFoodEatingGameService
local GameService = {}
GameService.__index = GameService

---@param diContainer DIContainer
---@return ClientFoodEatingGameService
function GameService.new(diContainer)
	local self = setmetatable({}, GameService)
	self.diContainer = diContainer
	self._connections = {}
	return self
end

function GameService:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	self.gameEntity = shared.domain.Entities.Game.new()

    self:_setupEventListeners()
end

function GameService:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.CLIENT_EVENTS.PLAYER_JOINED_FOOD_EATING] = function()
			self:onPlayerJoinedFoodEating()
		end,
		[self.constants.CLIENT_EVENTS.PLAYER_LEFT_FOOD_EATING] = function()
			self:onPlayerLeftFoodEating()
		end,
	})
end

function GameService:onPlayerJoinedFoodEating()
	self._connections.timeChanged = self.gameEntity.time.Changed:Connect(function()
		self.eventBus:fire(self.constants.CLIENT_EVENTS.UPDATE_TIME, { time = self.gameEntity.time.Value })
	end)

	self.eventBus:fire(self.constants.CLIENT_EVENTS.UPDATE_TIME, { time = self.gameEntity.time.Value })
end

function GameService:onPlayerLeftFoodEating()
	if self._connections.timeChanged then
		self._connections.timeChanged:Disconnect()
		self._connections.timeChanged = nil
	end
end


return GameService
