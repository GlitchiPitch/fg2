local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Master = require(ReplicatedStorage.Shared.Master)
local Presentation = require(script.Presentation)
local Application = require(script.Application)
local Infrastructure = require(script.Infrastructure)

---@class Client : Master
local Client = setmetatable({}, Master)
Client.__index = Client

---@return Client
function Client.new()
	local self = setmetatable(Master.new(Infrastructure, Application, Presentation), Client)
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
