local HttpService = game:GetService("HttpService")
---@class ServerShootingTargetRepository
---@field diContainer DIContainer
---@field targetEntities table<string, TargetEntity>
---@field targetEntity TargetEntity
---@field itemsRepository SharedShootingItemsRepository
---@field targetAssets table<string, Model[]>
local TargetRepository = {}
TargetRepository.__index = TargetRepository

---@param diContainer DIContainer
---@return ServerShootingTargetRepository
function TargetRepository.new(diContainer)
	local self = setmetatable({}, TargetRepository)
	self.diContainer = diContainer
	self.targetEntities = {}
	return self
end

function TargetRepository:init()
	---@type SharedShooting
	local shared = self.diContainer:resolve("Shared")
	self.itemsRepository = shared.infrastructure.repositories.itemsRepository
	self.targetEntity = shared.domain.Entities.Target

	self.targetAssets = {
		flying = {
			self.itemsRepository:getItemAsset("Starship"),
			-- self.itemsRepository:getItemAsset("BigStarship"),
		},
		ground = {
			-- self.itemsRepository:getItemAsset("Tank"),
			self.itemsRepository:getItemAsset("LightTank"),
		},
	}
end

function TargetRepository:createTargetEntity(target)
	local id = HttpService:GenerateGUID(false)
	local itemData = self.itemsRepository:getItemData(target.Name)
	local targetEntity = self.targetEntity.new(target, id, itemData.score)
	targetEntity:init({
		destroyCallback = function()
			self:removeTargetEntity(id)
		end,
	})

	self.targetEntities[id] = targetEntity
	return targetEntity
end

function TargetRepository:getTargetEntity(id)
	if not self.targetEntities[id] then
		return nil
	end
	return self.targetEntities[id]
end

function TargetRepository:removeTargetEntity(id)
	self.targetEntities[id] = nil
end

---@param targetType '"flying"' | '"ground"'
---@return TargetEntity
function TargetRepository:getRandomTarget(targetType)
	local target = self.targetAssets[targetType][math.random(1, #self.targetAssets[targetType])]:Clone()
	local targetEntity = self:createTargetEntity(target)
	return targetEntity
end

return TargetRepository
