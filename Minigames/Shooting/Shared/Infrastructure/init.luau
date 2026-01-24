local Repositories = require(script.Repositories)

---@class SharedShootingInfrastructure
---@field diContainer DIContainer
---@field repositories SharedShootingRepositories
local Infrastructure = {}
Infrastructure.__index = Infrastructure

---@param diContainer DIContainer
---@return SharedShootingInfrastructure
function Infrastructure.new(diContainer)
	local self = setmetatable({}, Infrastructure)
	self.repositories = Repositories.new(diContainer)
	return self
end

function Infrastructure:init()
	self.repositories:init()
end

return Infrastructure
