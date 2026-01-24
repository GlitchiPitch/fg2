local PlayerService = require(script.PlayerService)
local BalistaService = require(script.BalistaService)
---@class ShootingServerAppServices
---@field playerService ShootingServerPlayerService
---@field balistaService ShootingServerBalistaService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ShootingServerAppServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
	self.playerService = PlayerService.new(diContainer)
	self.balistaService = BalistaService.new(diContainer)
	return self
end

function Services:init()
	self.playerService:init()
	self.balistaService:init()
end

return Services