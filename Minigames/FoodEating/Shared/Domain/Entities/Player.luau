local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MiniGamePlayerEntity = require(ReplicatedStorage.Shared.Domain.MiniGameEntities.Player)

---@class FoodEatingPlayerEntity : MiniGamePlayerEntity
---@field score IntValue
---@field player Player
local Player = setmetatable({}, MiniGamePlayerEntity)
Player.__index = Player

return Player
