local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MinigameMaster = require(ReplicatedStorage.Shared.MinigameMaster)

---@class ShootingClient : MinigameMaster
local Client = setmetatable({}, MinigameMaster)
Client.__index = Client

---@param globalDIContainer DIContainer
---@return ShootingClient
function Client.new(globalDIContainer)
	local self = setmetatable(
		MinigameMaster.new(globalDIContainer, {
			Shared = require(ReplicatedStorage.Minigames.Shooting),
			Infrastructure = require(script.Infrastructure),
			Application = require(script.Application),
			Presentation = require(script.Presentation),
		}),
		Client
	)
	return self
end

function Client:init()
	MinigameMaster.init(self)
end

function Client:start()
	
end

function Client:stop()
	
end

return Client
