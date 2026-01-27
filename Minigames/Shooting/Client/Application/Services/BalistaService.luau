---@class ClientBalistaService
---@field diContainer DIContainer
---@field balistaRepository ClientShootingBalistaRepository
---@field remoteEventService RemoteEventService
local BalistaService = {}
BalistaService.__index = BalistaService

---@param diContainer DIContainer
---@return ClientBalistaService
function BalistaService.new(diContainer)
	local self = setmetatable({}, BalistaService)
	self.diContainer = diContainer
	return self
end

function BalistaService:init()
	---@type SharedShooting
	local shared = self.diContainer:resolve("Shared")
	---@type ClientShootingInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.balistaRepository = infrastructure.repositories.balistaRepository

	self.constants = shared.constants
	self.eventBus = shared.eventBus

	self.remoteEventService = shared.remoteEventService

	self:_setupEventListeners()
	self:_setupRemoteEventListeners()
end

function BalistaService:_setupRemoteEventListeners()
	self.remoteEventService:connectToEvents({
		[self.constants.REMOTE_EVENTS.SHOOT] = function(eventData)
			self:_onShoot(eventData.data)
		end,
	})
end

function BalistaService:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.CLIENT_EVENTS.PLAYER_JOINED_BALISTA] = function(data)
			self:onPlayerJoinedBalista(data)
		end,
		[self.constants.CLIENT_EVENTS.PLAYER_LEFT_BALISTA] = function(data)
			self:onPlayerLeftBalista(data)
		end,
	})
end

---@param data table
function BalistaService:onPlayerJoinedBalista(data)
	local balistaEntity = self.balistaRepository:createBalistaEntity(data)
	self.balistaRepository:setBallistaId(balistaEntity.id)
end

---@param data table
function BalistaService:onPlayerLeftBalista(data)
	self.balistaRepository:removeBalistaEntity(data.id)
	self.balistaRepository:setBallistaId(nil)
end

---@param data table
function BalistaService:_onShoot(data)
	-- self.balistaRepository:shoot(data.id)
	self.eventBus:fire(self.constants.CLIENT_EVENTS.SHOOT, data.balista)
end

function BalistaService:getBalistaEntity()
	return self.balistaRepository:getBalistaEntity(self.balistaRepository.ballistaId)
end

return BalistaService
