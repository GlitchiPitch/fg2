local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MinigameMaster = require(ReplicatedStorage.Shared.MinigameMaster)

---@class ItemSearchClient : MinigameMaster
local Client = {}
Client.__index = Client

---@return ItemSearchClient
function Client.new(globalDIContainer)
	local self = setmetatable(MinigameMaster.new(globalDIContainer, {
		Shared = require(ReplicatedStorage.Minigames.ItemSearch),
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