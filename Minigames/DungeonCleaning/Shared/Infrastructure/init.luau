local Repositories = require(script.Repositories)
---@class SharedDungeonCleaningInfrastructure
---@field diContainer DIContainer
---@field repositories SharedDungeonCleaningRepositories
local Infrastructure = {}
Infrastructure.__index = Infrastructure

---@param diContainer DIContainer
---@return SharedDungeonCleaningInfrastructure
function Infrastructure.new(diContainer)
	local self = setmetatable({}, Infrastructure)
	self.repositories = Repositories.new(diContainer)
	return self
end

function Infrastructure:init()
	self.repositories:init()
end

return Infrastructure