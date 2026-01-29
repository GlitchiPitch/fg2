-- Minigames/FoodEating/Server/Application/Services/GameService.luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseGameService = require(ReplicatedStorage.Shared.Minigame.Application.Services.BaseGameService)

---@class ServerFoodEatingGameService : BaseMinigameGameService
local GameService = setmetatable({}, BaseGameService)
GameService.__index = GameService

function GameService.new(diContainer)
	local self = setmetatable(
		BaseGameService.new(diContainer, {
			defaultTime = 30,
			gameName = "Food Eating",
		}),
		GameService
	)
	return self
end

return GameService
