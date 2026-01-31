local Assets = require(script.Parent.Assets)
local Items = require(script.Items)
---@class SharedDungeonCleaningData
local Data = {
    Items = Items,
    
	Alien = {
        model = Assets.Alien,
        score = 100,
    },
	RedAlien = {
        model = Assets.RedAlien,
        score = 150,
    },
	PurpleAlien = {
        model = Assets.PurpleAlien,
        score = 200,
    },
	AlienLeader = {
        model = Assets.AlienLeader,
        score = 300,
    },
}

return Data
