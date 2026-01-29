-- Minigames/Shooting/Client/Application/Services/PlayerService.luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseClientPlayerService = require(ReplicatedStorage.Shared.Minigame.Application.Services.BaseClientPlayerService)

---@class ClientDungeonCleaningPlayerService : BaseMinigameClientPlayerService
local PlayerService = setmetatable({}, BaseClientPlayerService)
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ClientDungeonCleaningPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable(
		BaseClientPlayerService.new(diContainer, {
			playerJoinedRemoteEvent = "PLAYER_JOINED_DUNGEON_CLEANING",
			playerLeftRemoteEvent = "PLAYER_LEFT_DUNGEON_CLEANING",
			playerJoinedClientEvent = "PLAYER_JOINED_DUNGEON_CLEANING",
			playerLeftClientEvent = "PLAYER_LEFT_DUNGEON_CLEANING",
		}),
		PlayerService
	)
	return self
end


return PlayerService
