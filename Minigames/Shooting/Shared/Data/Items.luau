local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Minigames.Shooting.Assets)

---@class ShootingSharedDataItem
---@field name string
---@field image string
---@field model Model

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
    Starship = {
        name = "Starship",
        image = "rbxassetid://1234567890",
        model = Assets.Starship,
    },
    BigStarship = {
        name = "Big Starship",
        image = "rbxassetid://1234567890",
        model = Assets.BigStarship,
    },
    Tank = {
        name = "Tank",
        image = "rbxassetid://1234567890",
        model = Assets.Tank,
    },
    LightTank = {
        name = "Light Tank",
        image = "rbxassetid://1234567890",
        model = Assets.LightTank,
    },
}

return Items