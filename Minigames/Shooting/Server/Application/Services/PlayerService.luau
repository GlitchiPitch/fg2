-- Minigames/Shooting/Server/Application/Services/PlayerService.luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseServerPlayerService = require(ReplicatedStorage.Shared.Minigame.Application.Services.BaseServerPlayerService)

---@class ServerShootingPlayerService : BaseMinigameServerPlayerService
local PlayerService = setmetatable({}, BaseServerPlayerService)
PlayerService.__index = PlayerService

function PlayerService.new(diContainer)
	local self = setmetatable(
		BaseServerPlayerService.new(diContainer, {
			playerJoinedServerEvent = "PLAYER_JOINED_BALISTA",
			playerLeftServerEvent = "PLAYER_LEFT_BALISTA",
			playerJoinedRemoteEvent = "PLAYER_JOINED_BALISTA",
			playerLeftRemoteEvent = "PLAYER_LEFT_BALISTA",
		}),
		PlayerService
	)
	return self
end

function PlayerService:getCameraMode(data)
	return self.coreConstants.CAMERA_MODES.FOLLOWING, nil
end

function PlayerService:getPlayerJoinedData(data)
	return data.balista
end

function PlayerService:getPlayerLeftData(data)
	return data.balista
end

function PlayerService:_setupRemoteEventListeners()
	self.remoteEventService:connectToEvents({
		[self.constants.REMOTE_EVENTS.SEND_CAMERA_CFRAME] = function(player, eventData)
			player:SetAttribute("CameraCFrame", eventData.data.cameraCFrame)
		end,
	})
end

function PlayerService:calculatePlayerReward(playerEntity, score)
	return {
		points = score * self.constants.SCORE_REWARD_MULTIPLIER,
	}
end

return PlayerService
