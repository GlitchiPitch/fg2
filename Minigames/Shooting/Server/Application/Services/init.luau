local PlayerService = require(script.PlayerService)
local BalistaService = require(script.BalistaService)
local TargetService = require(script.TargetService)
local GameService = require(script.GameService)
---@class ServerShootingAppServices
---@field playerService ServerShootingPlayerService
---@field balistaService ServerShootingBalistaService
---@field targetService ServerShootingTargetService
---@field gameService ServerShootingGameService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ServerShootingAppServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
	self.playerService = PlayerService.new(diContainer)
	self.balistaService = BalistaService.new(diContainer)
	self.targetService = TargetService.new(diContainer)
	self.gameService = GameService.new(diContainer)
	return self
end

function Services:init()
	self.playerService:init()
	self.balistaService:init()
	self.targetService:init()
	self.gameService:init()
end

return Services
