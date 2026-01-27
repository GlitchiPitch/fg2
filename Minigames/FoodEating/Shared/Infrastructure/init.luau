local ItemsRepository = require(script.ItemsRepository)

---@class SharedFoodEatingInfrastructure
---@field itemsRepository SharedFoodEatingItemsRepository
local Infrastructure = {}
Infrastructure.__index = Infrastructure

---@param diContainer DIContainer
---@return SharedFoodEatingInfrastructure
function Infrastructure.new(diContainer)
	local self = setmetatable({}, Infrastructure)
    self.itemsRepository = ItemsRepository.new(diContainer)
	self.diContainer = diContainer
	return self
end

function Infrastructure:init()
	self.itemsRepository:init()
end

return Infrastructure