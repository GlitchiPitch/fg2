local ItemsRepository = require(script.ItemsRepository)

---@class SharedShootingRepositories
---@field diContainer DIContainer
---@field itemsRepository SharedShootingItemsRepository
local Repositories = {}
Repositories.__index = Repositories

---@param diContainer DIContainer
---@return SharedShootingRepositories
function Repositories.new(diContainer)
	local self = setmetatable({}, Repositories)
	self.itemsRepository = ItemsRepository.new(diContainer)
	return self
end

function Repositories:init()
	self.itemsRepository:init()
end

return Repositories