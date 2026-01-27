---@class MiniGamePlayerEntity
local Player = {}
Player.__index = Player

---@param player Player
---@return MiniGamePlayerEntity
function Player.new(player)
	local self = setmetatable({}, Player)
	self.player = player
	self.score = player:FindFirstChild("Score") or Instance.new("IntValue")
	self.score.Name = "Score"
	self.score.Parent = player
	return self
end

function Player:getData()
	return {}
end

function Player:addScore(score)
	self.score:SetAttribute("OldValue", self.score.Value)
	self.score.Value += score
end

function Player:destroy()
	if self.score then
		self.score:Destroy()
		self.score = nil
	end
end


return Player