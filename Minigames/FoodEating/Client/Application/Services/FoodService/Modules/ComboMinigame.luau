---@class ComboMinigameServiceModule
---@field remoteEventService RemoteEventService
---@field constants SharedFoodEatingConstants
---@field eventBus EventBus
---@field combo table<number, Enum.KeyCode>
---@field currentIndex number
local ComboMinigame = {}
ComboMinigame.__index = ComboMinigame

---@param diContainer DIContainer
---@return ComboMinigameServiceModule
function ComboMinigame.new(diContainer)
	local self = setmetatable({}, ComboMinigame)
	self.diContainer = diContainer
	self.combo = {}
	self.currentIndex = 1
	return self
end

function ComboMinigame:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus
	self.remoteEventService = shared.remoteEventService
	self:_setupEventListeners()
end

function ComboMinigame:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.CLIENT_EVENTS.COMBO_MINIGAME_INPUT] = function(data)
			self:onInput(data.input)
		end,
	})
end

---@param combo table<number, Enum.KeyCode>
function ComboMinigame:start(combo)
	self.combo = combo
	self.eventBus:fire(self.constants.CLIENT_EVENTS.TOGGLE_COMBO_MINIGAME, {
		isEnabled = true,
		combo = self.combo,
	})
end

function ComboMinigame:stop()
	warn("stop")
	self.eventBus:fire(self.constants.CLIENT_EVENTS.TOGGLE_COMBO_MINIGAME, {
		isEnabled = false,
	})

	self.currentIndex = 1
	self.combo = {}
end

-- function ComboMinigame:update()
-- end

---@param input InputObject
function ComboMinigame:onInput(input)
	warn("ComboMinigame")
	if input.KeyCode ~= self.combo[self.currentIndex] then
		self.currentIndex = 1
	else
		self.currentIndex += 1
	end

	self.eventBus:fire(self.constants.CLIENT_EVENTS.COMBO_MINIGAME_INPUT_SUCCESS, {
		currentIndex = self.currentIndex,
	})

	task.wait(0.5)

	if self.currentIndex > #self.combo then
		self:onComplete()
	end
end

function ComboMinigame:onComplete()
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.EAT_FOOD,
		data = {},
	})
	self.eventBus:fire(self.constants.CLIENT_EVENTS.TOGGLE_COMBO_MINIGAME, {
		isEnabled = false,
	})
end

return ComboMinigame
