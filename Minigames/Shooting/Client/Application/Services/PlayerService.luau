---@class ShootingClientPlayerService
---@field player Player
---@field constants ShootingConstants
---@field eventBus EventBus
---@field remoteEventService RemoteEventService
local PlayerService = {}
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ShootingClientPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable({}, PlayerService)
	self.diContainer = diContainer
	return self
end

function PlayerService:init()
	---@type ShootingShared
	local shared = self.diContainer:resolve("Shared")
	---@type ClientApp
	local coreApplication = self.diContainer:resolve("CoreApplication")
	self.player = coreApplication.services.playerService.player

	self.constants = shared.constants
	self.eventBus = shared.eventBus
	self.remoteEventService = shared.remoteEventService

	self.remoteEventService:connectToEvents({
		[self.constants.REMOTE_EVENTS.PLAYER_JOINED_BALISTA] = function()
			self:onPlayerJoinedBalista()
		end,
		[self.constants.REMOTE_EVENTS.PLAYER_LEFT_BALISTA] = function()
			self:onPlayerLeftBalista()
		end,
	})
end

function PlayerService:onPlayerJoinedBalista()
	for _, v in self.player.Character:GetDescendants() do
		if v:IsA("BasePart") then
			v.Transparency = 1
		end
	end

    self.eventBus:fire(self.constants.CLIENT_EVENTS.PLAYER_JOINED_BALISTA)
end

function PlayerService:onPlayerLeftBalista()
	for _, v in self.player.Character:GetDescendants() do
		if v:IsA("BasePart") then
			v.Transparency = if v.Name == "HumanoidRootPart" then 1 else 0
		end
	end

    self.eventBus:fire(self.constants.CLIENT_EVENTS.PLAYER_LEFT_BALISTA)
end

return PlayerService
