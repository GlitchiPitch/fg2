local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseGameService = require(ReplicatedStorage.Shared.Minigame.Application.Services.BaseGameService)

---@class ServerDungeonCleaningGameService : BaseMinigameGameService
---@field playerRepository ServerPlayerRepository
---@field triggerZone Part
local GameService = setmetatable({}, BaseGameService)
GameService.__index = GameService

---@param diContainer DIContainer
---@return ServerDungeonCleaningGameService
function GameService.new(diContainer)
	local self = setmetatable(
		BaseGameService.new(diContainer, {
			defaultTime = 45,
			gameName = "DungeonCleaning",
		}),
		GameService
	)
	return self
end

function GameService:_onInit()
	---@type SharedDungeonCleaning
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	---@type ServerDungeonCleaningInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.repositories.playerRepository

	self.triggerZone = workspace.Workspace.Maps.DungeonCleaning.TriggerZone
	self:_setup()
end

function GameService:_setup()
	self.triggerZone.Touched:Connect(function(touchedPart)
		local player = Players:GetPlayerFromCharacter(touchedPart.Parent)
		if player and not self.playerRepository.playerEntities[player.UserId] then
			self:onPlayerJoined({ player = player })
		end
	end)
end

---@param data playerJoinedData
function GameService:onPlayerJoined(data)
	warn("onPlayerJoined", self.constants.SERVER_EVENTS.PLAYER_JOINED_DUNGEON_CLEANING)
	self.eventBus:fire(self.constants.SERVER_EVENTS.PLAYER_JOINED_DUNGEON_CLEANING, data)
end

---@param data playerLeftData
function GameService:onPlayerLeft(data)
	-- self.eventBus:fire(self.constants.SERVER_EVENTS.PLAYER_LEFT_DUNGEON_CLEANING, data)
end

return GameService
