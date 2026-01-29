local BasePlayerService = require(script.Parent.BasePlayerService)

---@class BaseServerPlayerServiceConfig : BasePlayerServiceConfig
---@field coreSharedKey string?
---@field playerJoinedServerEvent string
---@field playerLeftServerEvent string
---@field playerJoinedRemoteEvent string
---@field playerLeftRemoteEvent string

---@class BaseMinigameServerPlayerService : BaseMinigamePlayerService
local PlayerService = setmetatable({}, BasePlayerService)
PlayerService.__index = PlayerService

function PlayerService.new(diContainer, config)
	local self = setmetatable(BasePlayerService.new(diContainer, config), PlayerService)
	self._connections = {}
	self.config.coreSharedKey = self.config.coreSharedKey or "CoreShared"
	return self
end

function PlayerService:init()
	BasePlayerService.init(self)

	local coreShared = self.diContainer:resolve(self.config.coreSharedKey)
	self.coreConstants = coreShared.constants
	self.coreEventBus = coreShared.eventBus

	self:_setupEventListeners()
	self:_setupRemoteEventListeners()
end

function PlayerService:_setupEventListeners()
	local events = {
		[self.constants.SERVER_EVENTS[self.config.playerJoinedServerEvent]] = function(data)
			self:onPlayerJoined(data)
		end,
		[self.constants.SERVER_EVENTS[self.config.playerLeftServerEvent]] = function(data)
			self:onPlayerLeft(data)
		end,
		[self.constants.SERVER_EVENTS.ADD_SCORE] = function(data)
			self:onAddScore(data)
		end,
	}

	local additionalEvents = self:_getAdditionalEventListeners()
	if additionalEvents then
		for event, handler in additionalEvents do
			events[event] = handler
		end
	end

	self.eventBus:connectToEvents(events)
end

function PlayerService:_getAdditionalEventListeners()
	return nil
end

function PlayerService:_setupRemoteEventListeners() end

function PlayerService:onPlayerJoined(data)
	local player = data.player
	if not player then
		return
	end

	self.playerRepository:createPlayerEntity(player)

	local cameraMode, cameraCFrame = self:getCameraMode(data)
	self.coreEventBus:fire(self.coreConstants.SERVER_EVENTS.SET_PLAYER_CAMERA_MODE, {
		player = player,
		mode = cameraMode,
		cameraCFrame = cameraCFrame,
	})

	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS[self.config.playerJoinedRemoteEvent],
		data = self:getPlayerJoinedData(data),
	})

	self:_afterPlayerJoined(data)
end

function PlayerService:getCameraMode(data)
	return self.coreConstants.CAMERA_MODES.DEFAULT, data.cameraCFrame
end

function PlayerService:getPlayerJoinedData(data)
	return {}
end

function PlayerService:_afterPlayerJoined(data) end

function PlayerService:onPlayerLeft(data)
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
		eventName = self.constants.REMOTE_EVENTS[self.config.playerLeftRemoteEvent],
		data = self:getPlayerLeftData(data),
	})

	self:_afterPlayerLeft(data)
end

function PlayerService:getPlayerLeftData(data)
	return {}
end

function PlayerService:_afterPlayerLeft(data) end

function PlayerService:onAddScore(data)
	local player = data.player
	local score = data.score
	if not player then
		return
	end

	local playerEntity = self.playerRepository:getPlayerEntity(player)
	playerEntity:addScore(score)
end

function PlayerService:finish()
	self:_calculateReward()
end

function PlayerService:_calculateReward()
	local players = self.playerRepository:getPlayers()
	for _, playerEntity in players do
		local score = playerEntity.score.Value
		local reward = self:calculatePlayerReward(playerEntity, score)

		if reward then
			self.coreEventBus:fire(self.coreConstants.SERVER_EVENTS.REWARD_PLAYER, {
				player = playerEntity.player,
				reward = reward,
			})
		end
	end
end

function PlayerService:calculatePlayerReward(playerEntity, score)
	return nil
end

return PlayerService
