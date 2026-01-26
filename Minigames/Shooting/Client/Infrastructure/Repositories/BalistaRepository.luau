local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedBalistaRepository =
	require(ReplicatedStorage.Minigames.Shooting.Infrastructure.Repositories.BalistaRepository)

---@class ClientShootingBalistaRepository : SharedShootingBalistaRepository
---@field ballistaId string
local BalistaRepository = setmetatable({}, SharedBalistaRepository)
BalistaRepository.__index = BalistaRepository

---@param diContainer DIContainer
---@return ClientShootingBalistaRepository
function BalistaRepository.new(diContainer)
	local self = setmetatable(SharedBalistaRepository.new(diContainer), BalistaRepository)
	self.ballistaId = nil
	return self
end

function BalistaRepository:init()
	SharedBalistaRepository.init(self)
end

function BalistaRepository:setBallistaId(ballistaId)
	self.ballistaId = ballistaId
end

return BalistaRepository
