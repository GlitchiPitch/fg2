-- Minigames/FoodEating/Shared/Infrastructure/Repositories/PlayerRepository.luau
-- BACKUP: Rename old file to PlayerRepository.backup.luau first!

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BasePlayerRepository = require(ReplicatedStorage.Shared.Minigame.Infrastruture.Repositories.BasePlayerRepository)

---@class SharedFoodEatingPlayerRepository : BaseMinigamePlayerRepository
local PlayerRepository = setmetatable({}, BasePlayerRepository)
PlayerRepository.__index = PlayerRepository

function PlayerRepository.new(diContainer)
	local self = setmetatable(BasePlayerRepository.new(diContainer, { sharedKey = "Shared" }), PlayerRepository)
	return self
end

function PlayerRepository:init()
	BasePlayerRepository.init(self)
end

return PlayerRepository
