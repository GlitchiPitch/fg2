---@class SharedFoodEatingPlayerRepository
---@field playerEntities table<number, FoodEatingPlayerEntity>
local PlayerRepository = {}
PlayerRepository.__index = PlayerRepository

---@param diContainer DIContainer
---@return SharedFoodEatingPlayerRepository
function PlayerRepository.new(diContainer)
	local self = setmetatable({}, PlayerRepository)
	self.diContainer = diContainer
	self.playerEntities = {}
	return self
end

function PlayerRepository:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.playerEntity = shared.domain.Entities.Player
end

function PlayerRepository:createPlayerEntity(player)
	local playerEntity = self.playerEntity.new(player)
	self.playerEntities[player.UserId] = playerEntity
	return playerEntity
end

---@param player Player
---@return FoodEatingPlayerEntity
function PlayerRepository:getPlayerEntity(player)
	if not self.playerEntities[player.UserId] then
		self.playerEntities[player.UserId] = self:createPlayerEntity(player)
	end

	return self.playerEntities[player.UserId]
end

---@param player Player
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

return PlayerRepository
