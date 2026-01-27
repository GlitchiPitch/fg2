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
	---@type SharedShooting
	local shared = self.diContainer:resolve("Shared")
	self.eventBus = shared.eventBus
	self.constants = shared.constants

	self:_setupEventListeners()

	self.ui:init()
end

function Presentation:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.CLIENT_EVENTS.SHOOT] = function(data)
			self.ui:onShoot(data)
		end,
		[self.constants.CLIENT_EVENTS.PLAYER_JOINED_BALISTA] = function(data)
			self.ui:toggle(true)
			self.ui:updateAmmo(data)
		end,
		[self.constants.CLIENT_EVENTS.PLAYER_LEFT_BALISTA] = function()
			self.ui:toggle(false)
		end,
		[self.constants.CLIENT_EVENTS.UPDATE_SCORE] = function(data)
			self.ui:updateScore(data)
		end,
		[self.constants.CLIENT_EVENTS.UPDATE_TIME] = function(data)
			self.ui:updateTimer(data)
		end,
	})
end
return Presentation
