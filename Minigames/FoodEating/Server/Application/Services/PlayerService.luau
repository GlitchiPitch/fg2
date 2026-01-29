local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedFoodEatingPlayerService = require(ReplicatedStorage.Minigames.FoodEating.Application.Services.PlayerService)

---@class ServerFoodEatingPlayerService : SharedFoodEatingPlayerService
---@field diContainer DIContainer
---@field coreConstants SharedConstants
---@field coreEventBus EventBus
---@field constants SharedFoodEatingConstants
---@field eventBus EventBus
local PlayerService = setmetatable({}, SharedFoodEatingPlayerService)
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ServerFoodEatingPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable(SharedFoodEatingPlayerService.new(diContainer), PlayerService)
	self._connections = {}
	return self
end

function PlayerService:init()
	SharedFoodEatingPlayerService.init(self)
	---@type Shared
	local coreShared = self.diContainer:resolve("CoreShared")
	self.coreConstants = coreShared.constants
	self.coreEventBus = coreShared.eventBus

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
		[self.constants.SERVER_EVENTS.ADD_SCORE] = function(data)
			self:_onAddScore(data)
		end,
	})
end

function PlayerService:_onPlayerJoinedFoodEating(data)
	local player = data.player
	local cameraCFrame = data.cameraCFrame
	if not player then
		return
	end

	self.playerRepository:createPlayerEntity(player)

	self.coreEventBus:fire(self.coreConstants.SERVER_EVENTS.SET_PLAYER_CAMERA_MODE, {
		player = player,
		mode = self.coreConstants.CAMERA_MODES.FIXED,
		cameraCFrame = cameraCFrame,
	})

	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.PLAYER_JOINED_FOOD_EATING,
		data = {},
	})
end

function PlayerService:_onPlayerLeftFoodEating(data)
	local player = data.player
	if not player then
		return
	end

	self.playerRepository:removePlayerEntity(player)

	self.coreEventBus:fire(self.coreConstants.SERVER_EVENTS.SET_PLAYER_CAMERA_MODE, {
		player = player,
		mode = self.coreConstants.CAMERA_MODES.DEFAULT,
	})

	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.PLAYER_LEFT_FOOD_EATING,
		data = {},
	})
end

function PlayerService:_onAddScore(data)
	local player = data.player
	local score = data.score
	if not player then
		return
	end

	local playerEntity = self.playerRepository:getPlayerEntity(player)
	playerEntity:addScore(score)
end

return PlayerService
