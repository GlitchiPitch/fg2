local RunService = game:GetService("RunService")
local FoodController = require(script.FoodController)
local GameController = require(script.GameController)
---@class ServerFoodEatingControllers
---@field foodController ServerFoodEatingFoodController
---@field gameController ServerFoodEatingGameController
local Controllers = {}
Controllers.__index = Controllers

---@param diContainer DIContainer
---@return ServerFoodEatingControllers
function Controllers.new(diContainer)
	local self = setmetatable({}, Controllers)
	self.foodController = FoodController.new(diContainer)
	self.gameController = GameController.new(diContainer)
	return self
end

function Controllers:init()
	self.foodController:init()
	self.gameController:init()
end

function Controllers:start()
	self.heartbeatConnection = RunService.Heartbeat:Connect(function(deltaTime)
		self:_update(deltaTime)
	end)
end

function Controllers:stop()
	self.heartbeatConnection:Disconnect()
end

function Controllers:_update(deltaTime)
	self.foodController:update(deltaTime)
	self.gameController:update(deltaTime)
end

return Controllers