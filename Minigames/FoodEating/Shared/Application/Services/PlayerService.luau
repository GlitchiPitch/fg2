---@class SharedFoodEatingPlayerService
local PlayerService = {}
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return SharedFoodEatingPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable({}, PlayerService)
	self.diContainer = diContainer
	return self
end

function PlayerService:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	---@type ServerFoodEatingInfrastructure | ClientFoodEatingInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.repositories.playerRepository
	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
	self.eventBus = shared.eventBus
end

function PlayerService:onPlayerJoinedFoodEating(data)
	error("Not implemented")
end

function PlayerService:onPlayerLeftFoodEating(data)
	error("Not implemented")
end

function PlayerService:_onAddScore(data)
	error("Not implemented")
end

return PlayerService
