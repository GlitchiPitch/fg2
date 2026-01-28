---@class FoodEntity
---@field foodModel Model
---@field eatingType eatingType
---@field id string
local Food = {}
Food.__index = Food

---@class foodEntityData
---@field foodModel Model
---@field eatingType eatingType
---@field id string
---@field combo table<number, Enum.KeyCode>?

---@param data foodEntityData
---@return FoodEntity
function Food.new(data)
	local self = setmetatable({}, Food)
	self.foodModel = data.foodModel
	self.eatingType = data.eatingType
	self.id = data.id
	self.combo = data.combo
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
