local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedShootingPlayerService = require(ReplicatedStorage.Minigames.Shooting.Application.Services.PlayerService)
---@class ShootingClientPlayerService : SharedShootingPlayerService
---@field player Player
---@field constants ShootingConstants
---@field eventBus EventBus
---@field remoteEventService RemoteEventService
local PlayerService = setmetatable({}, SharedShootingPlayerService)
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ShootingClientPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable(SharedShootingPlayerService.new(diContainer), PlayerService)
	return self
end
function PlayerService:init()
	SharedShootingPlayerService.init(self)

	---@type ClientApp
	local coreApplication = self.diContainer:resolve("CoreApplication")
	self.player = coreApplication.services.playerService.player

	self.remoteEventService:connectToEvents({
		[self.constants.REMOTE_EVENTS.PLAYER_JOINED_BALISTA] = function(eventData)
			self:onPlayerJoinedBalista(eventData.data)
		end,
		[self.constants.REMOTE_EVENTS.PLAYER_LEFT_BALISTA] = function(eventData)
			self:onPlayerLeftBalista(eventData.data)
		end,
		[self.constants.REMOTE_EVENTS.PLAYER_ADDED_TO_GAME] = function(eventData)
			self:onPlayerAddedToGame(eventData.data)
		end,
		[self.constants.REMOTE_EVENTS.ADD_SCORE] = function(eventData)
			self:onAddScore(eventData.data)
		end,
		[self.constants.REMOTE_EVENTS.UPDATE_PLAYER] = function(eventData)
			self:onUpdatePlayer(eventData.data)
		end,
	})
end

---@class clientOnPlayerJoinedBalistaData
---@field balista table

---@param data clientOnPlayerJoinedBalistaData
function PlayerService:onPlayerJoinedBalista(data)
	for _, v in self.player.Character:GetDescendants() do
		if v:IsA("BasePart") then
			v.Transparency = 1
		end
	end

	self.eventBus:fire(self.constants.CLIENT_EVENTS.PLAYER_JOINED_BALISTA, data)
end

---@param data table
function PlayerService:onPlayerLeftBalista(data)
	for _, v in self.player.Character:GetDescendants() do
		if v:IsA("BasePart") then
			v.Transparency = if v.Name == "HumanoidRootPart" then 1 else 0
		end
	end

	self.eventBus:fire(self.constants.CLIENT_EVENTS.PLAYER_LEFT_BALISTA, data)
end

---@param data onAddScoreData
function PlayerService:onAddScore(data)
	self.eventBus:fire(self.constants.CLIENT_EVENTS.ADD_SCORE, data)
end

---@param data table
function PlayerService:onPlayerAddedToGame(data)
	local playerEntity = self.playerRepository:getPlayerEntity(self.player)
	playerEntity:fromData(data)
end

---@param data table
function PlayerService:onUpdatePlayer(data)
	local playerEntity = self.playerRepository:getPlayerEntity(self.player)
	playerEntity:fromData(data)
end

function PlayerService:getPlayerEntity()
	return self.playerRepository:getPlayerEntity(self.player)
end

return PlayerService
