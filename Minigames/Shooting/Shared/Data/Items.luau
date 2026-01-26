local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Minigames.Shooting.Assets)

---@class ShootingSharedDataItem
---@field name string
---@field image string
---@field model Model
---@field score number

---@class ShootingSharedDataItems
local Items = {
    SpaceMan = {
        name = "SpaceMan",
        image = "rbxassetid://94806141361651",
        model = Assets.SpaceMan,
        score = 100,
    },
    SpaceGirl = {
        name = "SpaceGirl",
        image = "rbxassetid://6294594624",
        model = Assets.SpaceGirl,
        score = 100,
    },
    Box = {
        name = "Box",
        image = "rbxassetid://7035916568",
        model = Assets.Box,
        score = 100,
    },
    Starship = {
        name = "Starship",
        image = "rbxassetid://1234567890",
        model = Assets.Starship,
        score = 100,
    },
    BigStarship = {
        name = "BigStarship",
        image = "rbxassetid://1234567890",
        model = Assets.BigStarship,
        score = 100,
    },
    Tank = {
        name = "Tank",
        image = "rbxassetid://1234567890",
        model = Assets.Tank,
        score = 100,
    },
    LightTank = {
        name = "LightTank",
        image = "rbxassetid://1234567890",
        model = Assets.LightTank,
        score = 100,
    },
}

return Items