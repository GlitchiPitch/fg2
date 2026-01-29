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