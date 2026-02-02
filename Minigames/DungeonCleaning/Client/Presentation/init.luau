local UI = require(script.UI)

---@class DungeonCleaningClientPresentation
---@field ui DungeonCleaningUI
local Presentation = {}
Presentation.__index = Presentation 

---@param diContainer DIContainer
---@return DungeonCleaningClientPresentation
function Presentation.new(diContainer)
	local self = setmetatable({}, Presentation)
	self.ui = UI.new(diContainer)
	return self
end

function Presentation:init()
	self.ui:init()
end

return Presentation