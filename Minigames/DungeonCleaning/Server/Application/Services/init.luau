local EnemyService = require(script.EnemyService)
local PlayerService = require(script.PlayerService)
local BuildingService = require(script.BuildingService)

---@class ServerDungeonCleaningAppServices
---@field playerService ServerDungeonCleaningPlayerService
---@field enemyService ServerDungeonCleaningEnemyService
---@field buildingService ServerDungeonCleaningBuildingService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ServerDungeonCleaningAppServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
    self.playerService = PlayerService.new(diContainer)
    self.enemyService = EnemyService.new(diContainer)
    self.buildingService = BuildingService.new(diContainer)
	return self
end

function Services:init()
    self.playerService:init()
    self.enemyService:init()
    self.buildingService:init()
end

function Services:start()
    self.enemyService:start()
end

return Services