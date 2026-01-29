---@class EnemyEntity
local Enemy = {}
Enemy.__index = Enemy

---@class enemyData
---@field id string
---@field model Model
---@field score number

---@param enemyData enemyData
---@return EnemyEntity
function Enemy.new(enemyData)
	local self = setmetatable({}, Enemy)
    self.id = enemyData.id
    self.model = enemyData.model
    self.score = enemyData.score
	return self
end

return Enemy