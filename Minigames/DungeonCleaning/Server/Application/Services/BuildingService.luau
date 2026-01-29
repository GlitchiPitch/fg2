---@class ServerDungeonCleaningBuildingService
local BuildingService = {}
BuildingService.__index = BuildingService

---@param diContainer DIContainer
---@return ServerDungeonCleaningBuildingService
function BuildingService.new(diContainer)
	local self = setmetatable({}, BuildingService)
    self.diContainer = diContainer
	return self
end

function BuildingService:init()
    ---@type ServerDungeonCleaningInfrastructure
    local infrastructure = self.diContainer:resolve("Infrastructure")
    self.buildingRepository = infrastructure.repositories.buildingRepository
end

return BuildingService