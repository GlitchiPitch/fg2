---@class ComboMinigameUIModule
---@field minigameFrame Frame
---@field comboImageTemplate TextButton
local ComboMinigame = {}
ComboMinigame.__index = ComboMinigame

---@param minigameFrame Frame
---@return ComboMinigameUIModule
function ComboMinigame.new(minigameFrame)
	local self = setmetatable({}, ComboMinigame)
	self.minigameFrame = minigameFrame
	self.comboImageTemplate = self.minigameFrame.Template
	return self
end

function ComboMinigame:setup() end

function ComboMinigame:start()
	self.minigameFrame.Visible = true
end

function ComboMinigame:stop()
	self.minigameFrame.Visible = false
end

return ComboMinigame
