local BalistaRepository = require(script.BalistaRepository)

---@class ServerShootingRepositories
---@field balistaRepository ServerShootingBalistaRepository
local Repositories = {}
Repositories.__index = Repositories

---@param diContainer DIContainer
---@return ServerShootingRepositories
function Repositories.new(diContainer)
	local self = setmetatable({}, Repositories)
	self.diContainer = diContainer
	self.balistaRepository = BalistaRepository.new(diContainer)
	return self
end

function Repositories:init()
	self.balistaRepository:init()
end

return Repositories
