---@class CrossbowShootingClientInfrastructure
local Infrastructure = {}
Infrastructure.__index = Infrastructure 

---@param diContainer DIContainer
---@return CrossbowShootingClientInfrastructure
function Infrastructure.new(diContainer)
	local self = setmetatable({}, Infrastructure)
    self.diContainer = diContainer
	return self
end

function Infrastructure:init()
end

return Infrastructure