local PlayerService = require(script.PlayerService)
---@class ClientAppServices
---@field playerService ClientPlayerService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ClientAppServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
    self.playerService = PlayerService.new(diContainer)
	return self
end

function Services:init()
	self.playerService:init()
end

return Services