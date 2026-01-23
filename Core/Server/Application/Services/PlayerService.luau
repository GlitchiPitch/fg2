local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedPlayerService = require(ReplicatedStorage.Shared.Application.Services.PlayerService)

---@class ServerPlayerService : SharedPlayerService
---@field playerRepository ServerPlayerRepository
local PlayerService = setmetatable({}, SharedPlayerService)
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return ServerPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable(SharedPlayerService.new(diContainer), PlayerService)
	return self
end

function PlayerService:init()
	SharedPlayerService.init(self)
end

function PlayerService:onPlayerAdded(data)
	local player = data.player
	---@type PlayerEntity
	local playerEntity = self.playerRepository:getPlayerEntity(player)
	self:updatePlayer({ player = playerEntity })
end

function PlayerService:onPlayerRemoving(data)
	local player = data.player
	self.playerRepository:removePlayerEntity(player)
end

function PlayerService:updatePlayer(data)
	local player = data.player
	self.playerRepository:updatePlayer(player)
end

return PlayerService
