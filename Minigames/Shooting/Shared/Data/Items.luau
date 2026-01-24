local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Minigames.Shooting.Assets)

---@class ShootingSharedDataItems
local Items = {
    SpaceMan = {
        name = "Sailor",
        image = "rbxassetid://1234567890",
        model = Assets.SpaceMan,
    },
    SpaceGirl = {
        name = "Space Girl",
        image = "rbxassetid://1234567890",
        model = Assets.SpaceGirl,
    },
    Box = {
        name = "Box",
        image = "rbxassetid://1234567890",
        model = Assets.Box,
    },
    Ship = {
        name = "Ship",
        image = "rbxassetid://1234567890",
        model = Assets.Ship,
    },
}

return Items