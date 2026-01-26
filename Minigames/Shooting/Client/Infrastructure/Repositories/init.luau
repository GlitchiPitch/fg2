local BalistaRepository = require(script.BalistaRepository)
---@class ClientShootingRepositories
---@field balistaRepository ClientShootingBalistaRepository
local Repositories = {}
Repositories.__index = Repositories

---@param diContainer DIContainer
---@return ClientShootingRepositories
function Repositories.new(diContainer)
	local self = setmetatable({}, Repositories)
	self.balistaRepository = BalistaRepository.new(diContainer)
	return self
end

function Repositories:init()
	self.balistaRepository:init()
end

return Repositories