local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BasePlayerService = require(ReplicatedStorage.Shared.Minigame.Application.Services.BasePlayerService)

---@class SharedShootingPlayerService : BaseMinigamePlayerService
local PlayerService = setmetatable({}, BasePlayerService)
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return SharedShootingPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable(BasePlayerService.new(diContainer), PlayerService)
	return self
end

function PlayerService:init()
	BasePlayerService.init(self)
end

return PlayerService
