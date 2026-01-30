local PlayerRepository = require(script.PlayerRepository)

---@class ClientDungeonCleaningRepositories
---@field playerRepository ClientDungeonCleaningPlayerRepository
local Repositories = {}
Repositories.__index = Repositories

---@param diContainer DIContainer
---@return ClientDungeonCleaningRepositories
function Repositories.new(diContainer)
	local self = setmetatable({}, Repositories)
	self.diContainer = diContainer
	self.playerRepository = PlayerRepository.new(diContainer)
	return self
end

function Repositories:init()
	self.playerRepository:init()
end

return Repositories
