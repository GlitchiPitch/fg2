local Constants = require(script.Constants)
local Assets = require(script.Assets)
local Data = require(script.Data)
local Domain = require(script.Domain)
local Infrastructure = require(script.Infrastructure)

---@class SharedShooting
---@field constants ShootingConstants
---@field assets ShootingSharedAssets
---@field data ShootingSharedData
---@field domain SharedShootingDomain
---@field eventBus EventBus
---@field coreEventBus EventBus
---@field coreConstants SharedConstants
---@field remoteEventService RemoteEventService
---@field infrastructure SharedShootingInfrastructure
local Shared = {}
Shared.__index = Shared

---@param globalDIContainer DIContainer
---@return SharedShooting
function Shared.new(globalDIContainer)
	local self = setmetatable({}, Shared)
	self.globalDIContainer = globalDIContainer
	self.diContainer = globalDIContainer.new()
	self.constants = Constants
	self.assets = Assets
	self.data = Data

	self.infrastructure = Infrastructure.new(self.diContainer)
	self.domain = Domain.new()
	return self
end

function Shared:init()
	---@type Shared
	local shared = self.globalDIContainer:resolve("Shared")
	self.eventBus = shared.eventBus.new()
	self.remoteEventService = shared.remoteEventService.new()
	self.coreEventBus = shared.eventBus
	self.coreConstants = shared.constants

	self.infrastructure:init()
end

return Shared
