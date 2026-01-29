local BasePlayerService = require(script.Parent.BasePlayerService)

---@class BaseClientPlayerServiceConfig : BasePlayerServiceConfig
---@field coreApplicationKey string?
---@field applicationKey string?
---@field playerJoinedRemoteEvent string
---@field playerLeftRemoteEvent string
---@field playerJoinedClientEvent string
---@field playerLeftClientEvent string

---@class BaseMinigameClientPlayerService : BaseMinigamePlayerService
local PlayerService = setmetatable({}, BasePlayerService)
PlayerService.__index = PlayerService

function PlayerService.new(diContainer, config)
	local self = setmetatable(BasePlayerService.new(diContainer, config), PlayerService)
	self._connections = {}
	self.config.coreApplicationKey = self.config.coreApplicationKey or "CoreApplication"
	self.config.applicationKey = self.config.applicationKey or "Application"
	return self
end

function PlayerService:init()
	BasePlayerService.init(self)

	local coreApplication = self.diContainer:resolve(self.config.coreApplicationKey)
	self.player = coreApplication.services.playerService.player

	-- Application might not exist in all setups
	pcall(function()
		self.application = self.diContainer:resolve(self.config.applicationKey)
	end)

	self:_setupRemoteEventListeners()
end

function PlayerService:_setupRemoteEventListeners()
	self.remoteEventService:connectToEvents({
		[self.constants.REMOTE_EVENTS[self.config.playerJoinedRemoteEvent]] = function(eventData)
			self:onPlayerJoined(eventData.data)
		end,
		[self.constants.REMOTE_EVENTS[self.config.playerLeftRemoteEvent]] = function(eventData)
			self:onPlayerLeft(eventData.data)
		end,
	})
end

function PlayerService:getPlayerEntity()
	return self.playerRepository:getPlayerEntity(self.player)
end

function PlayerService:onPlayerJoined(data)
	self.playerRepository:createPlayerEntity(self.player)
	self:_setupPlayer()

	self:_beforePlayerJoined(data)

	if self.application and self.application.start then
		self.application:start()
	end

	self.eventBus:fire(self.constants.CLIENT_EVENTS[self.config.playerJoinedClientEvent], data)

	self:_afterPlayerJoined(data)
end

function PlayerService:_beforePlayerJoined(data) end
function PlayerService:_afterPlayerJoined(data) end

function PlayerService:onPlayerLeft(data)
	self:_beforePlayerLeft(data)

	if self.application and self.application.stop then
		self.application:stop()
	end

	self.playerRepository:removePlayerEntity(self.player)
	self:_removePlayer()

	self.eventBus:fire(self.constants.CLIENT_EVENTS[self.config.playerLeftClientEvent], data)

	self:_afterPlayerLeft(data)
end

function PlayerService:_beforePlayerLeft(data) end
function PlayerService:_afterPlayerLeft(data) end

function PlayerService:_setupPlayer()
	local playerEntity = self.playerRepository:getPlayerEntity(self.player)

	self._connections.score = playerEntity.score.Changed:Connect(function(score)
		local oldValue = playerEntity.score:GetAttribute("OldValue")
		self.eventBus:fire(self.constants.CLIENT_EVENTS.UPDATE_SCORE, {
			score = score,
			addedScore = score - oldValue,
		})
	end)

	self:_onSetupPlayer(playerEntity)
end

function PlayerService:_onSetupPlayer(playerEntity) end

function PlayerService:_removePlayer()
	for _, connection in self._connections do
		connection:Disconnect()
	end
	self._connections = {}
end

function PlayerService:onAddScore(data) end

return PlayerService
