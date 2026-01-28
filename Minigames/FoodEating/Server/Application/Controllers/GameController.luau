---@class ServerFoodEatingGameController
local GameController = {}
GameController.__index = GameController

---@param diContainer DIContainer
---@return ServerFoodEatingGameController
function GameController.new(diContainer)
	local self = setmetatable({}, GameController)
	self.diContainer = diContainer
    self._deltaTime = 0
    self._updateInterval = 1
	return self
end

function GameController:init()
    ---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus
end

function GameController:update(deltaTime)
	self._deltaTime += deltaTime
	if self._deltaTime >= self._updateInterval then
		self._deltaTime = 0
		self.eventBus:fire(self.constants.SERVER_EVENTS.UPDATE_TIME)
	end
end

return GameController