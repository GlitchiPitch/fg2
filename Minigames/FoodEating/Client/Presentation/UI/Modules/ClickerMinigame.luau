---@class ClickerMinigameUIModule
---@field minigameFrame Frame
---@field bar Frame
local ClickerMinigame = {}
ClickerMinigame.__index = ClickerMinigame

---@param minigameFrame Frame
---@return ClickerMinigameUIModule
function ClickerMinigame.new(minigameFrame)
	local self = setmetatable({}, ClickerMinigame)
	self.minigameFrame = minigameFrame
	self.bar = self.minigameFrame.CanvasGroup.Bar
	return self
end

function ClickerMinigame:setup() end

function ClickerMinigame:start()
	self.minigameFrame.Visible = true
end

function ClickerMinigame:stop()
	self.minigameFrame.Visible = false
end

return ClickerMinigame
