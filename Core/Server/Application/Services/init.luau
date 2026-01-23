local PlayerService = require(script.PlayerService)

---@class ServerAppServices
---@field playerService ServerPlayerService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ServerAppServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
	self.playerService = PlayerService.new(diContainer)
	return self
end

function Services:init()
	self.playerService:init()
end

return Services
