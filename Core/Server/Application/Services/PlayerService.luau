local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedPlayerService = require(ReplicatedStorage.Shared.Application.Services.PlayerService)

---@class ServerPlayerService : SharedPlayerService
---@field playerRepository ServerPlayerRepository
local PlayerService = setmetatable({}, SharedPlayerService)
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ServerPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable(SharedPlayerService.new(diContainer), PlayerService)
	return self
end

function PlayerService:init()
	SharedPlayerService.init(self)

    ---@type Shared
    local shared = self.diContainer:resolve("Shared")
    self.constants = shared.constants
    self.eventBus = shared.eventBus
	self.remoteEventService = shared.remoteEventService

    self.eventBus:connectToEvents({
        [self.constants.SERVER_EVENTS.SET_PLAYER_CAMERA_MODE] = function(data)
            self:onSetPlayerCameraMode(data)
        end,
    })
end

function PlayerService:onPlayerAdded(data)
	local player = data.player
	---@type PlayerEntity
	local playerEntity = self.playerRepository:getPlayerEntity(player)
	self:updatePlayer({ player = playerEntity })
end

function PlayerService:onPlayerRemoving(data)
	local player = data.player
	self.playerRepository:removePlayerEntity(player)
end

function PlayerService:updatePlayer(data)
	local player = data.player
	self.playerRepository:updatePlayer(player)
end

function PlayerService:onSetPlayerCameraMode(data)
	local player = data.player
	local mode = data.mode
	local cameraCFrame = data.cameraCFrame
	-- player:SetAttribute(self.constants.PLAYER_ATTRIBUTES.CAMERA_MODE, mode)
	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.SET_PLAYER_CAMERA_MODE,
		data = {
			mode = mode,
			cameraCFrame = cameraCFrame,
		},
	})
end

return PlayerService
