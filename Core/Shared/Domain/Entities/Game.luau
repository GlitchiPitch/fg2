---@class GameEntity
local Game = {}
Game.__index = Game

---@return GameEntity
function Game.new()
	local self = setmetatable({}, Game)
	self.time = script:FindFirstChild("Time") or Instance.new("IntValue")
	self.time.Name = "Time"
	self.time.Parent = script

	return self
end

---@param data table
function Game:fromData(data)
	self.time.Value = data.time
end

---@param timer number
function Game:updateTime(timer)
	self.time.Value += timer
end

function Game:destroy()
	if self.time then
		self.time:Destroy()
	end
end

return Game
