---@class RacingClientInfrastructure
local Infrastructure = {}
Infrastructure.__index = Infrastructure 

---@param diContainer DIContainer
---@return RacingClientInfrastructure
function Infrastructure.new(diContainer)
	local self = setmetatable({}, Infrastructure)
	return self
end

function Infrastructure:init()
end

return Infrastructure