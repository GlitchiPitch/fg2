local Repositories = require(script.Repositories)

---@class ClientInfrastructure
---@field diContainer DIContainer
---@field repositories ClientRepositories
local Infrastructure = {}
Infrastructure.__index = Infrastructure

---@param diContainer DIContainer
---@return ClientInfrastructure
function Infrastructure.new(diContainer)
    local self = setmetatable({}, Infrastructure)
    self.repositories = Repositories.new(diContainer)
    return self
end

function Infrastructure:init()
    self.repositories:init()
end


return Infrastructure