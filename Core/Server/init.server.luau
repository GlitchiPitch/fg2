local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Master = require(ReplicatedStorage.Shared.Master)

local Layers = {
	Infrastructure = require(script.Infrastructure),
	Application = require(script.Application),
}

local MinigameModules = {
	CrossbowShooting = require(script.Parent.Minigames.CrossbowShooting),
	ItemSearch = require(script.Parent.Minigames.ItemSearch),
	Racing = require(script.Parent.Minigames.Racing),
	FoodEating = require(script.Parent.Minigames.FoodEating),
	DungeonCleaning = require(script.Parent.Minigames.DungeonCleaning),
}

---@class Server : Master
local Server = setmetatable({}, Master)
Server.__index = Server

---@return Server
function Server.new()
	local self = setmetatable(Master.new(Layers, MinigameModules), Server)
	return self
end

function Server:init()
	Master.init(self)

	ReplicatedStorage:SetAttribute(self.shared.constants.INIT_SERVER, true)
end

local server = Server.new()
server:init()
