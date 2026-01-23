local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Master = require(ReplicatedStorage.Shared.Master)
local Infrastructure = require(script.Infrastructure)
local Application = require(script.Application)

local Minigames = script.Parent.Minigames

---@class Server : Master
local Server = setmetatable({}, Master)
Server.__index = Server

---@return Server
function Server.new()
	local self = setmetatable(Master.new(Infrastructure, Application), Server)

	self.minigames = {
		CrossbowShooting = require(Minigames.CrossbowShooting).new(self.shared.diContainer),
		ItemSearch = require(Minigames.ItemSearch).new(self.shared.diContainer),
		Racing = require(Minigames.Racing).new(self.shared.diContainer),
		FoodEating = require(Minigames.FoodEating).new(self.shared.diContainer),
		DungeonCleaning = require(Minigames.DungeonCleaning).new(self.shared.diContainer),
	}
	return self
end

function Server:init()
	Master.init(self)

	self.minigames.CrossbowShooting:init()
	self.minigames.ItemSearch:init()
	self.minigames.Racing:init()
	self.minigames.FoodEating:init()
	self.minigames.DungeonCleaning:init()

	ReplicatedStorage:SetAttribute(self.shared.constants.INIT_SERVER, true)
end

local server = Server.new()
server:init()
