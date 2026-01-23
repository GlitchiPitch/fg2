---@class DungeonCleaningClientPresentation
local Presentation = {}
Presentation.__index = Presentation 

---@param diContainer DIContainer
---@return DungeonCleaningClientPresentation
function Presentation.new(diContainer)
	local self = setmetatable({}, Presentation)
	return self
end

function Presentation:init()
end

return Presentation