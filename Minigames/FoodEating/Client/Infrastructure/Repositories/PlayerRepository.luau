local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedFoodEatingPlayerRepository = require(ReplicatedStorage.Minigames.FoodEating.Infrastructure.Repositories.PlayerRepository)

---@class ClientFoodEatingPlayerRepository : SharedFoodEatingPlayerRepository
local PlayerRepository = setmetatable({}, SharedFoodEatingPlayerRepository)
PlayerRepository.__index = PlayerRepository

---@param diContainer DIContainer
---@return ClientFoodEatingPlayerRepository
function PlayerRepository.new(diContainer)
	local self = setmetatable(SharedFoodEatingPlayerRepository.new(diContainer), PlayerRepository)
	return self
end

function PlayerRepository:init()
	SharedFoodEatingPlayerRepository.init(self)
end

return PlayerRepository
