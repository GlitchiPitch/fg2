local EnemyRepository = require(script.EnemyRepository)
local PlayerRepository = require(script.PlayerRepository)
local BuildingRepository = require(script.BuildingRepository)

---@class ServerDungeonCleaningRepositories 
---@field enemyRepository ServerDungeonCleaningEnemyRepository
---@field playerRepository ServerDungeonCleaningPlayerRepository
---@field buildingRepository ServerDungeonCleaningBuildingRepository
local Repositories = {}
Repositories.__index = Repositories

---@param diContainer DIContainer
---@return ServerDungeonCleaningRepositories
function Repositories.new(diContainer)
	local self = setmetatable({}, Repositories)
    self.diContainer = diContainer
    self.enemyRepository = EnemyRepository.new(diContainer)
    self.playerRepository = PlayerRepository.new(diContainer)
    self.buildingRepository = BuildingRepository.new(diContainer)
	return self
end

function Repositories:init()
    self.enemyRepository:init()
    self.playerRepository:init()
    self.buildingRepository:init()
end

return Repositories