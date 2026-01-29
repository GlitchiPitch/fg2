---@class SharedDungeonCleaningInfrastructure
local Infrastructure = {}
Infrastructure.__index = Infrastructure

---@return SharedDungeonCleaningInfrastructure
function Infrastructure.new()
	local self = setmetatable({}, Infrastructure)
	return self
end

return Infrastructure