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
end

function ComboMinigame:stop()
end

function ComboMinigame:update()
end

return ComboMinigame