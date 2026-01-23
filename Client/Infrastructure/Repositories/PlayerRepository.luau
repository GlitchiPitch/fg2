local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedPlayerRepository = require(ReplicatedStorage.Shared.Infrastructure.Repositories.PlayerRepository)

---@class ClientPlayerRepository : SharedPlayerRepository
local PlayerRepository = setmetatable({}, SharedPlayerRepository)
PlayerRepository.__index = PlayerRepository

---@param diContainer DIContainer
---@return ClientPlayerRepository
function PlayerRepository.new(diContainer)
	local self = setmetatable(SharedPlayerRepository.new(diContainer), PlayerRepository)
	return self
end

function PlayerRepository:init()
	SharedPlayerRepository.init(self)
end

function PlayerRepository:updatePlayer(player)
	print("updatePlayer", player)
end

return PlayerRepository
