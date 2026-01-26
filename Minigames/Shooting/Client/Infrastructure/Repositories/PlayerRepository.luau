local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedShootingPlayerRepository = require(ReplicatedStorage.Minigames.Shooting.Infrastructure.Repositories.PlayerRepository)

---@class ClientShootingPlayerRepository : SharedShootingPlayerRepository
local PlayerRepository = setmetatable({}, SharedShootingPlayerRepository)
PlayerRepository.__index = PlayerRepository

---@param diContainer DIContainer
---@return ClientShootingPlayerRepository
function PlayerRepository.new(diContainer)
	local self = setmetatable(SharedShootingPlayerRepository.new(diContainer), PlayerRepository)
	return self
end

function PlayerRepository:init()
	SharedShootingPlayerRepository.init(self)
end

return PlayerRepository
