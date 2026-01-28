---@class ClickerMinigame
local ClickerMinigame = {}
ClickerMinigame.__index = ClickerMinigame

---@param minigameFrame Frame
---@return ClickerMinigame
function ClickerMinigame.new(minigameFrame)
	local self = setmetatable({}, ClickerMinigame)
    self.minigameFrame = minigameFrame
	return self
end

function ClickerMinigame:setup()
    
end

function ClickerMinigame:start()
    self.minigameFrame.Enabled = true
end

function ClickerMinigame:stop()
    self.minigameFrame.Enabled = false
end

return ClickerMinigame