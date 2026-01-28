---@class ClickerMinigameUIModule
---@field diContainer DIContainer
---@field minigameFrame Frame
---@field bar Frame
local ClickerMinigame = {}
ClickerMinigame.__index = ClickerMinigame

---@param diContainer DIContainer
---@param minigameFrame Frame
---@return ClickerMinigameUIModule
function ClickerMinigame.new(diContainer, minigameFrame)
	local self = setmetatable({}, ClickerMinigame)
	self.diContainer = diContainer
	self.minigameFrame = minigameFrame
	self.bar = self.minigameFrame.CanvasGroup.Bar
	return self
end

function ClickerMinigame:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	self:_setupEventListeners()
end

function ClickerMinigame:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.CLIENT_EVENTS.UPDATE_CLICKER_MINIGAME_PROGRESS] = function(data)
			self:onProgressUpdate(data.progress)
		end,
	})
end

function ClickerMinigame:start()
	self.minigameFrame.Visible = true
end

function ClickerMinigame:stop()
	self.minigameFrame.Visible = false
end

function ClickerMinigame:onProgressUpdate(progress)
	self.bar.Size = UDim2.fromScale(progress, 1)
end

return ClickerMinigame
