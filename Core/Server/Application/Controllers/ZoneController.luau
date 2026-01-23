local Players = game:GetService("Players")
---@class ZoneController
---@field diContainer DIContainer
---@field eventBus EventBus
---@field constants SharedConstants
local ZoneController = {}
ZoneController.__index = ZoneController

---@param diContainer DIContainer
---@return ZoneController
function ZoneController.new(diContainer)
	local self = setmetatable({}, ZoneController)
	self.diContainer = diContainer
	self._deltaTime = 0
	self._updateInterval = 1
	self.zones = workspace.Zones:GetChildren()
	return self
end

function ZoneController:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.eventBus = shared.eventBus
	self.constants = shared.constants
end

function ZoneController:update(deltaTime)
	self._deltaTime += deltaTime
	if self._deltaTime >= self._updateInterval then
		self._deltaTime = 0
	end
end

function ZoneController:_checkPlayerInZones()
	---@param zone Part
	for _, zone in self.zones do
		local playersIntoZone = {}
		local partsInBox = zone:GetPartsInBox(zone.CFrame, zone.Size)
		for _, part in partsInBox do
            local player = Players:GetPlayerFromCharacter(part.Parent)
			if player and not playersIntoZone[player.Name] then
				playersIntoZone[player.Name] = player
			end
		end
        if #playersIntoZone >= self.constants.MINIGAME_REQUIREMENTS[zone.Name].minPlayers then
            -- self:startGame(zone.Name, playersIntoZone)
            
        end
	end
end

return ZoneController
