---@class ServerFoodEatingGameService
local GameService = {}
GameService.__index = GameService

---@param diContainer DIContainer
---@return ServerFoodEatingGameService
function GameService.new(diContainer)
	local self = setmetatable({}, GameService)
	self.diContainer = diContainer

	return self
end

function GameService:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	self.gameEntity = shared.domain.Entities.Game.new()
	self.gameEntity:fromData({
		defaultTime = 30,
	})

	self:_setupEventListeners()
end

function GameService:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.SERVER_EVENTS.UPDATE_TIME] = function(data)
			warn("update time food eating game", data)
			self:onUpdateTime(data)
		end,
	})
end

function GameService:onUpdateTime()
	self.gameEntity:updateTime(-1)
	if not self.gameEntity:hasTime() then
		warn("food eating game finished")
		self.eventBus:fire(self.constants.SERVER_EVENTS.GAME_FINISHED)
	end
end

function GameService:finish()
	self.gameEntity:finish()
end

return GameService
