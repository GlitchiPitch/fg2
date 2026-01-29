local HttpService = game:GetService("HttpService")
---@class ServerDungeonCleaningEnemyRepository
---@field diContainer DIContainer
---@field enemyEntity EnemyEntity
---@field data SharedDungeonCleaningData
local EnemyRepository = {}
EnemyRepository.__index = EnemyRepository

---@param diContainer DIContainer
---@return ServerDungeonCleaningEnemyRepository
function EnemyRepository.new(diContainer)
	local self = setmetatable({}, EnemyRepository)
    self.diContainer = diContainer
    self.enemies = {}
	return self
end

function EnemyRepository:init()
    ---@type SharedDungeonCleaning
    local shared = self.diContainer:resolve("Shared")
    self.enemyEntity = shared.domain.Entities.Enemy
    self.data = shared.data
end

---@param id string
---@return EnemyEntity
function EnemyRepository:getEnemyEntity(id)
    return self.enemies[id]
end

---@param enemyName string
---@return EnemyEntity
function EnemyRepository:createEnemyEntity(enemyName)
    local enemyData = self.data[enemyName]
    local id = HttpService:GenerateGUID(false)
    
    local enemyEntity = self.enemyEntity.new({
        id = id,
        model = enemyData.model,
        score = enemyData.score,
    })

    self.enemies[enemyEntity.id] = enemyEntity
    return enemyEntity
end

---@param id string
function EnemyRepository:removeEnemyEntity(id)
    self.enemies[id] = nil
end

return EnemyRepository