local Repositories = require(script.Repositories)

---@class ServerInfrastructure
---@field diContainer DIContainer
---@field repositories ServerRepositories
local Infrastructure = {}
Infrastructure.__index = Infrastructure

---@param diContainer DIContainer
---@return ServerInfrastructure
function Infrastructure.new(diContainer)
    local self = setmetatable({}, Infrastructure)
    self.repositories = Repositories.new(diContainer)
    return self
end

function Infrastructure:init()
    self.repositories:init()
end


return Infrastructure