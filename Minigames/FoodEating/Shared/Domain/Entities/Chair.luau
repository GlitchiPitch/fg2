---@class ChairEntity
---@field chair BasePart
---@field id string
---@field cameraPart BasePart
---@field seat Seat
---@field prompt ProximityPrompt
---@field occupant Player?
---@field occupantId string?
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
	self.seat = self.chair.Seat
	self.prompt = self.chair.ProximityPrompt
    self.occupant = nil
    self.occupantId = nil
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

		self.seat:Sit(humanoid) -- forces the humanoid to sit on the seat
	end)

	self.seat:GetPropertyChangedSignal("Occupant"):Connect(function()
		local humanoid = self.seat.Occupant
		if humanoid then
            self.occupant = humanoid.Parent
            self.occupantId = self.occupant.UserId
			self.prompt.Enabled = false
			data.occupiedCallback(humanoid)
		else
			self.prompt.Enabled = true
			data.unoccupiedCallback(humanoid)
		end
	end)
end

return ChairEntity
