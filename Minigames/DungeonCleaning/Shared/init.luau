local Domain = require(script.Domain)
local Constants = require(script.Constants)
local Data = require(script.Data)
local Assets = require(script.Assets)
---@class SharedDungeonCleaning
---@field domain SharedDungeonCleaningDomain
---@field data SharedDungeonCleaningData
---@field constants SharedDungeonCleaningConstants
---@field eventBus EventBus
---@field coreEventBus EventBus
---@field coreConstants SharedConstants
---@field remoteEventService RemoteEventService
---@field assets SharedDungeonCleaningAssets
local Shared = {}
Shared.__index = Shared

---@param globalDIContainer DIContainer
---@return SharedDungeonCleaning
function Shared.new(globalDIContainer)
	local self = setmetatable({}, Shared)
	self.globalDIContainer = globalDIContainer
	self.diContainer = globalDIContainer.new()

	self.domain = Domain.new()
	self.constants = Constants
	self.data = Data
	self.assets = Assets
	return self
end

function Shared:init()
	---@type Shared
	local shared = self.globalDIContainer:resolve("Shared")
	self.eventBus = shared.eventBus.new()
	self.remoteEventService = shared.remoteEventService.new()
	self.coreEventBus = shared.eventBus
	self.coreConstants = shared.constants
end

return Shared
