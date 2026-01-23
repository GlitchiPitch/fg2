---@class FoodEatingClientInfrastructure
local Infrastructure = {}
Infrastructure.__index = Infrastructure 

---@param diContainer DIContainer
---@return FoodEatingClientInfrastructure
function Infrastructure.new(diContainer)
	local self = setmetatable({}, Infrastructure)
	return self
end

function Infrastructure:init()
end

return Infrastructure