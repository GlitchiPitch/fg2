---@class TaperMinigameUIModule
---@field minigameFrame Frame
---@field taperButtonTemplate TextButton
local TaperMinigame = {}
TaperMinigame.__index = TaperMinigame

---@param minigameFrame Frame
---@return TaperMinigameUIModule
function TaperMinigame.new(minigameFrame)
	local self = setmetatable({}, TaperMinigame)
	self.minigameFrame = minigameFrame
	self.taperButtonTemplate = self.minigameFrame.Template
	return self
end

function TaperMinigame:setup() end

function TaperMinigame:start()
	self.minigameFrame.Visible = true
end

function TaperMinigame:stop()
	self.minigameFrame.Visible = false
end

return TaperMinigame
