local Repositories = require(script.Repositories)

---@class ServerFoodEatingInfrastructure
---@field diContainer DIContainer
---@field repositories ServerFoodEatingRepositories
local Infrastructure = {}
Infrastructure.__index = Infrastructure

---@param diContainer DIContainer
---@return ServerFoodEatingInfrastructure
function Infrastructure.new(diContainer)
	local self = setmetatable({}, Infrastructure)
    self.repositories = Repositories.new(diContainer)
	return self
end

function Infrastructure:init()
    self.repositories:init()
end

return Infrastructure