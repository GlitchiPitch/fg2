local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseServerPlayerService = require(ReplicatedStorage.Shared.Minigame.Application.Services.BaseServerPlayerService)

---@class ServerFoodEatingPlayerService : BaseMinigameServerPlayerService
local PlayerService = setmetatable({}, BaseServerPlayerService)
PlayerService.__index = PlayerService

function PlayerService.new(diContainer)
	local self = setmetatable(
		BaseServerPlayerService.new(diContainer, {
			playerJoinedServerEvent = "PLAYER_JOINED_FOOD_EATING",
			playerLeftServerEvent = "PLAYER_LEFT_FOOD_EATING",
			playerJoinedRemoteEvent = "PLAYER_JOINED_FOOD_EATING",
			playerLeftRemoteEvent = "PLAYER_LEFT_FOOD_EATING",
		}),
		PlayerService
	)
	return self
end

function PlayerService:getCameraMode(data)
	return self.coreConstants.CAMERA_MODES.FIXED, data.cameraCFrame
end

return PlayerService
