local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MinigameMaster = require(ReplicatedStorage.Shared.MinigameMaster)

---@class FoodEatingServer : MinigameMaster
local Server = {}
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

return Server