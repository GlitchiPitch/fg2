local RemoteEventService = require(script.RemoteEventService)

---@class SharedInfrastructureServices
---@field remoteEventService RemoteEventService
local Services = {}
Services.__index = Services

---@return SharedInfrastructureServices
function Services.new()
	local self = setmetatable({}, Services)
	self.remoteEventService = RemoteEventService.new()
	return self
end

return Services
