---@class DungeonCleaningClientApp
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return DungeonCleaningClientApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
	return self
end

function Application:init()
end

return Application