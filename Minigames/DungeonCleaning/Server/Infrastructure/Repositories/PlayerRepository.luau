local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedShootingPlayerRepository = require(ReplicatedStorage.Minigames.DungeonCleaning.Infrastructure.Repositories.PlayerRepository)

---@class ServerDungeonCleaningPlayerRepository : SharedDungeonCleaningPlayerRepository
local PlayerRepository = setmetatable({}, SharedShootingPlayerRepository)
PlayerRepository.__index = PlayerRepository

---@param diContainer DIContainer
---@return ServerDungeonCleaningPlayerRepository
function PlayerRepository.new(diContainer)
	local self = setmetatable(SharedShootingPlayerRepository.new(diContainer), PlayerRepository)
	return self
end

function PlayerRepository:init()
	SharedShootingPlayerRepository.init(self)
end

return PlayerRepository
