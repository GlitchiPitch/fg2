-- Core/Shared/Minigame/Application/Services/BaseClientGameService.luau

---@class BaseClientGameServiceConfig
---@field sharedKey string?

---@class BaseMinigameClientGameService
local GameService = {}
GameService.__index = GameService

function GameService.new(diContainer, config)
	local self = setmetatable({}, GameService)
	self.diContainer = diContainer
	self.config = config or {}
	self.config.sharedKey = self.config.sharedKey or "Shared"
	self._connections = {}
	return self
end

function GameService:init()
	local shared = self.diContainer:resolve(self.config.sharedKey)
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	self.gameEntity = shared.domain.Entities.Game.new()

	self:_setupEventListeners()
	self:_onInit()
end

function GameService:_onInit() end

-- Subclasses MUST override this to set up their specific events
function GameService:_setupEventListeners()
	error("_setupEventListeners must be implemented by subclass")
end

function GameService:_onPlayerJoined(data)
	self._connections.timeChanged = self.gameEntity.time.Changed:Connect(function()
		self.eventBus:fire(self.constants.CLIENT_EVENTS.UPDATE_TIME, {
			time = self.gameEntity.time.Value,
		})
	end)

	self.eventBus:fire(self.constants.CLIENT_EVENTS.UPDATE_TIME, {
		time = self.gameEntity.time.Value,
	})

	self:onPlayerJoined(data)
end

function GameService:_onPlayerLeft(data)
	if self._connections.timeChanged then
		self._connections.timeChanged:Disconnect()
		self._connections.timeChanged = nil
	end

	self:onPlayerLeft(data)
end

function GameService:onPlayerJoined(data) end
function GameService:onPlayerLeft(data) end

function GameService:getTimeRemaining()
	return self.gameEntity.time.Value
end

return GameService
