---@class ServerZoneManager
---@field diContainer DIContainer
---@field constants SharedConstants
---@field minigameLoader MinigameLoader
local ZoneManager = {}
ZoneManager.__index = ZoneManager

---@param diContainer DIContainer
---@return ServerZoneManager
function ZoneManager.new(diContainer)
	local self = setmetatable({}, ZoneManager)
	self.diContainer = diContainer
	return self
end

function ZoneManager:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	---@type MinigameLoader
	self.minigameLoader = self.diContainer:resolve("MinigameLoader")
end

function ZoneManager:startGame(minigameType, players)
	if self:checkMinigameLaunch(minigameType, players) then
		local session = self.minigameLoader:startSession(minigameType)
		warn(session)
		if session then
			self:teleportPlayersToMinigame(players, session.map)
		end
	end
end

---@param minigameType string
---@param players table
function ZoneManager:checkMinigameLaunch(minigameType, players)
	local requirements = self.constants.MINIGAME_REQUIREMENTS[minigameType]

	return #players >= requirements.minPlayers
end

function ZoneManager:teleportPlayersToMinigame(players, map)
	-- for _, player in players do
	--     player:moveTo(map)
	-- end
end

return ZoneManager
