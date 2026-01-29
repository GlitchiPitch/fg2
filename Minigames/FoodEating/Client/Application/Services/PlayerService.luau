local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedFoodEatingPlayerService = require(ReplicatedStorage.Minigames.FoodEating.Application.Services.PlayerService)

---@class ClientFoodEatingPlayerService : SharedFoodEatingPlayerService
---@field application ClientFoodEatingApp
local PlayerService = setmetatable({}, SharedFoodEatingPlayerService)
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ClientFoodEatingPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable(SharedFoodEatingPlayerService.new(diContainer), PlayerService)
	self._connections = {}
	return self
end

function PlayerService:getPlayerEntity()
	return self.playerRepository:getPlayerEntity(self.player)
end

function PlayerService:init()
	SharedFoodEatingPlayerService.init(self)

	---@type Shared
	local coreShared = self.diContainer:resolve("CoreShared")
	self.coreConstants = coreShared.constants
	self.coreEventBus = coreShared.eventBus

	---@type ClientApp
	local coreApplication = self.diContainer:resolve("CoreApplication")
	self.player = coreApplication.services.playerService.player

	self.application = self.diContainer:resolve("Application")
	self:_setupRemoteEventListeners()
	
end

function PlayerService:onPlayerJoinedFoodEating()
	self.playerRepository:createPlayerEntity(self.player)
	self:_setupPlayer()
	self.application:start()
	self.eventBus:fire(self.constants.CLIENT_EVENTS.PLAYER_JOINED_FOOD_EATING, {})
end

function PlayerService:onPlayerLeftFoodEating()
	self.application:stop()

	self.playerRepository:removePlayerEntity(self.player)
	self:_removePlayer()

	self.eventBus:fire(self.constants.CLIENT_EVENTS.PLAYER_LEFT_FOOD_EATING, {})
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

function PlayerService:_setupPlayer()
	local playerEntity = self.playerRepository:getPlayerEntity(self.player)

	self._connections.score = playerEntity.score.Changed:Connect(function(score)
		local oldValue = playerEntity.score:GetAttribute("OldValue")
		self.eventBus:fire(self.constants.CLIENT_EVENTS.UPDATE_SCORE, { score = score, addedScore = score - oldValue })
	end)
end

function PlayerService:_removePlayer()
	for _, connection in self._connections do
		connection:Disconnect()
	end
	self._connections = {}
end

return PlayerService
