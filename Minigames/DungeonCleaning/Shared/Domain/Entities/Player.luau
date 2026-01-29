local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MiniGamePlayerEntity = require(ReplicatedStorage.Shared.Domain.MiniGameEntities.Player)

---@class DungeonCleaningPlayerEntity : MiniGamePlayerEntity
local Player = setmetatable({}, MiniGamePlayerEntity)
Player.__index = Player

return Player
