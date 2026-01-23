---@class FoodEatingShared
local Shared = {}
Shared.__index = Shared

---@return FoodEatingShared
function Shared.new()
	local self = setmetatable({}, Shared)

	return self
end

return Shared