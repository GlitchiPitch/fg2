local Repositories = require(script.Repositories)

---@class ServerShootingInfrastructure
---@field diContainer DIContainer
---@field repositories ServerShootingRepositories
local Infrastructure = {}
Infrastructure.__index = Infrastructure

---@param diContainer DIContainer
---@return ServerShootingInfrastructure
function Infrastructure.new(diContainer)
	local self = setmetatable({}, Infrastructure)
	self.diContainer = diContainer
	self.repositories = Repositories.new(diContainer)
	return self
end

function Infrastructure:init()
	self.repositories:init()
end

return Infrastructure
