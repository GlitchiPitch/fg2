---@class SharedShootingBalistaRepository
---@field diContainer DIContainer
---@field balistaEntity BalistaEntity
local BalistaRepository = {}
BalistaRepository.__index = BalistaRepository

---@param diContainer DIContainer
---@return SharedShootingBalistaRepository
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

function BalistaRepository:createBalistaEntity(data)
	local balistaEntity = self.balistaEntity.new({
		id = data.id,
		model = data.model,
		ammo = data.ammo,
		isReloading = data.isReloading,
	})
	balistaEntity:init({
		destroyCallback = function()
			self:removeBalistaEntity(data.id)
		end,
	})
	self.balistaEntities[data.id] = balistaEntity
	return balistaEntity
end

---@param id string
---@return BalistaEntity
function BalistaRepository:getBalistaEntity(id)
	if not self.balistaEntities[id] then
		return nil
	end

	return self.balistaEntities[id]
end

function BalistaRepository:removeBalistaEntity(id)
	self.balistaEntities[id] = nil
end

return BalistaRepository
