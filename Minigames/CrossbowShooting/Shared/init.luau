local Constants = require(script.Constants)
local Assets = require(script.Assets)

---@class CrossbowShootingShared
---@field constants CrossbowShootingConstants
---@field assets CrossbowShootingSharedAssets
---@field eventBus EventBus
---@field coreEventBus EventBus
---@field coreConstants SharedConstants
---@field remoteEventService RemoteEventService
local Shared = {}
Shared.__index = Shared

---@param globalDIContainer DIContainer
---@return CrossbowShootingShared
function Shared.new(globalDIContainer)
	local self = setmetatable({}, Shared)
	self.globalDIContainer = globalDIContainer
	self.diContainer = globalDIContainer.new()
	self.constants = Constants
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