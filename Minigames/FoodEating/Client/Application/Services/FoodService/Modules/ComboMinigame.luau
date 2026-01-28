---@class ComboMinigameServiceModule
local ComboMinigame = {}
ComboMinigame.__index = ComboMinigame

---@param diContainer DIContainer
---@return ComboMinigameServiceModule
function ComboMinigame.new(diContainer)
	local self = setmetatable({}, ComboMinigame)
	self.diContainer = diContainer
	return self
end

function ComboMinigame:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus
end

function ComboMinigame:start()
    self.eventBus:fire(self.constants.CLIENT_EVENTS.TOGGLE_COMBO_MINIGAME, {
        isEnabled = true,
    })
end

function ComboMinigame:stop()
    self.eventBus:fire(self.constants.CLIENT_EVENTS.TOGGLE_COMBO_MINIGAME, {
        isEnabled = false,
    })
end

function ComboMinigame:update()
end

return ComboMinigame