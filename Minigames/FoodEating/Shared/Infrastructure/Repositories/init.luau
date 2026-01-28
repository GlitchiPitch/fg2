local ItemsRepository = require(script.ItemsRepository)

---@class SharedFoodEatingRepositories
---@field itemsRepository SharedFoodEatingItemsRepository
local Repositories = {}
Repositories.__index = Repositories

---@param diContainer DIContainer
---@return SharedFoodEatingRepositories
function Repositories.new(diContainer)
	local self = setmetatable({}, Repositories)
	self.diContainer = diContainer
	self.itemsRepository = ItemsRepository.new(diContainer)
	return self
end

function Repositories:init()
	self.itemsRepository:init()
end

return Repositories