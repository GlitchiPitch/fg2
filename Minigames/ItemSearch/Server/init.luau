local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MinigameMaster = require(ReplicatedStorage.Shared.MinigameMaster)

---@class ItemSearchServer : MinigameMaster
local Server = {}
Server.__index = Server

---@return ItemSearchServer
function Server.new(globalDIContainer)
	local self = setmetatable(
		MinigameMaster.new(globalDIContainer, {
			Shared = require(ReplicatedStorage.Minigames.ItemSearch),
			Infrastructure = require(script.Infrastructure),
			Application = require(script.Application),
		}),
		Server
	)

	return self
end

function Server:init()
	MinigameMaster.init(self)
end

return Server
