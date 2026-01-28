---@class TaperMinigameUIModule
---@field diContainer DIContainer
---@field minigameFrame Frame
---@field taperButtonTemplate TextButton
local TaperMinigame = {}
TaperMinigame.__index = TaperMinigame

---@param diContainer DIContainer
---@param minigameFrame Frame
---@return TaperMinigameUIModule
function TaperMinigame.new(diContainer, minigameFrame)
	local self = setmetatable({}, TaperMinigame)
	self.diContainer = diContainer
	self.minigameFrame = minigameFrame
	self.taperButtonTemplate = self.minigameFrame.Template
	return self
end

function TaperMinigame:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus

    self:_setupEventListeners()
end

function TaperMinigame:_setupEventListeners()
	
end

function TaperMinigame:start()
	self.minigameFrame.Visible = true
end

function TaperMinigame:stop()
	self.minigameFrame.Visible = false
end

return TaperMinigame
