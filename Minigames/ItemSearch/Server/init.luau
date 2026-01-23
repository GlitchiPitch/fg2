local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MinigameMaster = require(ReplicatedStorage.Shared.MinigameMaster)

---@class ItemSearchServer : MinigameMaster
local Server = setmetatable({}, MinigameMaster)
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

function Server:startSession()
	warn("startSession")
	return {
        map = "ItemSearch"
    }
end

function Server:endSession()
	warn("endSession")
	return {
        map = "ItemSearch"
    }
end

return Server
