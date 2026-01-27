local Entities = require(script.Entities)

---@class SharedFoodEatingDomain
---@field Entities SharedFoodEatingEntities
local Domain = {}
Domain.__index = Domain

---@return SharedFoodEatingDomain
function Domain.new()
	local self = setmetatable({}, Domain)
	self.Entities = Entities
	return self
end

return Domain