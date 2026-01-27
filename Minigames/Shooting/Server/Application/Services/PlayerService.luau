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
	self._connections = {}
	return self
end

function PlayerService:init()
	SharedShootingPlayerService.init(self)

	---@type SharedShooting
	local shared = self.diContainer:resolve("Shared")

	self.coreConstants = shared.coreConstants
	self.coreEventBus = shared.coreEventBus

	self:_setupEventListeners()
	self:_setupRemoteEventListeners()
end

function PlayerService:_setupEventListeners()
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

function PlayerService:_setupRemoteEventListeners()

	self.remoteEventService:connectToEvents({
		[self.constants.REMOTE_EVENTS.SEND_CAMERA_CFRAME] = function(player, eventData)
			self:onSendCameraCFrame({ player = player, cameraCFrame = eventData.data.cameraCFrame })
		end,
	})
end

function PlayerService:onSendCameraCFrame(data)
	local player = data.player
	local cameraCFrame = data.cameraCFrame
	player:SetAttribute("CameraCFrame", cameraCFrame)
end

---@class onPlayerJoinedBalistaData
---@field player Player
---@field balista BalistaEntity

---@param data onPlayerJoinedBalistaData
function PlayerService:onPlayerJoinedBalista(data)
	local player = data.player
	local balista = data.balista

	self.playerRepository:createPlayerEntity(player)

	self.coreEventBus:fire(self.coreConstants.SERVER_EVENTS.SET_PLAYER_CAMERA_MODE, {
		player = player,
		mode = self.coreConstants.CAMERA_MODES.FOLLOWING,
	})
	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.PLAYER_JOINED_BALISTA,
		data = balista,
	})

	self._connections[player.UserId] = {
		player.Changed:Connect(function(property)
			if property == "Parent" then
				self:onPlayerLeftBalista({ player = player })
			end
		end),

		player.Character.Changed:Connect(function(property)
			if property == "Parent" then
				self:onPlayerLeftBalista({ player = player })
			end
		end),
	}
end

---@class onPlayerLeftBalistaData
---@field player Player

---@param data onPlayerLeftBalistaData
function PlayerService:onPlayerLeftBalista(data)
	local player = data.player
	local balista = data.balista

	self.playerRepository:removePlayerEntity(player)

	self.coreEventBus:fire(self.coreConstants.SERVER_EVENTS.SET_PLAYER_CAMERA_MODE, {
		player = player,
		mode = self.coreConstants.CAMERA_MODES.DEFAULT,
	})

	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.PLAYER_LEFT_BALISTA,
		data = balista,
	})

	for _, connection in self._connections[player.UserId] do
		connection:Disconnect()
	end

	self._connections[player.UserId] = nil
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
end

function PlayerService:finish() end

function PlayerService:_calculateReward()
	local players = self.playerRepository:getPlayers()
	---@param player ShootingPlayerEntity
	for _, playerEntity in players do
		local score = playerEntity.score.Value
		local reward = {
			points = score * self.constants.SCORE_REWARD_MULTIPLIER,
		}
		self.coreEventBus:fire(self.coreConstants.SERVER_EVENTS.REWARD_PLAYER, {
			player = playerEntity.player,
			reward = reward,
		})
	end
end

return PlayerService
