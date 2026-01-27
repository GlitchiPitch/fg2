local HttpService = game:GetService("HttpService")
---@class ServerFoodEatingChairRepository
---@field diContainer DIContainer
---@field chairs table<string, ChairEntity>
---@field chairEntity ChairEntity
local ChairRepository = {}
ChairRepository.__index = ChairRepository

---@param diContainer DIContainer
---@return ServerFoodEatingChairRepository
function ChairRepository.new(diContainer)
	local self = setmetatable({}, ChairRepository)
    self.diContainer = diContainer
    self.chairs = {}
	return self
end

function ChairRepository:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.chairEntity = shared.domain.Entities.Chair
end

---@param chair Model
---@return ChairEntity
function ChairRepository:createChairEntity(chair)
	local id = HttpService:GenerateGUID(false)
	local chairEntity = self.chairEntity.new(chair, id)
	self.chairs[id] = chairEntity
	return chairEntity
end

---@param id string
---@return ChairEntity?
function ChairRepository:getChairEntity(id)
	return self.chairs[id]
end

---@param id string
function ChairRepository:removeChairEntity(id)
	self.chairs[id] = nil
end

function ChairRepository:getChairs()
	return self.chairs
end

---@param player Player
---@return ChairEntity?
function ChairRepository:getChairByPlayer(player)
	warn("getChairByPlayer", player)
	for _, chair in self.chairs do
		if chair.occupant == player then
			return chair
		end
	end
	return nil
end

return ChairRepository