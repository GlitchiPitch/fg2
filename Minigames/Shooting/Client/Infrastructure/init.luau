local Repositories = require(script.Repositories)

---@class ClientShootingInfrastructure
---@field diContainer DIContainer
---@field repositories ClientShootingRepositories
local Infrastructure = {}
Infrastructure.__index = Infrastructure

---@param diContainer DIContainer
---@return ClientShootingInfrastructure
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
