local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CorePlayerEntity = require(ReplicatedStorage.Shared.Domain.MiniGameEntities.Player)

---@class RacingPlayerEntity : MiniGamePlayerEntity
---@field score IntValue
---@field player Player
local Player = setmetatable({}, CorePlayerEntity)
Player.__index = Player

---@param player Player
---@return RacingPlayerEntity
function Player.new(player)
	local self = setmetatable(CorePlayerEntity.new(player), Player)
	return self
end

return Player
