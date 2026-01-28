local Domain = require(script.Domain)
local Constants = require(script.Constants)
local Assets = require(script.Assets)
local Data = require(script.Data)
local Infrastructure = require(script.Infrastructure)

---@class SharedFoodEating
---@field domain SharedFoodEatingDomain
---@field eventBus EventBus
---@field constants SharedFoodEatingConstants
---@field coreEventBus EventBus
---@field coreConstants SharedConstants
---@field remoteEventService RemoteEventService
---@field assets SharedFoodEatingAssets
---@field infrastructure SharedFoodEatingInfrastructure
---@field data SharedFoodEatingData
local Shared = {}
Shared.__index = Shared

---@param globalDIContainer DIContainer
---@return SharedFoodEating
function Shared.new(globalDIContainer)
	local self = setmetatable({}, Shared)
	self.globalDIContainer = globalDIContainer
	self.diContainer = globalDIContainer.new()
	self.constants = Constants
	self.domain = Domain.new()
	self.assets = Assets
	self.infrastructure = Infrastructure.new(self.diContainer)
	self.data = Data
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
