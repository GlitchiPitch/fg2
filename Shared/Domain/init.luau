local Entities = require(script.Entities)
---@class Domain
---@field Entities Entities
local Domain = {}
Domain.__index = Domain

---@return Domain
function Domain.new()
    local self = setmetatable({}, Domain)
    self.Entities = Entities
    return self
end

return Domain
