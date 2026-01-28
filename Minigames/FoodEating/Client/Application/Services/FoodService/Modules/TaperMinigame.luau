---@class TaperMinigameServiceModule
local TaperMinigame = {}
TaperMinigame.__index = TaperMinigame

---@param diContainer DIContainer
---@return TaperMinigameServiceModule
function TaperMinigame.new(diContainer)
	local self = setmetatable({}, TaperMinigame)
	self.diContainer = diContainer
	return self
end

function TaperMinigame:init()
    ---@type SharedFoodEating
    local shared = self.diContainer:resolve("Shared")
    self.constants = shared.constants
    self.eventBus = shared.eventBus
end

function TaperMinigame:start()
end

function TaperMinigame:stop()
end

function TaperMinigame:update()
end

return TaperMinigame