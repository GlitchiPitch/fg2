local ClickerMinigame = require(script.Modules.ClickerMinigame)
local ComboMinigame = require(script.Modules.ComboMinigame)
local TaperMinigame = require(script.Modules.TaperMinigame)

---@class minigameModules
---@field clicker ClickerMinigameServiceModule
---@field combo ComboMinigameServiceModule
---@field taper TaperMinigameServiceModule

---@class ClientFoodServiceService
---@field minigameModules minigameModules
---@field _currentMinigame eatingType
local FoodService = {}
FoodService.__index = FoodService

---@param diContainer DIContainer
---@return ClientFoodServiceService
function FoodService.new(diContainer)
	local self = setmetatable({}, FoodService)
	self.diContainer = diContainer
	self._currentMinigame = nil
	self.minigameModules = {
		clicker = ClickerMinigame.new(diContainer),
		combo = ComboMinigame.new(diContainer),
		taper = TaperMinigame.new(diContainer),
	}
	return self
end

function FoodService:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.remoteEventService = shared.remoteEventService
	self.eventBus = shared.eventBus

	for _, minigameModule in self.minigameModules do
		minigameModule:init()
	end

	self:_setupRemoteEventListeners()
	self:_setupEventListeners()
end

function FoodService:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.CLIENT_EVENTS.UPDATE_MINIGAME] = function()
			self:updateMinigame()
		end,
	})
end

function FoodService:_setupRemoteEventListeners()
	self.remoteEventService:connectToEvents({
		[self.constants.REMOTE_EVENTS.SPAWN_FOOD] = function(eventData)
			self:onSpawnFood(eventData.data)
		end,
	})
end

function FoodService:onSpawnFood(data)
	local eatingType = data.eatingType
	self._currentMinigame = eatingType

    self:stop()
    
	self.minigameModules[eatingType]:start(data.combo)

	self.eventBus:fire(self.constants.CLIENT_EVENTS.SPAWN_FOOD, {
		eatingType = eatingType,
		combo = data.combo,
	})
end

function FoodService:updateMinigame()
	if self._currentMinigame and self.minigameModules[self._currentMinigame].update then
		self.minigameModules[self._currentMinigame]:update()
	end
end

function FoodService:stop()
	for _, minigameModule in self.minigameModules do
		minigameModule:stop()
	end
end

return FoodService
