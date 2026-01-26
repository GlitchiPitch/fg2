local PlayerService = require(script.PlayerService)
local InputService = require(script.InputService)
---@class ClientAppServices
---@field playerService ClientPlayerService
---@field inputService InputService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ClientAppServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
	self.playerService = PlayerService.new(diContainer)
	self.inputService = InputService.new(diContainer)
	return self
end

function Services:init()
	self.playerService:init()
	self.inputService:init()
end

return Services
