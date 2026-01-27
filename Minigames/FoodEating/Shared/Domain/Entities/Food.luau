---@class FoodEntity
---@field foodModel Model
---@field foodType "taper" | "clicker" | "combo"
local Food = {}
Food.__index = Food

---@param foodModel Model
---@return FoodEntity
function Food.new(foodModel)
	local self = setmetatable({}, Food)
	self.foodModel = foodModel
    self.foodType = "tap"
	return self
end



return Food