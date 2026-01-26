---@class SharedShootingPlayerRepository
local PlayerRepository = {}
PlayerRepository.__index = PlayerRepository

---@param diContainer DIContainer
---@return SharedShootingPlayerRepository
function PlayerRepository.new(diContainer)
	local self = setmetatable({}, PlayerRepository)
	self.diContainer = diContainer
	self.playerEntities = {}
	return self
end

function PlayerRepository:init()
	---@type SharedShooting
	local shared = self.diContainer:resolve("Shared")
	self.playerEntity = shared.domain.Entities.Player
end

function PlayerRepository:createPlayerEntity(player)
	return self.playerEntity.new(player)
end

---@param player Player
---@return ShootingPlayerEntity
function PlayerRepository:getPlayerEntity(player)
	
	if not self.playerEntities[player.UserId] then
		self.playerEntities[player.UserId] = self:createPlayerEntity(player)
	end

	return self.playerEntities[player.UserId]
end

---@param player Player
function PlayerRepository:removePlayerEntity(player)
	self.playerEntities[player.UserId] = nil
end

return PlayerRepository