local RunService = game:GetService("RunService")
local FoodController = require(script.FoodController)
---@class ClientFoodEatingControllers
---@field foodController ClientFoodEatingFoodController
local Controllers = {}
Controllers.__index = Controllers

---@param diContainer DIContainer
---@return ClientFoodEatingControllers
function Controllers.new(diContainer)
	local self = setmetatable({}, Controllers)
    self.diContainer = diContainer
    self.foodController = FoodController.new(diContainer)
	return self
end

function Controllers:init()
    self.foodController:init()
end

function Controllers:start()
    self.heartbeatConnection = RunService.Heartbeat:Connect(function(deltaTime)
        self:_update(deltaTime)
    end)
end

function Controllers:stop()
    if self.heartbeatConnection then
        self.heartbeatConnection:Disconnect()
    end
end

function Controllers:_update(deltaTime)
    self.foodController:update(deltaTime)
end

return Controllers
