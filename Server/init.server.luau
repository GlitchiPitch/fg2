local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Master = require(ReplicatedStorage.Shared.Master)
local Infrastructure = require(script.Infrastructure)
local Application = require(script.Application)

---@class Server : Master
local Server = setmetatable({}, Master)
Server.__index = Server

---@return Server
function Server.new()
	local self = setmetatable(Master.new(Infrastructure, Application), Server)
	return self
end

function Server:init()
	Master.init(self)

	ReplicatedStorage:SetAttribute(self.shared.constants.INIT_SERVER, true)
end

local server = Server.new()
server:init()
