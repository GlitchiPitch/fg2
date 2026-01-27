---@class miniGameEntityData
---@field defaultTime number

---@class MiniGameEntity
---@field time IntValue
---@field config miniGameEntityData
local Game = {}
Game.__index = Game

---@param gameModule ModuleScript
---@return MiniGameEntity
function Game.new(gameModule)
	local self = setmetatable({}, Game)
	self.time = gameModule:FindFirstChild("Time") or Instance.new("IntValue")
	
	self.time.Name = "Time"
	self.time.Parent = gameModule
	return self
end

---@param data miniGameEntityData
function Game:fromData(data)
	self.config = data
	self.time.Value = data.defaultTime
end

---@param timer number
function Game:updateTime(timer)
	self.time.Value += timer
end

---@return boolean
function Game:hasTime()
	return self.time.Value > 0
end

function Game:finish()
	self.time.Value = self.config.defaultTime
end

return Game
