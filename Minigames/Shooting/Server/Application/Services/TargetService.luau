---@class TargetService
local TargetService = {}
TargetService.__index = TargetService

---@param diContainer DIContainer
---@return TargetService
function TargetService.new(diContainer)
	local self = setmetatable({}, TargetService)
	self.diContainer = diContainer
	return self
end

function TargetService:init()
    ---@type ShootingShared
    local shared = self.diContainer:resolve("Shared")
    self.itemsRepository = shared.infrastructure.repositories.itemsRepository
    self.constants = shared.constants
    self.eventBus = shared.eventBus

    self.targets = {
        self.itemsRepository:getItemAsset("Starship"),
        self.itemsRepository:getItemAsset("BigStarship"),
    }
end

function TargetService:spawnTarget()
    local target = self:_getRandomTarget()
    target.Parent = workspace
    
end


function TargetService:_getRandomTarget()
    return self.targets[math.random(1, #self.targets)]:Clone()
end

return TargetService