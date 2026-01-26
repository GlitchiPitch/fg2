local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MinigameMaster = require(ReplicatedStorage.Shared.MinigameMaster)

---@class ShootingServer : MinigameMaster
local Server = setmetatable({}, MinigameMaster)
Server.__index = Server

---@return ShootingServer
function Server.new(globalDIContainer)
	local self = setmetatable(
		MinigameMaster.new(globalDIContainer, {
			Shared = require(ReplicatedStorage.Minigames.Shooting),
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
        map = "CrossbowShooting"
    }
end

function Server:endSession()
	warn("endSession")
	return {
        map = "CrossbowShooting"
    }
end

return Server
