local PlayerService = require(script.PlayerService)
---@class ClientDungeonCleaningAppServices
---@field playerService ClientDungeonCleaningPlayerService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ClientDungeonCleaningAppServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
    self.playerService = PlayerService.new(diContainer)
	return self
end

function Services:init()
    self.playerService:init()
end

return Services