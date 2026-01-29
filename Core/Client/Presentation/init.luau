local UI = require(script.UI)

---@class Presentation
---@field ui UI
---@field constants SharedConstants
---@field eventBus EventBus
local Presentation = {}
Presentation.__index = Presentation

---@param diContainer DIContainer
---@return Presentation
function Presentation.new(diContainer)
	local self = setmetatable({}, Presentation)
	self.diContainer = diContainer
	self.ui = UI.new(self.diContainer)
	return self
end

function Presentation:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	self.ui:init()

	self:_setupEventListeners()
end

function Presentation:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.CLIENT_EVENTS.OPEN_RESULT_UI] = function(data)
			self.ui:openResultUI(data)
		end,
	})
end

return Presentation
