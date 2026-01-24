local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Master = require(ReplicatedStorage.Shared.Master)

local Layers = {
	Presentation = require(script.Presentation),
	Application = require(script.Application),
	Infrastructure = require(script.Infrastructure),
}

local MinigameModules = {
	Shooting = require(script.Parent.Minigames.Shooting),
	ItemSearch = require(script.Parent.Minigames.ItemSearch),
	Racing = require(script.Parent.Minigames.Racing),
	FoodEating = require(script.Parent.Minigames.FoodEating),
	DungeonCleaning = require(script.Parent.Minigames.DungeonCleaning),
}

---@class Client : Master
local Client = setmetatable({}, Master)
Client.__index = Client

---@return Client
function Client.new()
	local self = setmetatable(Master.new(Layers, MinigameModules), Client)

	return self
end

function Client:init()
	Master.init(self)

end

local client = Client.new()

if ReplicatedStorage:GetAttribute(client.shared.constants.INIT_SERVER) then
	client:init()
else
	ReplicatedStorage:GetAttributeChangedSignal(client.shared.constants.INIT_SERVER):Connect(function()
		client:init()
	end)
end
