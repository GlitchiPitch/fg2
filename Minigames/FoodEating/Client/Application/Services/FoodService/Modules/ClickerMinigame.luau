---@class ClickerMinigameServiceModule
local ClickerMinigame = {}
ClickerMinigame.__index = ClickerMinigame

---@param diContainer DIContainer
---@return ClickerMinigameServiceModule
function ClickerMinigame.new(diContainer)
	local self = setmetatable({}, ClickerMinigame)
	self.diContainer = diContainer
	return self
end

function ClickerMinigame:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus
end

function ClickerMinigame:start() end

function ClickerMinigame:stop() end

function ClickerMinigame:update() end

return ClickerMinigame
