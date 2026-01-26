local BalistaRepository = require(script.BalistaRepository)
local TargetRepository = require(script.TargetRepository)
local PlayerRepository = require(script.PlayerRepository)

---@class ServerShootingRepositories
---@field balistaRepository ServerShootingBalistaRepository
---@field targetRepository ServerShootingTargetRepository
---@field playerRepository ServerShootingPlayerRepository
local Repositories = {}
Repositories.__index = Repositories

---@param diContainer DIContainer
---@return ServerShootingRepositories
function Repositories.new(diContainer)
	local self = setmetatable({}, Repositories)
	self.diContainer = diContainer
	self.balistaRepository = BalistaRepository.new(diContainer)
	self.targetRepository = TargetRepository.new(diContainer)
	self.playerRepository = PlayerRepository.new(diContainer)
	return self
end

function Repositories:init()
	self.balistaRepository:init()
	self.targetRepository:init()
	self.playerRepository:init()
end

return Repositories
