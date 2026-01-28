---@class FoodEntity
---@field foodModel Model
---@field eatingType eatingType
---@field id string
local Food = {}
Food.__index = Food

---@param foodModel Model
---@param eatingType eatingType
---@param id string
---@return FoodEntity
function Food.new(foodModel, eatingType, id)
	local self = setmetatable({}, Food)
	self.foodModel = foodModel
    self.eatingType = eatingType
    self.id = id
	return self
end

function Food:destroy()
	self.foodModel:Destroy()
end

---@param spawnPart Part
function Food:spawn(spawnPart)
	self.foodModel.Parent = spawnPart
	self.foodModel:PivotTo(spawnPart.CFrame * CFrame.new(0, 2, 0))
end

return Food