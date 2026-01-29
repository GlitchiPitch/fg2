-- Core/Shared/Minigame/Application/Services/BasePlayerService.luau

---@class BasePlayerServiceConfig
---@field sharedKey string?
---@field infrastructureKey string?

---@class BaseMinigamePlayerService
local PlayerService = {}
PlayerService.__index = PlayerService

function PlayerService.new(diContainer, config)
	local self = setmetatable({}, PlayerService)
	self.diContainer = diContainer
	self.config = config or {}
	self.config.sharedKey = self.config.sharedKey or "Shared"
	self.config.infrastructureKey = self.config.infrastructureKey or "Infrastructure"
	return self
end

function PlayerService:init()
	local shared = self.diContainer:resolve(self.config.sharedKey)
	local infrastructure = self.diContainer:resolve(self.config.infrastructureKey)

	self.playerRepository = infrastructure.repositories.playerRepository
	self.remoteEventService = shared.remoteEventService
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	self:_onInit()
end

function PlayerService:_onInit() end

function PlayerService:onPlayerJoined(data)
	error("onPlayerJoined must be implemented by subclass")
end

function PlayerService:onPlayerLeft(data)
	error("onPlayerLeft must be implemented by subclass")
end

function PlayerService:onAddScore(data)
	error("onAddScore must be implemented by subclass")
end

return PlayerService
