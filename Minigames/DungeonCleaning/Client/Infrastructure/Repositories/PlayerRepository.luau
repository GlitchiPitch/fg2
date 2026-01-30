local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedDungeonCleaningPlayerRepository =
	require(ReplicatedStorage.Minigames.DungeonCleaning.Infrastructure.Repositories.PlayerRepository)

---@class ClientDungeonCleaningPlayerRepository : SharedDungeonCleaningPlayerRepository
local PlayerRepository = setmetatable({}, SharedDungeonCleaningPlayerRepository)
PlayerRepository.__index = PlayerRepository

---@param diContainer DIContainer
---@return ClientDungeonCleaningPlayerRepository
function PlayerRepository.new(diContainer)
	local self = setmetatable(SharedDungeonCleaningPlayerRepository.new(diContainer), PlayerRepository)
	return self
end

function PlayerRepository:init()
	SharedDungeonCleaningPlayerRepository.init(self)
end

return PlayerRepository
