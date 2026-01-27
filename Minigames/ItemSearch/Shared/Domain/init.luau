local Entities = require(script.Entities)

---@class SharedItemSearchDomain
---@field Entities SharedItemSearchEntities
local Domain = {}
Domain.__index = Domain

---@return SharedItemSearchDomain
function Domain.new()
	local self = setmetatable({}, Domain)
	self.Entities = Entities
	return self
end

return Domain