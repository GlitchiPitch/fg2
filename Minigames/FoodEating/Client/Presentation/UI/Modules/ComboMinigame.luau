---@class ComboMinigameUIModule
---@field diContainer DIContainer
---@field minigameFrame Frame
---@field comboImageTemplate TextButton
local ComboMinigame = {}
ComboMinigame.__index = ComboMinigame

---@param diContainer DIContainer
---@param minigameFrame Frame
---@return ComboMinigameUIModule
function ComboMinigame.new(diContainer, minigameFrame)
	local self = setmetatable({}, ComboMinigame)
	self.diContainer = diContainer
	self.minigameFrame = minigameFrame
	self.comboImageTemplate = self.minigameFrame.Template
	return self
end

function ComboMinigame:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus

    self:_setupEventListeners()
end

function ComboMinigame:_setupEventListeners()
	
end

function ComboMinigame:start()
	self.minigameFrame.Visible = true
end

function ComboMinigame:stop()
	self.minigameFrame.Visible = false
end

return ComboMinigame
