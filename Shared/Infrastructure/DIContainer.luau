---@alias _availableNames '"Shared"' | '"Infrastructure"' | '"Application"' | '"Presentation"' | '"Domain"'

---@class DIContainer
---@field _singletons table<string, function>
local DIContainer = {}
DIContainer.__index = DIContainer

---@return DIContainer
function DIContainer.new()
	local self = setmetatable({}, DIContainer)
	self._singletons = {}
	return self
end

---@param name _availableNames
---@param factory function
function DIContainer:singleton(name, factory)
	if not self._singletons[name] then
		self._singletons[name] = factory
	end
end

---@param name _availableNames
---@return any
function DIContainer:resolve(name)
	if not self._singletons[name] then
		warn(`{name} is not registered`)
		return {}
	end

	return self._singletons[name]()
end

return DIContainer
