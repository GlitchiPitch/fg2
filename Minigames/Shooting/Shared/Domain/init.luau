local Entities = require(script.Entities)

---@class ShootingSharedDomain
---@field Entities ShootingSharedEntities
local Domain = {}
Domain.__index = Domain

---@return ShootingSharedDomain
function Domain.new()
	local self = setmetatable({}, Domain)
	self.Entities = Entities
	return self
end

return Domain