local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseServerPlayerService = require(ReplicatedStorage.Shared.Minigame.Application.Services.BaseServerPlayerService)

---@class ServerDungeonCleaningPlayerService : BaseMinigameServerPlayerService
---@field triggerZone Part
local PlayerService = setmetatable({}, BaseServerPlayerService)
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ServerDungeonCleaningPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable(
		BaseServerPlayerService.new(diContainer, {
			playerJoinedServerEvent = "PLAYER_JOINED_DUNGEON_CLEANING",
			playerLeftServerEvent = "PLAYER_LEFT_DUNGEON_CLEANING",
			playerJoinedRemoteEvent = "PLAYER_JOINED_DUNGEON_CLEANING",
			playerLeftRemoteEvent = "PLAYER_LEFT_DUNGEON_CLEANING",
		}),
		PlayerService
	)
	return self
end

function PlayerService:_onInit()
	self.triggerZone = workspace.Workspace.Maps.DungeonCleaning.TriggerZone
end

function PlayerService:_setup()
	self.triggerZone.Touched:Connect(function(touchedPart)
		local player = Players:GetPlayerFromCharacter(touchedPart.Parent)
		if player and not self.playerRepository:getPlayer(player) then
			self:onPlayerJoined({ player = player })
		end
	end)
end

function PlayerService:getCameraMode(data)
	return self.coreConstants.CAMERA_MODES.FOLLOWING, nil
end

---@class playerJoinedData
---@field player Player

---@param data playerJoinedData
function PlayerService:onPlayerJoined(data)
	local player = data.player
	local playerEntity = self.playerRepository:getPlayerEntity(player)
	
	player.Changed:Connect(function(property)
		if property == "Parent" then
			self:onPlayerLeft({ player = player })
		end
	end)
end

---@class playerLeftData
---@field player Player

---@param data playerLeftData
function PlayerService:onPlayerLeft(data)
	local player = data.player
	self.playerRepository:removePlayerEntity(player)
end

-- function PlayerService:getPlayerJoinedData(data)
-- 	return data.balista
-- end

-- function PlayerService:getPlayerLeftData(data)
-- 	return data.balista
-- end

-- function PlayerService:_setupRemoteEventListeners()
-- 	self.remoteEventService:connectToEvents({
-- 		[self.constants.REMOTE_EVENTS.SEND_CAMERA_CFRAME] = function(player, eventData)
-- 			player:SetAttribute("CameraCFrame", eventData.data.cameraCFrame)
-- 		end,
-- 	})
-- end

-- function PlayerService:calculatePlayerReward(playerEntity, score)
-- 	return {
-- 		points = score * self.constants.SCORE_REWARD_MULTIPLIER,
-- 	}
-- end

return PlayerService
