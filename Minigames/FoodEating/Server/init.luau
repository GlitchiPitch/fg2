local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MinigameMaster = require(ReplicatedStorage.Shared.MinigameMaster)

---@class FoodEatingServer : MinigameMaster
local Server = setmetatable({}, MinigameMaster)
Server.__index = Server

---@return FoodEatingServer
function Server.new(globalDIContainer)
	local self = setmetatable(MinigameMaster.new(globalDIContainer, {
		Shared = require(ReplicatedStorage.Minigames.FoodEating),
		Infrastructure = require(script.Infrastructure),
		Application = require(script.Application),
	}), Server)

	return self
end

function Server:init()
	MinigameMaster.init(self)
end

function Server:startSession()
	warn("startSession")
	return {
        map = "FoodEating"
    }
end

function Server:endSession()
	warn("endSession")
	return {
        map = "FoodEating"
    }
end

return Server