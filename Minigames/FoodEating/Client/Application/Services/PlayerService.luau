-- Minigames/FoodEating/Client/Application/Services/PlayerService.luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseClientPlayerService = require(ReplicatedStorage.Shared.Minigame.Application.Services.BaseClientPlayerService)

---@class ClientFoodEatingPlayerService : BaseMinigameClientPlayerService
local PlayerService = setmetatable({}, BaseClientPlayerService)
PlayerService.__index = PlayerService

function PlayerService.new(diContainer)
	local self = setmetatable(
		BaseClientPlayerService.new(diContainer, {
			playerJoinedRemoteEvent = "PLAYER_JOINED_FOOD_EATING",
			playerLeftRemoteEvent = "PLAYER_LEFT_FOOD_EATING",
			playerJoinedClientEvent = "PLAYER_JOINED_FOOD_EATING",
			playerLeftClientEvent = "PLAYER_LEFT_FOOD_EATING",
		}),
		PlayerService
	)
	return self
end

return PlayerService
