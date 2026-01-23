local PlayerRepository = require(script.PlayerRepository)

---@class ClientRepositories
---@field playerRepository ClientPlayerRepository
local Repositories = {}
Repositories.__index = Repositories

---@param diContainer DIContainer
---@return ClientRepositories
function Repositories.new(diContainer)
	local self = setmetatable({}, Repositories)
	self.playerRepository = PlayerRepository.new(diContainer)
	return self
end

function Repositories:init()
	self.playerRepository:init()
end

return Repositories
