local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MinigameMaster = require(ReplicatedStorage.Shared.MinigameMaster)

---@class RacingServer : MinigameMaster
local Server = setmetatable({}, MinigameMaster)
Server.__index = Server

---@return RacingServer
function Server.new(globalDIContainer)
	local self = setmetatable(
		MinigameMaster.new(globalDIContainer, {
			Shared = require(ReplicatedStorage.Minigames.Racing),
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
        map = "Racing"
    }
end

function Server:endSession()
	warn("endSession")
	return {
        map = "Racing"
    }
end

return Server
