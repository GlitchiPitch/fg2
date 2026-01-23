local Infrastructure = require(script.Infrastructure)
local Constants = require(script.Constants)
local Config = require(script.Config)
local Domain = require(script.Domain)
local Data = require(script.Data)

---@class Shared
---@field domain Domain
---@field infrastructure Infrastructure
---@field diContainer DIContainer
---@field remoteEventService RemoteEventService
---@field eventBus EventBus
---@field config SharedConfig
---@field constants SharedConstants
---@field data SharedData
local Shared = {}
Shared.__index = Shared

---@return Shared
function Shared.new()
	local self = setmetatable({}, Shared)
	self.data = Data
	self.config = Config
	self.constants = Constants

	self.domain = Domain.new()
	self.infrastructure = Infrastructure.new()

	self.diContainer = self.infrastructure.diContainer
	self.remoteEventService = self.infrastructure.services.remoteEventService
	self.eventBus = self.infrastructure.eventBus

	return self
end

return Shared
