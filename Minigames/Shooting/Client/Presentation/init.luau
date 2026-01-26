local UI = require(script.UI)

---@class ShootingPresentation
---@field diContainer DIContainer
---@field ui ShootingClientUI
local Presentation = {}
Presentation.__index = Presentation 

---@param diContainer DIContainer
---@return ShootingPresentation
function Presentation.new(diContainer)
	local self = setmetatable({}, Presentation)
    self.diContainer = diContainer
    self.ui = UI.new(diContainer)
	return self
end

function Presentation:init()
    self.ui:init()
end

return Presentation