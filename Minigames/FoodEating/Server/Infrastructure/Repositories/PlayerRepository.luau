local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedFoodEatingPlayerRepository = require(ReplicatedStorage.Minigames.FoodEating.Infrastructure.Repositories.PlayerRepository)

---@class ServerFoodEatingPlayerRepository : SharedFoodEatingPlayerRepository
local PlayerRepository = setmetatable({}, SharedFoodEatingPlayerRepository)
PlayerRepository.__index = PlayerRepository

---@param diContainer DIContainer
---@return ServerFoodEatingPlayerRepository
function PlayerRepository.new(diContainer)
	local self = setmetatable(SharedFoodEatingPlayerRepository.new(diContainer), PlayerRepository)
	return self
end

function PlayerRepository:init()
	SharedFoodEatingPlayerRepository.init(self)
end

return PlayerRepository
