local Repositories = require(script.Repositories)		

---@class DungeonCleaningClientInfrastructure
---@field repositories ClientDungeonCleaningRepositories
local Infrastructure = {}
Infrastructure.__index = Infrastructure 

---@param diContainer DIContainer
---@return DungeonCleaningClientInfrastructure
function Infrastructure.new(diContainer)
	local self = setmetatable({}, Infrastructure)
	self.repositories = Repositories.new(diContainer)
	return self
end

function Infrastructure:init()
	self.repositories:init()
end

return Infrastructure