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
	self.application:start()
end

function Server:endSession()
	self.application:stop()
end

return Server
