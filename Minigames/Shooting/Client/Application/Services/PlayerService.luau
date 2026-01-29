-- Minigames/Shooting/Client/Application/Services/PlayerService.luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseClientPlayerService = require(ReplicatedStorage.Shared.Minigame.Application.Services.BaseClientPlayerService)

---@class ShootingClientPlayerService : BaseMinigameClientPlayerService
local PlayerService = setmetatable({}, BaseClientPlayerService)
PlayerService.__index = PlayerService

function PlayerService.new(diContainer)
	local self = setmetatable(
		BaseClientPlayerService.new(diContainer, {
			playerJoinedRemoteEvent = "PLAYER_JOINED_BALISTA",
			playerLeftRemoteEvent = "PLAYER_LEFT_BALISTA",
			playerJoinedClientEvent = "PLAYER_JOINED_BALISTA",
			playerLeftClientEvent = "PLAYER_LEFT_BALISTA",
		}),
		PlayerService
	)
	return self
end

-- Custom: Hide character when joining
function PlayerService:_afterPlayerJoined(data)
	for _, v in self.player.Character:GetDescendants() do
		if v:IsA("BasePart") then
			v.Transparency = 1
		end
	end
end

-- Custom: Show character when leaving
function PlayerService:_afterPlayerLeft(data)
	for _, v in self.player.Character:GetDescendants() do
		if v:IsA("BasePart") then
			local targetTransparency = if table.find({ "HumanoidRootPart", "CollisionPart" }, v.Name) then 1 else 0
			v.Transparency = targetTransparency
		end
	end
end

return PlayerService
