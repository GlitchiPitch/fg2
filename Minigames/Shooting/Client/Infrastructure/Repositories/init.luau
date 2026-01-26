local BalistaRepository = require(script.BalistaRepository)
local PlayerRepository = require(script.PlayerRepository)

---@class ClientShootingRepositories
---@field balistaRepository ClientShootingBalistaRepository
---@field playerRepository ClientShootingPlayerRepository
local Repositories = {}
Repositories.__index = Repositories

---@param diContainer DIContainer
---@return ClientShootingRepositories
function Repositories.new(diContainer)
	local self = setmetatable({}, Repositories)
	self.balistaRepository = BalistaRepository.new(diContainer)
	self.playerRepository = PlayerRepository.new(diContainer)
	return self
end

function Repositories:init()
	self.balistaRepository:init()
	self.playerRepository:init()
end

return Repositories