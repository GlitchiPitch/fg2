-- Minigames/FoodEating/Client/Application/Services/GameService.luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseClientGameService = require(ReplicatedStorage.Shared.Minigame.Application.Services.BaseClientGameService)

---@class ClientFoodEatingGameService : BaseMinigameClientGameService
local GameService = setmetatable({}, BaseClientGameService)
GameService.__index = GameService

function GameService.new(diContainer)
	local self = setmetatable(BaseClientGameService.new(diContainer), GameService)
	return self
end

function GameService:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.CLIENT_EVENTS.PLAYER_JOINED_FOOD_EATING] = function(data)
			self:_onPlayerJoined(data)
		end,
		[self.constants.CLIENT_EVENTS.PLAYER_LEFT_FOOD_EATING] = function(data)
			self:_onPlayerLeft(data)
		end,
	})
end

return GameService
