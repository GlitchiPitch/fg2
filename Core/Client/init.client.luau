local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Master = require(ReplicatedStorage.Shared.Master)
local Presentation = require(script.Presentation)
local Application = require(script.Application)
local Infrastructure = require(script.Infrastructure)

local Minigames = script.Parent.Minigames

---@class Client : Master
local Client = setmetatable({}, Master)
Client.__index = Client

---@return Client
function Client.new()
	local self = setmetatable(Master.new(Infrastructure, Application, Presentation), Client)

	self.minigames = {
		CrossbowShooting = require(Minigames.CrossbowShooting).new(self.shared.diContainer),
		ItemSearch = require(Minigames.ItemSearch).new(self.shared.diContainer),
		Racing = require(Minigames.Racing).new(self.shared.diContainer),
		FoodEating = require(Minigames.FoodEating).new(self.shared.diContainer),
		DungeonCleaning = require(Minigames.DungeonCleaning).new(self.shared.diContainer),
	}
	return self
end

function Client:init()
	Master.init(self)

	self.minigames.CrossbowShooting:init()
	self.minigames.ItemSearch:init()
	self.minigames.Racing:init()
	self.minigames.FoodEating:init()
	self.minigames.DungeonCleaning:init()
end

local client = Client.new()

if ReplicatedStorage:GetAttribute(client.shared.constants.INIT_SERVER) then
	client:init()
else
	ReplicatedStorage:GetAttributeChangedSignal(client.shared.constants.INIT_SERVER):Connect(function()
		client:init()
	end)
end
