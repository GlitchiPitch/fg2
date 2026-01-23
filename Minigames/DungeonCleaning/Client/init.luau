local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MinigameMaster = require(ReplicatedStorage.Shared.MinigameMaster)

---@class DungeonCleaningClient : MinigameMaster
local Client = {}	
Client.__index = Client

---@param globalDIContainer DIContainer
---@return DungeonCleaningClient
function Client.new(globalDIContainer)
	local self = setmetatable(MinigameMaster.new(globalDIContainer, {
		Shared = require(ReplicatedStorage.Minigames.DungeonCleaning),
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