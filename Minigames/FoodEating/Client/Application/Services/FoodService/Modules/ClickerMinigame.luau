---@class ClickerMinigameServiceModule
---@field diContainer DIContainer
---@field eventBus EventBus
---@field remoteEventService RemoteEventService
---@field progress number
---@field maxProgress number
local ClickerMinigame = {}
ClickerMinigame.__index = ClickerMinigame

---@param diContainer DIContainer
---@return ClickerMinigameServiceModule
function ClickerMinigame.new(diContainer)
	local self = setmetatable({}, ClickerMinigame)
	self.diContainer = diContainer
    self.progress = 0
    self.maxProgress = 1
	return self
end

function ClickerMinigame:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus
	self.remoteEventService = shared.remoteEventService
    self:_setupEventListeners()
end


function ClickerMinigame:_setupEventListeners()
    self.eventBus:connectToEvents({
        [self.constants.CLIENT_EVENTS.CLICKER_MINIGAME_INPUT] = function()
            self:onInput()
        end,
    })
end

function ClickerMinigame:start() 
    warn("start")
    self.eventBus:fire(self.constants.CLIENT_EVENTS.TOGGLE_CLICKER_MINIGAME, {
        isEnabled = true,
    })
end

function ClickerMinigame:stop()
    self.eventBus:fire(self.constants.CLIENT_EVENTS.TOGGLE_CLICKER_MINIGAME, {
        isEnabled = false,
    })
    self.progress = 0
end

function ClickerMinigame:update() 
    self.progress = math.clamp(self.progress - .1, 0, self.maxProgress)
    self.eventBus:fire(self.constants.CLIENT_EVENTS.UPDATE_CLICKER_MINIGAME_PROGRESS, {
        progress = self.progress,
    })
end

function ClickerMinigame:onInput()
    self.progress = math.clamp(self.progress + .1, 0, self.maxProgress)

    if self.progress >= self.maxProgress then
        self.progress = 0
        self:onComplete()
    end

    self.eventBus:fire(self.constants.CLIENT_EVENTS.UPDATE_CLICKER_MINIGAME_PROGRESS, {
        progress = self.progress,
    })
end

function ClickerMinigame:onComplete()
    self.remoteEventService:fireServer({
        eventName = self.constants.REMOTE_EVENTS.EAT_FOOD,
        data = {},
    })
    
end

return ClickerMinigame
