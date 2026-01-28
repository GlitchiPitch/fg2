---@class ChairEntity
---@field chair BasePart
---@field id string
---@field cameraPart BasePart
---@field seat Seat
---@field prompt ProximityPrompt
---@field occupant Player?
---@field occupantId string?
---@field foodSpawnPart BasePart
---@field currentFood FoodEntity?
local ChairEntity = {}
ChairEntity.__index = ChairEntity

---@param chair BasePart
---@param id string
---@return ChairEntity
function ChairEntity.new(chair, id)
	local self = setmetatable({}, ChairEntity)
	self.chair = chair
	self.id = id
	self.cameraPart = self.chair.CameraPart
	self.seat = self.chair.PrimaryPart
	self.prompt = self.seat.ProximityPrompt
	self.foodSpawnPart = self.chair.FoodSpawnPart
    self.occupant = nil
    self.occupantId = nil
	self.currentFood = nil
	return self
end

---@class chairEntitySetupData
---@field occupiedCallback function
---@field unoccupiedCallback function

---@param data table
function ChairEntity:setup(data)
	self.prompt.Triggered:Connect(function(plr) -- upon clicking
		if self.seat.Occupant then
			return
		end -- make sure seat isn't already taken

		local char = plr.Character
		if not char then
			return
		end -- make sure the player has a character

		local humanoid = char:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end -- make sure the char has a humanoid

		if humanoid.Sit then
			return
		end

		self.seat:Sit(humanoid) -- forces the humanoid to sit on the seat
	end)

	self.seat:GetPropertyChangedSignal("Occupant"):Connect(function()
		local humanoid = self.seat.Occupant
		if humanoid then
            
			self.prompt.Enabled = false
			data.occupiedCallback(humanoid)
		else
			self.prompt.Enabled = true
			data.unoccupiedCallback()
			self:clear()
		end
	end)
end

function ChairEntity:clear()
	if self.currentFood then
		self.currentFood:destroy()
		self.currentFood = nil
	end
end

---@param food FoodEntity
function ChairEntity:spawnFood(food)
	food:spawn(self.foodSpawnPart)
	self.currentFood = food
end

function ChairEntity:eatFood()
	if self.currentFood then
		self.currentFood:destroy()
		self.currentFood = nil
	end
end

return ChairEntity
