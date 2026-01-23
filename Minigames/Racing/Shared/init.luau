---@class RacingShared
local Shared = {}
Shared.__index = Shared

---@return RacingShared
function Shared.new()
	local self = setmetatable({}, Shared)

	return self
end

return Shared