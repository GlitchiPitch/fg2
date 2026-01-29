---@class BaseMinigamePlayerRepositoryConfig
---@field sharedKey string?

---@class BaseMinigamePlayerRepository
local PlayerRepository = {}
PlayerRepository.__index = PlayerRepository

function PlayerRepository.new(diContainer, config)
	local self = setmetatable({}, PlayerRepository)
	self.diContainer = diContainer
	self.config = config or {}
	self.config.sharedKey = self.config.sharedKey or "Shared"
	self.playerEntities = {}
	return self
end

function PlayerRepository:init()
	local shared = self.diContainer:resolve(self.config.sharedKey)
	self.playerEntity = shared.domain.Entities.Player
end

function PlayerRepository:createPlayerEntity(player)
	local playerEntity = self.playerEntity.new(player)
	self.playerEntities[player.UserId] = playerEntity
	return playerEntity
end

function PlayerRepository:getPlayerEntity(player)
	if not self.playerEntities[player.UserId] then
		self.playerEntities[player.UserId] = self:createPlayerEntity(player)
	end
	return self.playerEntities[player.UserId]
end

function PlayerRepository:removePlayerEntity(player)
	local playerEntity = self.playerEntities[player.UserId]
	if playerEntity then
		playerEntity:destroy()
	end
	self.playerEntities[player.UserId] = nil
end

function PlayerRepository:getPlayers()
	return self.playerEntities
end

function PlayerRepository:getPlayerCount()
	local count = 0
	for _ in self.playerEntities do
		count += 1
	end
	return count
end

function PlayerRepository:forEachPlayer(callback)
	for _, playerEntity in self.playerEntities do
		callback(playerEntity)
	end
end

return PlayerRepository
