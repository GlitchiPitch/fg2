local Services = require(script.Services)
local Controllers = require(script.Controllers)
---@class ServerShootingApp
---@field services ServerShootingAppServices
---@field controllers ServerShootingControllers
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return ServerShootingApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
	self.diContainer = diContainer
	self.services = Services.new(self.diContainer)
	self.controllers = Controllers.new(self.diContainer)
	return self
end

function Application:init()
	---@type SharedShooting
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	self.services:init()
	self.controllers:init()

	self.eventBus:connectToEvents({
		[self.constants.SERVER_EVENTS.GAME_FINISHED] = function()
			warn("shooting game finished")
			self:stop()
		end,
	})
end

function Application:start()
	self.controllers:start()
end

function Application:stop()
	self.controllers:stop()
	self.services.gameService:finish()
	self.services.playerService:finish()
	self.services.targetService:finish()
end

return Application
