local HttpService = game:GetService("HttpService")
---@class ServerFoodEatingChairRepository
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
	self.chairEntity = shared.domain.entities.Chair
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


return ChairRepository