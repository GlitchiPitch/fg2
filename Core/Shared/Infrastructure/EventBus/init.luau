---@class EventBus
---@field event BindableEvent
---@field _connects table<string, RBXScriptConnection>
local EventBus = {}
EventBus.__index = EventBus

---@return EventBus
function EventBus.new()
	local self = setmetatable({}, EventBus)
	self._connects = {}
	self.event = script.Event
	return self
end

---@param eventName string
---@param data any
function EventBus:fire(eventName, data)
	if not self._connects[eventName] then
		warn(`{eventName} is not connected`)
		return
	end

	self.event:Fire(eventName, data)
end

---@param connectData table<string, function>
function EventBus:connectToEvents(connectData)
	for eventName, callback in connectData do
		local function _callback(_eventName, data)
			if _eventName == eventName then
				callback(data)
			end
		end
		self._connects[eventName] = self.event.Event:Connect(_callback)
	end
end

---@param disconnectData string[]
function EventBus:disconnectFromEvents(disconnectData)
	for _, eventName in disconnectData do
		if self._connects[eventName] then
			self._connects[eventName]:Disconnect()
			self._connects[eventName] = nil
		end
	end
end

return EventBus
