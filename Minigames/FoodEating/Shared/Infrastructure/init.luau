local Repositories = require(script.Repositories)

---@class SharedFoodEatingInfrastructure
---@field repositories SharedFoodEatingRepositories
local Infrastructure = {}
Infrastructure.__index = Infrastructure

---@param diContainer DIContainer
---@return SharedFoodEatingInfrastructure
function Infrastructure.new(diContainer)
	local self = setmetatable({}, Infrastructure)
    self.repositories = Repositories.new(diContainer)
	self.diContainer = diContainer
	return self
end

function Infrastructure:init()
	self.repositories:init()
end

return Infrastructure