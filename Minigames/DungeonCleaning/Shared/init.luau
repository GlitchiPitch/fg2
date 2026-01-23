---@class DungeonCleaningShared
local Shared = {}
Shared.__index = Shared

---@return DungeonCleaningShared
function Shared.new()
	local self = setmetatable({}, Shared)

	return self
end

return Shared