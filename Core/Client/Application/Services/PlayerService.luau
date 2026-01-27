local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedPlayerService = require(ReplicatedStorage.Shared.Application.Services.PlayerService)

---@class ClientPlayerService : SharedPlayerService
---@field playerRepository ClientPlayerRepository
---@field player Player
---@field constants SharedConstants
---@field eventBus EventBus
local PlayerService = setmetatable({}, SharedPlayerService)
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ClientPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable(SharedPlayerService.new(diContainer), PlayerService)
	self.player = Players.LocalPlayer
	return self
end

function PlayerService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus
	self.remoteEventService = shared.remoteEventService
	
	self:_setupRemoteEventListeners()
	SharedPlayerService.init(self)
end

function PlayerService:_setupRemoteEventListeners()
	self.remoteEventService:connectToEvents({
		[self.constants.REMOTE_EVENTS.SET_PLAYER_CAMERA_MODE] = function(eventData)
			self:onSetPlayerCameraMode(eventData.data)
		end,
	})
end
---@class onPlayerAddedData
---@field player Player

---@param data onPlayerAddedData
function PlayerService:onPlayerAdded(data)
	SharedPlayerService.onPlayerAdded(self, data)

	local player = data.player
	---@type PlayerEntity
	local playerEntity = self.playerRepository:getPlayerEntity(player)
	self:updatePlayer({ player = playerEntity })

	player:GetAttributeChangedSignal(self.constants.PLAYER_ATTRIBUTES.CAMERA_MODE):Connect(function()
		local mode = player:GetAttribute(self.constants.PLAYER_ATTRIBUTES.CAMERA_MODE)
		self:onSetPlayerCameraMode({ mode = mode })
	end)
end

function PlayerService:onPlayerRemoving(data)
	local player = data.player
	self.playerRepository:removePlayerEntity(player)
end

function PlayerService:updatePlayer(data)
	local player = data.player
	self.playerRepository:updatePlayer(player)
end

function PlayerService:onCharacterAdded(data)
	local character = data.character
	self.eventBus:fire(self.constants.CLIENT_EVENTS.ON_CHARACTER_ADDED, {
		character = character,
	})
end

---@param data table
function PlayerService:onSetPlayerCameraMode(data)
	local mode = data.mode
	local cameraCFrame = data.cameraCFrame
	self.eventBus:fire(self.constants.CLIENT_EVENTS.SET_CAMERA_MODE, {
		mode = mode,
		cameraCFrame = cameraCFrame,
	})
end

return PlayerService
