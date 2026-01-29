local Services = require(script.Services)
---@class DungeonCleaningClientApp
---@field services ClientDungeonCleaningAppServices
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return DungeonCleaningClientApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
	self.services = Services.new(diContainer)
	return self
end

function Application:init()
	self.services:init()
end

return Application