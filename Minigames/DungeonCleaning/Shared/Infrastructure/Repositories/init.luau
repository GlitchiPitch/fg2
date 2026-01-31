local ItemsRepository = require(script.ItemsRepository)
---@class SharedDungeonCleaningRepositories
---@field itemsRepository SharedDungeonCleaningItemsRepository
local Repositories = {}
Repositories.__index = Repositories

---@param diContainer DIContainer
---@return SharedDungeonCleaningRepositories
function Repositories.new(diContainer)
	local self = setmetatable({}, Repositories)
	self.itemsRepository = ItemsRepository.new(diContainer)
	return self
end

function Repositories:init()
	self.itemsRepository:init()
end

return Repositories