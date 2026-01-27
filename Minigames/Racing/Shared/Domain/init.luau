local Entities = require(script.Entities)

---@class SharedRacingDomain
---@field Entities SharedRacingEntities
local Domain = {}
Domain.__index = Domain

---@return SharedRacingDomain
function Domain.new()
	local self = setmetatable({}, Domain)
	self.Entities = Entities
	return self
end

return Domain