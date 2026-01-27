---@class ShootingPlayerEntity
---@field score IntValue
---@field player Player
local Player = {}
Player.__index = Player

---@param player Player
---@return ShootingPlayerEntity
function Player.new(player)
	local self = setmetatable({}, Player)
	self.player = player

	print(self.player:FindFirstChild("Score"))

	self.score = self.player:FindFirstChild("Score") or Instance.new("IntValue")
	self.score.Name = "Score"
	self.score.Parent = self.player

	warn(self)
	return self
end

function Player:addScore(score)
	self.score:SetAttribute("OldValue", self.score.Value)
	self.score.Value += score
end

function Player:destroy()
	warn("destroy player", self.score)
	if self.score then
		warn("destroy score")
		self.score:Destroy()
	end
end

return Player
