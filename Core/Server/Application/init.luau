local UseCases = require(script.UseCases)
local Services = require(script.Services)
---@class ServerApp
---@field diContainer DIContainer
---@field useCases ServerUseCases
---@field services ServerAppServices
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return ServerApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
	self.diContainer = diContainer
    self.useCases = UseCases.new(self.diContainer)
    self.services = Services.new(self.diContainer)
	return self
end

function Application:init()
	self.useCases:init()
	self.services:init()
end

return Application
