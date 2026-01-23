---@class CrossbowShootingShared
local Shared = {}
Shared.__index = Shared

---@return CrossbowShootingShared
function Shared.new()
	local self = setmetatable({}, Shared)
	return self
end

return Shared