local InputService = require(script.InputService)
local PlayerService = require(script.PlayerService)
---@class FoodEatingClientServices
---@field inputService FoodEatingInputService
---@field playerService ClientFoodEatingPlayerService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return FoodEatingClientServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
	self.inputService = InputService.new(diContainer)
	self.playerService = PlayerService.new(diContainer)
	return self
end

function Services:init()
	self.inputService:init()
	self.playerService:init()
end

return Services