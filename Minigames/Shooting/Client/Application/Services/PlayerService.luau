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
	self._connections = {}
	return self
end
function PlayerService:init()
	SharedShootingPlayerService.init(self)

	---@type ClientApp
	local coreApplication = self.diContainer:resolve("CoreApplication")
	self.player = coreApplication.services.playerService.player

	self:_setupRemoteEventListeners()
end

function PlayerService:_setupRemoteEventListeners()
	self.remoteEventService:connectToEvents({
		[self.constants.REMOTE_EVENTS.PLAYER_JOINED_BALISTA] = function(eventData)
			self:onPlayerJoinedBalista(eventData.data)
		end,
		[self.constants.REMOTE_EVENTS.PLAYER_LEFT_BALISTA] = function(eventData)
			self:onPlayerLeftBalista(eventData.data)
		end,
	})
end

---@class clientOnPlayerJoinedBalistaData
---@field balista table

---@param data clientOnPlayerJoinedBalistaData
function PlayerService:onPlayerJoinedBalista(data)
	self.playerRepository:createPlayerEntity(self.player)
	self:_setupPlayer()

	for _, v in self.player.Character:GetDescendants() do
		if v:IsA("BasePart") then
			v.Transparency = 1
		end
	end

	self.eventBus:fire(self.constants.CLIENT_EVENTS.PLAYER_JOINED_BALISTA, data)
end

---@param data table
function PlayerService:onPlayerLeftBalista(data)
	self.playerRepository:removePlayerEntity(self.player)
	self:_removePlayer()

	for _, v in self.player.Character:GetDescendants() do
		if v:IsA("BasePart") then
			v.Transparency = if v.Name == "HumanoidRootPart" then 1 else 0
		end
	end

	self.eventBus:fire(self.constants.CLIENT_EVENTS.PLAYER_LEFT_BALISTA, data)
end

function PlayerService:getPlayerEntity()
	return self.playerRepository:getPlayerEntity(self.player)
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
