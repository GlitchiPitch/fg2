local Services = require(script.Services)
---@class DungeonCleaningServerApp
---@field services ServerDungeonCleaningAppServices
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return DungeonCleaningServerApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
	self.services = Services.new(diContainer)
	return self
end

function Application:init()
	self.services:init()
end

function Application:start()
	
end

function Application:stop()
	
end

return Application