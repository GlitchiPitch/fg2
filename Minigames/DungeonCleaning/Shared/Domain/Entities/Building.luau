---@class BuildingEntity
local Building = {}
Building.__index = Building

---@class buildingData
---@field id string
---@field model Model
---@field score number

---@param buildingData buildingData
---@return BuildingEntity
function Building.new(buildingData)
	local self = setmetatable({}, Building)
    self.id = buildingData.id
    self.model = buildingData.model
    self.score = buildingData.score
	return self
end

return Building