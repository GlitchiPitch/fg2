---@class TaperMinigame
local TaperMinigame = {}
TaperMinigame.__index = TaperMinigame

---@param minigameFrame Frame
---@return TaperMinigame
function TaperMinigame.new(minigameFrame)
	local self = setmetatable({}, TaperMinigame)
    self.minigameFrame = minigameFrame
	return self
end

function TaperMinigame:setup()
    
end

function TaperMinigame:start()
    self.minigameFrame.Enabled = true
end

function TaperMinigame:stop()
    self.minigameFrame.Enabled = false
end

return TaperMinigame