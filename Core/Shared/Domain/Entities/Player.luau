---@class PlayerEntity
local PlayerEntity = {}
PlayerEntity.__index = PlayerEntity

---@param player Player
---@return PlayerEntity
function PlayerEntity.new(player)
	local self = setmetatable({}, PlayerEntity)
	self.player = player
	return self
end

function PlayerEntity:getData()
	return {}
end

function PlayerEntity:fromData(data)
	self.data = data
end

return PlayerEntity