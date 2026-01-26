local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedShootingPlayerService = require(ReplicatedStorage.Minigames.Shooting.Application.Services.PlayerService)

---@class ServerShootingPlayerService : SharedShootingPlayerService
---@field diContainer DIContainer
---@field constants ShootingConstants
---@field eventBus EventBus
---@field coreEventBus EventBus
local PlayerService = setmetatable({}, SharedShootingPlayerService)
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ServerShootingPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable(SharedShootingPlayerService.new(diContainer), PlayerService)
	return self
end

function PlayerService:init()
	SharedShootingPlayerService.init(self)

	---@type SharedShooting
	local shared = self.diContainer:resolve("Shared")

	self.coreConstants = shared.coreConstants
	self.coreEventBus = shared.coreEventBus

	self.eventBus:connectToEvents({
		[self.constants.SERVER_EVENTS.PLAYER_JOINED_BALISTA] = function(data)
			self:onPlayerJoinedBalista(data)
		end,
		[self.constants.SERVER_EVENTS.PLAYER_LEFT_BALISTA] = function(data)
			self:onPlayerLeftBalista(data)
		end,
		[self.constants.SERVER_EVENTS.ADD_SCORE] = function(data)
			self:onAddScore(data)
		end,
	})
end

---@class onPlayerJoinedBalistaData
---@field player Player
---@field balista BalistaEntity

---@param data onPlayerJoinedBalistaData
function PlayerService:onPlayerJoinedBalista(data)
	local player = data.player
	local balista = data.balista

	local playerEntity = self.playerRepository:getPlayerEntity(player)

	self.coreEventBus:fire(self.coreConstants.SERVER_EVENTS.SET_PLAYER_CAMERA_MODE, {
		player = player,
		mode = self.coreConstants.CAMERA_MODES.FOLLOWING,
	})
	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.PLAYER_JOINED_BALISTA,
		data = balista,
	})

	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.PLAYER_ADDED_TO_GAME,
		data = playerEntity:toData(),
	})
end

---@class onPlayerLeftBalistaData
---@field player Player

---@param data onPlayerLeftBalistaData
function PlayerService:onPlayerLeftBalista(data)
	local player = data.player
	local balista = data.balista
	self.coreEventBus:fire(self.coreConstants.SERVER_EVENTS.SET_PLAYER_CAMERA_MODE, {
		player = player,
		mode = self.coreConstants.CAMERA_MODES.DEFAULT,
	})
	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.PLAYER_LEFT_BALISTA,
		data = balista,
	})
end

---@class onAddScoreData
---@field player Player
---@field score number

---@param data onAddScoreData
function PlayerService:onAddScore(data)
	local player = data.player
	local score = data.score
	local playerEntity = self.playerRepository:getPlayerEntity(player)
	playerEntity:addScore(score)
	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.ADD_SCORE,
		data = {
			score = score,
		},
	})
	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.UPDATE_PLAYER,
		data = playerEntity:toData(),
	})
end

return PlayerService
