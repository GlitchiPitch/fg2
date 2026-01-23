local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

---@class RemoteEventService
---@field remoteEvent RemoteEvent
---@field _connects table<string, function>
local RemoteEventService = {}
RemoteEventService.__index = RemoteEventService

---@return RemoteEventService
function RemoteEventService.new()
	local self = setmetatable({}, RemoteEventService)
	self.remoteEvent = script.RemoteEvent
	self._connects = {}
	return self
end

---@param connectData table<string, function>
function RemoteEventService:connectToEvents(connectData)
	for eventName, callback in connectData do
		if not self._connects[eventName] then
			local function _serverCallback(player, eventData)
				if eventData.eventName == eventName then
					callback(player, eventData)
				end
			end

			local function _clientCallback(eventData)
				if eventData.eventName == eventName then
					callback(eventData)
				end
			end

			local _signal = if RunService:IsServer()
				then self.remoteEvent.OnServerEvent
				else self.remoteEvent.OnClientEvent
			local _callback = if RunService:IsServer() then _serverCallback else _clientCallback
			self._connects[eventName] = _signal:Connect(_callback)
		end
	end
end

---@class eventData
---@field eventName string
---@field data table

if RunService:IsServer() then
	---@param player Player
	---@param eventData eventData
	function RemoteEventService:fireClient(player, eventData)
		self.remoteEvent:FireClient(player, eventData)
	end

	function RemoteEventService:fireAllClients(eventData)
		for _, player in Players:GetPlayers() do
			self:fireClient(player, eventData)
		end
	end
else
	---@param eventData eventData
	function RemoteEventService:fireServer(eventData)
		self.remoteEvent:FireServer(eventData)
	end
end

---@param eventName string
---@return boolean
function RemoteEventService:_validateEvent(eventName)
	if not self._connects[eventName] then
		warn(`{eventName} is not exist`)
		return false
	end

	return true
end

return RemoteEventService
