---@class SharedFoodEatingItemsRepository
---@field diContainer DIContainer
local ItemsRepository = {}
ItemsRepository.__index = ItemsRepository

---@param diContainer DIContainer
---@return SharedFoodEatingItemsRepository
function ItemsRepository.new(diContainer)
	local self = setmetatable({}, ItemsRepository)
	self.diContainer = diContainer
	return self
end

function ItemsRepository:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.assets = shared.assets

	warn(self.assets)
end

function ItemsRepository:getAssets()
	local assets = {}
	for _, asset in self.assets do
		table.insert(assets, asset)
	end
	return assets
end

function ItemsRepository:getAsset(name)
	return self.assets[name]
end

return ItemsRepository
