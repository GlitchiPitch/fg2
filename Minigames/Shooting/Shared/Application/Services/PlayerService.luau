---@class SharedShootingPlayerService
local PlayerService = {}
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return SharedShootingPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable({}, PlayerService)
	self.diContainer = diContainer
	return self
end

function PlayerService:init()
	---@type SharedShooting
	local shared = self.diContainer:resolve("Shared")
	---@type ServerShootingInfrastructure | ClientShootingInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.repositories.playerRepository
	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
	self.eventBus = shared.eventBus
end

function PlayerService:onPlayerJoinedBalista(data)
	error("Not implemented")
end

function PlayerService:onPlayerLeftBalista(data)
	error("Not implemented")
end

function PlayerService:onAddScore(data)
	error("Not implemented")
end

return PlayerService
