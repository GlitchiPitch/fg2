local Domain = require(script.Domain)

---@class SharedRacing
---@field domain SharedRacingDomain
---@field eventBus EventBus
---@field coreEventBus EventBus
---@field coreConstants SharedConstants
---@field remoteEventService RemoteEventService
local Shared = {}
Shared.__index = Shared

---@param globalDIContainer DIContainer
---@return SharedRacing
function Shared.new(globalDIContainer)
	local self = setmetatable({}, Shared)
	self.globalDIContainer = globalDIContainer
	self.diContainer = globalDIContainer.new()

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
end

return Shared
