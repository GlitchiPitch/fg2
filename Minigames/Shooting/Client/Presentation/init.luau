---@class ShootingPresentation
local Presentation = {}
Presentation.__index = Presentation 

---@param diContainer DIContainer
---@return ShootingPresentation
function Presentation.new(diContainer)
	local self = setmetatable({}, Presentation)
    self.diContainer = diContainer
	return self
end

function Presentation:init()
end

return Presentation