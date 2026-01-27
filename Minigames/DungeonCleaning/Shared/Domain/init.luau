local Entities = require(script.Entities)

---@class SharedDungeonCleaningDomain
---@field Entities SharedDungeonCleaningEntities
local Domain = {}
Domain.__index = Domain

---@return SharedDungeonCleaningDomain
function Domain.new()
	local self = setmetatable({}, Domain)
	self.Entities = Entities
	return self
end

return Domain