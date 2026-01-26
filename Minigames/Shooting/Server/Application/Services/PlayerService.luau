---@class ServerShootingPlayerService
---@field diContainer DIContainer
---@field constants ShootingConstants
---@field eventBus EventBus
---@field coreEventBus EventBus
local PlayerService = {}
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ServerShootingPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable({}, PlayerService)
	self.diContainer = diContainer
	return self
end

function PlayerService:init()
	---@type ShootingShared
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus
	self.coreEventBus = shared.coreEventBus
	self.coreConstants = shared.coreConstants
	self.remoteEventService = shared.remoteEventService

	self.eventBus:connectToEvents({
		[self.constants.SERVER_EVENTS.PLAYER_JOINED_BALISTA] = function(data)
			self:onPlayerJoinedBalista(data)
		end,
		[self.constants.SERVER_EVENTS.PLAYER_LEFT_BALISTA] = function(data)
			self:onPlayerLeftBalista(data)
		end,
	})
end

---@class onPlayerJoinedBalistaData
---@field player Player
---@field balista BalistaEntity

---@param data onPlayerJoinedBalistaData
function PlayerService:onPlayerJoinedBalista(data)
	local player = data.player
	local balista = data.balista
	self.coreEventBus:fire(self.coreConstants.SERVER_EVENTS.SET_PLAYER_CAMERA_MODE, {
		player = player,
		mode = self.coreConstants.CAMERA_MODES.FOLLOWING,
	})
	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.PLAYER_JOINED_BALISTA,
		data = balista,
	})
end

---@class onPlayerLeftBalistaData
---@field player Player

---@param data onPlayerLeftBalistaData
function PlayerService:onPlayerLeftBalista(data)
	local player = data.player
	local balista = data.balista
	self.coreEventBus:fire(self.coreConstants.SERVER_EVENTS.SET_PLAYER_CAMERA_MODE, {
		player = player,
		mode = self.coreConstants.CAMERA_MODES.DEFAULT,
	})
	self.remoteEventService:fireClient(player, {
		eventName = self.constants.REMOTE_EVENTS.PLAYER_LEFT_BALISTA,
		data = balista,
	})
end

return PlayerService
