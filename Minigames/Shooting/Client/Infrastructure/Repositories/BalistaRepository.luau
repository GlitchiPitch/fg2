local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedBalistaRepository =
	require(ReplicatedStorage.Minigames.Shooting.Infrastructure.Repositories.BalistaRepository)

---@class ClientShootingBalistaRepository : SharedShootingBalistaRepository
local BalistaRepository = setmetatable({}, SharedBalistaRepository)
BalistaRepository.__index = BalistaRepository

---@param diContainer DIContainer
---@return ClientShootingBalistaRepository
function BalistaRepository.new(diContainer)
	local self = setmetatable(SharedBalistaRepository.new(diContainer), BalistaRepository)
	return self
end

function BalistaRepository:init()
	SharedBalistaRepository.init(self)
end

return BalistaRepository
