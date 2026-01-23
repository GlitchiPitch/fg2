local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MinigameMaster = require(ReplicatedStorage.Shared.MinigameMaster)

---@class FoodEatingClient : MinigameMaster
local Client = setmetatable({}, MinigameMaster)
Client.__index = Client

---@return FoodEatingClient
function Client.new(globalDIContainer)
	local self = setmetatable(MinigameMaster.new(globalDIContainer, {
		Shared = require(ReplicatedStorage.Minigames.FoodEating),
		Infrastructure = require(script.Infrastructure),
		Application = require(script.Application),
		Presentation = require(script.Presentation),
	}), Client)
	return self
end

function Client:init()
	MinigameMaster.init(self)
end

return Client