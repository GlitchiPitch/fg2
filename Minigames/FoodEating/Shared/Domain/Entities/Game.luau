local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGameEntity = require(ReplicatedStorage.Shared.Domain.MiniGameEntities.Game)

---@class FoodEatingGameEntity : MiniGameEntity
local Game = setmetatable({}, CoreGameEntity)
Game.__index = Game

---@return FoodEatingGameEntity
function Game.new()
	local self = setmetatable(CoreGameEntity.new(script), Game)
	return self
end

return Game
