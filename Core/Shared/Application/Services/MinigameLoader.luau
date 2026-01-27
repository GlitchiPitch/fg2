---@class MinigameLoader
---@field diContainer DIContainer
---@field loadedMinigames table<string, table>
---@field activeSessions table<string, table>
---@field minigameModules table
local MinigameLoader = {}
MinigameLoader.__index = MinigameLoader

---@param diContainer DIContainer
---@param minigameModules table
---@return MinigameLoader
function MinigameLoader.new(diContainer, minigameModules)
	local self = setmetatable({}, MinigameLoader)
	self.diContainer = diContainer
	self.loadedMinigames = {}
	self.activeSessions = {}

	-- Registry of available minigames
	self.minigameModules = minigameModules

	return self
end

---@param minigameType string
---@return table? session
function MinigameLoader:loadMinigame(minigameType)
	if self.loadedMinigames[minigameType] then
		return self.loadedMinigames[minigameType]
	end

	local moduleInfo = self.minigameModules[minigameType]
	if not moduleInfo then
		return nil
	end

	-- Create minigame instance
	local minigameInstance = moduleInfo.new(self.diContainer)
	minigameInstance:init()

	-- Cache it
	self.loadedMinigames[minigameType] = minigameInstance
	return minigameInstance
end

---@param sessionId string
function MinigameLoader:unloadMinigame(sessionId)
	local session = self.activeSessions[sessionId]
	if session then
		session:endSession()
		self.activeSessions[sessionId] = nil
	end
end

---@param minigameType string
function MinigameLoader:startSession(minigameType)
	local minigameInstance = self:loadMinigame(minigameType)
	return minigameInstance:startSession()
end

function MinigameLoader:endSession(minigameType)
	local minigameInstance = self:loadMinigame(minigameType)
	return minigameInstance:endSession()
end

return MinigameLoader
