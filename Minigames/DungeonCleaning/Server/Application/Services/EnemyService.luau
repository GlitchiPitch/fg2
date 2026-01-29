---@class ServerDungeonCleaningEnemyService
local EnemyService = {}
EnemyService.__index = EnemyService

---@param diContainer DIContainer
---@return ServerDungeonCleaningEnemyService
function EnemyService.new(diContainer)
	local self = setmetatable({}, EnemyService)
    self.diContainer = diContainer
	return self
end

function EnemyService:init()
    ---@type ServerDungeonCleaningInfrastructure
    local infrastructure = self.diContainer:resolve("Infrastructure")
    self.enemyRepository = infrastructure.repositories.enemyRepository
end

function EnemyService:start()
    
end

function EnemyService:spawnEnemy()
    local enemyEntity = self.enemyRepository:createEnemyEntity("Alien")
    
end

return EnemyService