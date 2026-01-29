-- Core/Shared/Minigame/Application/Services/BaseGameService.luau

---@class BaseGameServiceConfig
---@field defaultTime number
---@field gameName string
---@field sharedKey string?

---@class BaseMinigameGameService
local GameService = {}
GameService.__index = GameService

function GameService.new(diContainer, config)
	local self = setmetatable({}, GameService)
	self.diContainer = diContainer
	self.config = config
	self.config.sharedKey = self.config.sharedKey or "Shared"
	return self
end

function GameService:init()
	local shared = self.diContainer:resolve(self.config.sharedKey)
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	self.gameEntity = shared.domain.Entities.Game.new()
	self.gameEntity:fromData({
		defaultTime = self.config.defaultTime,
	})

	self:_setupEventListeners()
	self:_onInit()
end

function GameService:_onInit() end

function GameService:_setupEventListeners()
	local events = {
		[self.constants.SERVER_EVENTS.UPDATE_TIME] = function(data)
			self:onUpdateTime(data)
		end,
	}

	local additionalEvents = self:_getAdditionalEventListeners()
	if additionalEvents then
		for event, handler in additionalEvents do
			events[event] = handler
		end
	end

	self.eventBus:connectToEvents(events)
end

function GameService:_getAdditionalEventListeners()
	return nil
end

function GameService:onUpdateTime(data)
	self.gameEntity:updateTime(-1)
	if not self.gameEntity:hasTime() then
		warn(self.config.gameName .. " game finished")
		self:_onGameFinished()
		self.eventBus:fire(self.constants.SERVER_EVENTS.GAME_FINISHED)
	end
end

function GameService:_onGameFinished() end

function GameService:finish()
	self.gameEntity:finish()
	self:_onFinish()
end

function GameService:_onFinish() end

function GameService:getTimeRemaining()
	return self.gameEntity.time.Value
end

function GameService:isGameActive()
	return self.gameEntity:hasTime()
end

return GameService
