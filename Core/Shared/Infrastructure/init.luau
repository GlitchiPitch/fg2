local DIContainer = require(script.DIContainer)
local Services = require(script.Services)
local EventBus = require(script.EventBus)
---@class Infrastructure
---@field diContainer DIContainer
---@field services SharedInfrastructureServices
---@field eventBus EventBus
local Infrastructure = {}
Infrastructure.__index = Infrastructure

---@return Infrastructure
function Infrastructure.new()
    local self = setmetatable({}, Infrastructure)
    self.diContainer = DIContainer.new()
    self.services = Services.new()
    self.eventBus = EventBus.new()
    return self
end

return Infrastructure