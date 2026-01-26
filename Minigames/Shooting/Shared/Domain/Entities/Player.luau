---@class ShootingPlayerEntity
---@field score number
---@field player Player
local Player = {}
Player.__index = Player

---@param player Player
---@return ShootingPlayerEntity
function Player.new(player)
	local self = setmetatable({}, Player)
	self.player = player
	self.score = 0
	return self
end

function Player:toData()
	warn("toData")
	return {
		score = self.score,
	}
end

function Player:fromData(data)
	warn("fromData")
	self.score = data.score
end

function Player:addScore(score)
	self.score += score
end

return Player
