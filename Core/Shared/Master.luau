local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage.Shared)
local MinigameLoader = require(ReplicatedStorage.Shared.Application.Services.MinigameLoader)

---@class Master
local Master = {}
Master.__index = Master

---@param layers table<string, table>
---@param minigameModules table
---@return Master
function Master.new(layers, minigameModules)
	local self = setmetatable({}, Master)
	self.shared = Shared.new()

	self.diContainer = self.shared.diContainer

	self.infrastructure = layers.Infrastructure and layers.Infrastructure.new(self.diContainer) or nil
	self.application = layers.Application and layers.Application.new(self.diContainer) or nil
	self.presentation = layers.Presentation and layers.Presentation.new(self.diContainer) or nil

	self.minigameLoader = MinigameLoader.new(self.diContainer, minigameModules)

	return self
end

function Master:init()
	self.diContainer:singleton("Infrastructure", function()
		return self.infrastructure
	end)

	self.diContainer:singleton("Application", function()
		return self.application
	end)

	self.diContainer:singleton("Shared", function()
		return self.shared
	end)

	if self.presentation then
		self.diContainer:singleton("Presentation", function()
			return self.presentation
		end)
	end

	self.diContainer:singleton("MinigameLoader", function()
		return self.minigameLoader
	end)

	self.infrastructure:init()
	self.application:init()

	if self.presentation then
		self.presentation:init()
	end

	self.minigameLoader:loadMinigame("Shooting")
	-- self.minigameLoader:loadMinigame("ItemSearch")
	-- self.minigameLoader:loadMinigame("Racing")
	-- self.minigameLoader:loadMinigame("FoodEating")
	-- self.minigameLoader:loadMinigame("DungeonCleaning")
end

function Master:startSession()
	self.minigameLoader:startSession()
end

function Master:endSession()
	self.minigameLoader:endSession()
end

return Master
