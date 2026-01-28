local Services = require(script.Services)
local Controllers = require(script.Controllers)
---@class ServerFoodEatingApp
---@field services ServerFoodEatingServices
---@field playerService ServerFoodEatingPlayerService
---@field controllers ServerFoodEatingControllers
---@field diContainer DIContainer
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return ServerFoodEatingApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
	self.services = Services.new(diContainer)
	self.controllers = Controllers.new(diContainer)
	self.diContainer = diContainer
	return self
end

function Application:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	self.services:init()
	self.controllers:init()

	self.eventBus:connectToEvents({
		[self.constants.SERVER_EVENTS.GAME_FINISHED] = function()
			warn("game finished")
			self:stop()
		end,
	})
end

function Application:start()
	self.controllers:start()
end

function Application:stop()
	self.controllers:stop()
end

return Application
