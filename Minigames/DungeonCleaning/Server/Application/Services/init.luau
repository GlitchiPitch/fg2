local EnemyService = require(script.EnemyService)
local PlayerService = require(script.PlayerService)
local BuildingService = require(script.BuildingService)
local GameService = require(script.GameService)
local ToolService = require(script.ToolService)
local LootService = require(script.LootService)
---@class ServerDungeonCleaningAppServices
---@field playerService ServerDungeonCleaningPlayerService
---@field enemyService ServerDungeonCleaningEnemyService
---@field buildingService ServerDungeonCleaningBuildingService
---@field gameService ServerDungeonCleaningGameService
---@field toolService ServerDungeonCleaningToolService
---@field lootService ServerDungeonCleaningLootService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ServerDungeonCleaningAppServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
    self.playerService = PlayerService.new(diContainer)
    self.enemyService = EnemyService.new(diContainer)
    self.buildingService = BuildingService.new(diContainer)
    self.gameService = GameService.new(diContainer)
    self.toolService = ToolService.new(diContainer)
    self.lootService = LootService.new(diContainer)
	return self
end

function Services:init()
    self.playerService:init()
    self.enemyService:init()
    self.buildingService:init()
    self.gameService:init()
    self.toolService:init()
    self.lootService:init()
end

function Services:start()
    self.enemyService:start()
    self.gameService:start()
end

return Services