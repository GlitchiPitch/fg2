local Repositories = require(script.Repositories)
---@class ClientFoodEatingInfrastructure
---@field repositories FoodEatingClientRepositories
local Infrastructure = {}
Infrastructure.__index = Infrastructure 

---@param diContainer DIContainer
---@return ClientFoodEatingInfrastructure
function Infrastructure.new(diContainer)
	local self = setmetatable({}, Infrastructure)
	self.repositories = Repositories.new(diContainer)
	return self
end

function Infrastructure:init()
	self.repositories:init()
end

return Infrastructure