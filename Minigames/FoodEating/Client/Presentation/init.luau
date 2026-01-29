local UI = require(script.UI)

---@class FoodEatingClientPresentation
---@field ui FoodEatingClientUI
local Presentation = {}
Presentation.__index = Presentation

---@param diContainer DIContainer
---@return FoodEatingClientPresentation
function Presentation.new(diContainer)
	local self = setmetatable({}, Presentation)
	self.diContainer = diContainer
	self.ui = UI.new(self.diContainer)
	return self
end

function Presentation:init()
	self.ui:init()

	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.eventBus = shared.eventBus
	self.constants = shared.constants

	self:_setupEventListeners()
end

function Presentation:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.CLIENT_EVENTS.SPAWN_FOOD] = function(data)
			self.ui:showFoodMinigame(data)
		end,
		[self.constants.CLIENT_EVENTS.PLAYER_JOINED_FOOD_EATING] = function()
			self.ui:toggle(true)
		end,
		[self.constants.CLIENT_EVENTS.PLAYER_LEFT_FOOD_EATING] = function()
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
