local PlayerRepository = require(script.PlayerRepository)

---@class ServerRepositories
---@field playerRepository ServerPlayerRepository
local Repositories = {}
Repositories.__index = Repositories

---@param diContainer DIContainer
---@return ServerRepositories
function Repositories.new(diContainer)
	local self = setmetatable({}, Repositories)
	self.playerRepository = PlayerRepository.new(diContainer)
	return self
end

function Repositories:init()
	self.playerRepository:init()
end

return Repositories
