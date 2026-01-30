local HttpService = game:GetService("HttpService")
---@class ServerDungeonCleaningBuildingRepository
---@field diContainer DIContainer
---@field buildingEntity BuildingEntity
---@field data SharedDungeonCleaningData
local BuildingRepository = {}
BuildingRepository.__index = BuildingRepository

---@param diContainer DIContainer
---@return ServerDungeonCleaningBuildingRepository
function BuildingRepository.new(diContainer)
	local self = setmetatable({}, BuildingRepository)
    self.diContainer = diContainer
    self.buildings = {}
	return self
end

function BuildingRepository:init()
    ---@type SharedDungeonCleaning
    local shared = self.diContainer:resolve("Shared")
    self.buildingEntity = shared.domain.Entities.Building
    self.data = shared.data
end

---@param id string
---@return BuildingEntity
function BuildingRepository:getBuildingEntity(id)
    return self.buildings[id]
end

---@param building Model
---@return BuildingEntity
function BuildingRepository:createBuildingEntity(building)
    local buildingData = self.data[building.Name]
    if not buildingData then
        error(`Building {building.Name} not found`)
    end
    
    local id = HttpService:GenerateGUID(false)
    local buildingEntity = self.buildingEntity.new({
        id = id,
        model = buildingData.model,
        score = buildingData.score,
    })
    
    self.buildings[buildingEntity.id] = buildingEntity
    return buildingEntity
end

return BuildingRepository