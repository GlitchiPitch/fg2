local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BasePlayerRepository = require(ReplicatedStorage.Shared.Minigame.Infrastruture.Repositories.BasePlayerRepository)

---@class SharedDungeonCleaningPlayerRepository : BaseMinigamePlayerRepository
local PlayerRepository = setmetatable({}, BasePlayerRepository)
PlayerRepository.__index = PlayerRepository

---@param diContainer DIContainer
---@return SharedDungeonCleaningPlayerRepository
function PlayerRepository.new(diContainer)
	local self = setmetatable(BasePlayerRepository.new(diContainer, { sharedKey = "Shared" }), PlayerRepository)
	return self
end

function PlayerRepository:init()
	BasePlayerRepository.init(self)
end

return PlayerRepository
