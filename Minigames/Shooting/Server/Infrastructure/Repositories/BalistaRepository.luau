---@class ServerShootingBalistaRepository
---@field diContainer DIContainer
---@field balistaEntity BalistaEntity
local BalistaRepository = {}
BalistaRepository.__index = BalistaRepository

---@param diContainer DIContainer
---@return ServerShootingBalistaRepository
function BalistaRepository.new(diContainer)
	local self = setmetatable({}, BalistaRepository)
	self.diContainer = diContainer
	self.balistaEntities = {}
	return self
end

function BalistaRepository:init()
    ---@type ShootingShared
    local shared = self.diContainer:resolve("Shared")
    self.balistaEntity = shared.domain.Entities.Balista
end

---@param balista Model
---@return BalistaEntity
function BalistaRepository:getBalistaEntity(balista)
    if not self.balistaEntities[balista.Name] then
        self.balistaEntities[balista.Name] = self.balistaEntity.new(balista)
    end

    return self.balistaEntities[balista.Name]
end

function BalistaRepository:removeBalistaEntity(balista)
    self.balistaEntities[balista.Name] = nil
end

---@return table<string, BalistaEntity>
function BalistaRepository:getBalistaEntities()
    return self.balistaEntities
end

return BalistaRepository