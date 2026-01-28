---@class ComboMinigame
local ComboMinigame = {}
ComboMinigame.__index = ComboMinigame

---@param minigameFrame Frame
---@return ComboMinigame
function ComboMinigame.new(minigameFrame)
	local self = setmetatable({}, ComboMinigame)
    self.minigameFrame = minigameFrame
	return self
end

function ComboMinigame:setup()
    
end

function ComboMinigame:start()
    self.minigameFrame.Enabled = true
end

function ComboMinigame:stop()
    self.minigameFrame.Enabled = false
end

return ComboMinigame