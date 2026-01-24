local PlayerService = require(script.PlayerService)
local InputService = require(script.InputService)

---@class CrossbowShootingClientAppServices
---@field playerService CrossbowShootingClientPlayerService
---@field inputService CrossbowShootingInputService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return CrossbowShootingClientAppServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
    self.diContainer = diContainer
    self.playerService = PlayerService.new(self.diContainer)
    self.inputService = InputService.new(self.diContainer)
	return self
end

function Services:init()
    self.playerService:init()
    self.inputService:init()
end

return Services