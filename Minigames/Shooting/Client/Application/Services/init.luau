local PlayerService = require(script.PlayerService)
local InputService = require(script.InputService)
local BalistaService = require(script.BalistaService)
---@class ShootingClientAppServices
---@field playerService ShootingClientPlayerService
---@field inputService ShootingInputService
---@field balistaService ClientBalistaService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ShootingClientAppServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
    self.diContainer = diContainer
    self.playerService = PlayerService.new(self.diContainer)
    self.inputService = InputService.new(self.diContainer)
    self.balistaService = BalistaService.new(self.diContainer)
	return self
end

function Services:init()
    self.playerService:init()
    self.inputService:init()
    self.balistaService:init()
end

return Services