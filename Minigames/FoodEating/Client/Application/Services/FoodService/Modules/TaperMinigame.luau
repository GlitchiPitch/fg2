---@class TaperMinigameServiceModule
---@field remoteEventService RemoteEventService
---@field constants SharedFoodEatingConstants
---@field eventBus EventBus
---@field diContainer DIContainer
---@field _deltaTime number
---@field _updateInterval number
---@field _taps number
local TaperMinigame = {}
TaperMinigame.__index = TaperMinigame

---@param diContainer DIContainer
---@return TaperMinigameServiceModule
function TaperMinigame.new(diContainer)
	local self = setmetatable({}, TaperMinigame)
	self.diContainer = diContainer
	self._deltaTime = 0
	self._updateInterval = 2
	self._taps = 0
	return self
end

function TaperMinigame:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus
	self.remoteEventService = shared.remoteEventService
	self:_setupEventListeners()
end

function TaperMinigame:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.CLIENT_EVENTS.TAPER_CLICKED] = function(data)
			self:onTaperClicked(data)
		end,
	})
end

function TaperMinigame:start()
	self._taps = 0
	self.eventBus:fire(self.constants.CLIENT_EVENTS.SET_FREE_MOUSE, {
		isEnabled = true,
	})
end

function TaperMinigame:stop()
	self._taps = 0
end

function TaperMinigame:onTaperClicked(data)
	if data.isTap then
		self._taps = math.clamp(self._taps + 1, 0, 3)
	else
		self._taps = math.clamp(self._taps - 1, 0, 3)
	end

	if self._taps >= 3 then
		self:onComplete()
	end
end

function TaperMinigame:update(_)
	self._deltaTime += 1
	if self._deltaTime >= self._updateInterval then
		self._deltaTime = 0
		self:_createTaper()
	end
end

function TaperMinigame:_createTaper()
	self.eventBus:fire(self.constants.CLIENT_EVENTS.CREATE_TAPER, {})
end

function TaperMinigame:onComplete()
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.EAT_FOOD,
		data = {},
	})
end

return TaperMinigame
