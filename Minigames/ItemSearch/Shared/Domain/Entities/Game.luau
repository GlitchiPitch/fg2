local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGameEntity = require(ReplicatedStorage.Shared.Domain.Entities.Game)

---@class ItemSearchGameEntity
local Game = setmetatable({}, CoreGameEntity)
Game.__index = Game

---@return ItemSearchGameEntity
function Game.new()
	local self = setmetatable(CoreGameEntity.new(script), Game)
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
