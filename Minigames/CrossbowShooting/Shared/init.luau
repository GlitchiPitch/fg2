local Constants = require(script.Constants)

---@class CrossbowShootingShared
---@field constants CrossbowShootingConstants
local Shared = {}
Shared.__index = Shared

---@return CrossbowShootingShared
function Shared.new()
	local self = setmetatable({}, Shared)
	self.constants = Constants
	return self
end

return Shared