local Services = require(script.Services)
local UseCases = require(script.UseCases)
local Controllers = require(script.Controllers)
---@class ClientApp
---@field services ClientAppServices
---@field useCases ClientUseCases
---@field controllers ClientControllers
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return ClientApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
	self.services = Services.new(diContainer)
	self.useCases = UseCases.new(diContainer)
	self.controllers = Controllers.new(diContainer)
	return self
end

function Application:init()
	self.services:init()
	self.useCases:init()
	self.controllers:init()
end

return Application
