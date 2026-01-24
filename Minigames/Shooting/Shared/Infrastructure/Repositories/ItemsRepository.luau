---@class SharedShootingItemsRepository
---@field diContainer DIContainer
---@field items table<string, ShootingSharedDataItem>
local ItemsRepository = {}
ItemsRepository.__index = ItemsRepository

---@param diContainer DIContainer
---@return SharedShootingItemsRepository
function ItemsRepository.new(diContainer)
	local self = setmetatable({}, ItemsRepository)
	self.diContainer = diContainer
	return self
end

function ItemsRepository:init()
	---@type ShootingShared
	local shared = self.diContainer:resolve("Shared")
	self.items = shared.data.Items
end

---@param itemName string
---@return ShootingSharedDataItem
function ItemsRepository:getItemData(itemName)
	return self.items[itemName]
end

---@param itemName string
---@return Model
function ItemsRepository:getItemAsset(itemName)
	return self:getItemData(itemName).model
end

return ItemsRepository
