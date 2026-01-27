local ChairRepository = require(script.ChairRepository)
local FoodRepository = require(script.FoodRepository)
---@class ServerFoodEatingRepositories
---@field chairRepository ServerFoodEatingChairRepository
---@field foodRepository ServerFoodEatingFoodRepository
local Repositories = {}
Repositories.__index = Repositories

---@param diContainer DIContainer
---@return ServerFoodEatingRepositories
function Repositories.new(diContainer)
	local self = setmetatable({}, Repositories)
    self.diContainer = diContainer
    self.chairRepository = ChairRepository.new(diContainer)
    self.foodRepository = FoodRepository.new(diContainer)
	return self
end

function Repositories:init()
    self.chairRepository:init()
    self.foodRepository:init()
end

return Repositories