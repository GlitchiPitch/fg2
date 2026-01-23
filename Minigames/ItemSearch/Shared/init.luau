---@class ItemSearchShared
local Shared = {}
Shared.__index = Shared

---@return ItemSearchShared
function Shared.new()
	local self = setmetatable({}, Shared)

	return self
end

return Shared