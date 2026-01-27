local ChairRepository = require(script.ChairRepository)

---@class ServerFoodEatingRepositories
---@field chairRepository ServerFoodEatingChairRepository
local Repositories = {}
Repositories.__index = Repositories

---@param diContainer DIContainer
---@return ServerFoodEatingRepositories
function Repositories.new(diContainer)
	local self = setmetatable({}, Repositories)
    self.diContainer = diContainer
    self.chairRepository = ChairRepository.new(diContainer)
	return self
end

function Repositories:init()
    self.chairRepository:init()
end

return Repositories