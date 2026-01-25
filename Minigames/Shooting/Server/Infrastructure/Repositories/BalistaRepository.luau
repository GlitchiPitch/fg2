local HttpService = game:GetService("HttpService")
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

function BalistaRepository:createBalistaEntity(balista)
	local id = HttpService:GenerateGUID(false)
	local balistaEntity = self.balistaEntity.new(balista, id)
	balistaEntity:init({
		destroyCallback = function()
			self:removeBalistaEntity(id)
		end,
	})
	self.balistaEntities[id] = balistaEntity
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
