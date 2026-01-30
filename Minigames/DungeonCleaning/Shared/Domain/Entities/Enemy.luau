local PathfindingService = game:GetService("PathfindingService")
local RunService = game:GetService("RunService")

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
    
    -- AI state
    self.currentTarget = nil
    self.pathfindingAgent = nil
    self.currentPath = nil
    self.state = "idle" -- idle, chasing, attacking
    self.lastAttackTime = 0
    self.attackCooldown = 2 -- seconds between attacks
    self.detectionRange = 50 -- studs
    self.attackRange = 5 -- studs
    self.pathUpdateInterval = 0.5 -- seconds
    self.lastPathUpdate = 0
    
    -- Animation
    self.animator = nil
    self.attackAnimation = nil
    self.walkAnimation = nil
    self.idleAnimation = nil
    
    -- Raycast params
    self.raycastParams = RaycastParams.new()
    self.raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    self.raycastParams.FilterDescendantsInstances = {self.model}
    
	return self
end

function Enemy:spawn(parent, position)
	-- Clone the model to ensure we have a fresh instance
	local clonedModel = self.model:Clone()
	clonedModel.Parent = parent
	
	-- Set position using PrimaryPart or first part
	if clonedModel.PrimaryPart then
		clonedModel:SetPrimaryPartCFrame(CFrame.new(position))
	else
		local rootPart = clonedModel:FindFirstChild("HumanoidRootPart") or clonedModel:FindFirstChildOfClass("BasePart")
		if rootPart then
			rootPart.CFrame = CFrame.new(position)
		end
	end
	
	self.model = clonedModel
	
	-- Initialize Humanoid
	local humanoid = self.model:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		warn("Enemy model missing Humanoid")
		return
	end
	
	-- Initialize PathfindingAgent
	self.pathfindingAgent = PathfindingService:CreatePath({
		AgentRadius = 2,
		AgentHeight = 5,
		AgentCanJump = true,
		WaypointSpacing = 4,
		Costs = {
			Water = 20,
		}
	})
	
	-- Initialize Animator and animations
	self.animator = humanoid:FindFirstChildOfClass("Animator")
	if not self.animator then
		self.animator = Instance.new("Animator")
		self.animator.Parent = humanoid
	end
	
	-- Try to load animations (assuming they exist in the model)
	local animationsFolder = self.model:FindFirstChild("Animations")
	if animationsFolder then
		local attackAnim = animationsFolder:FindFirstChild("Attack")
		local walkAnim = animationsFolder:FindFirstChild("Walk")
		local idleAnim = animationsFolder:FindFirstChild("Idle")
		
		if attackAnim then
			self.attackAnimation = self.animator:LoadAnimation(attackAnim)
			self.attackAnimation.Looped = false
		end
		if walkAnim then
			self.walkAnimation = self.animator:LoadAnimation(walkAnim)
			self.walkAnimation.Looped = true
		end
		if idleAnim then
			self.idleAnimation = self.animator:LoadAnimation(idleAnim)
			self.idleAnimation.Looped = true
		end
	end
	
	-- Start idle animation
	if self.idleAnimation then
		self.idleAnimation:Play()
	end
end

function Enemy:destroy()
	warn("destroy")

	if self.pathfindingAgent then
		self.pathfindingAgent:Destroy()
	end
	if self.model then
		self.model:Destroy()
	end
end

---@param target Character
---@return boolean
function Enemy:canSeeTarget(target)
	if not target or not target.PrimaryPart then
		return false
	end
	
	local enemyRoot = self.model:FindFirstChild("HumanoidRootPart")
	if not enemyRoot then
		return false
	end
	
	local targetPosition = target.PrimaryPart.Position
	local enemyPosition = enemyRoot.Position
	local direction = (targetPosition - enemyPosition)
	local distance = direction.Magnitude
	
	-- Check if target is within detection range
	if distance > self.detectionRange then
		return false
	end
	
	-- Raycast to check if there's a wall between enemy and target
	self.raycastParams.FilterDescendantsInstances = {self.model, target}
	local raycastResult = workspace:Raycast(enemyPosition, direction, self.raycastParams)
	
	-- If raycast hit something, check if it's the target
	if raycastResult then
		local hitPart = raycastResult.Instance
		-- Check if we hit the target or something close to it
		if hitPart:IsDescendantOf(target) then
			return true
		else
			-- Hit a wall or obstacle
			return false
		end
	end
	
	-- No hit means clear line of sight (shouldn't happen, but handle it)
	return true
end

---@param target Character
---@return number
function Enemy:getDistanceToTarget(target)
	if not target or not target.PrimaryPart then
		return math.huge
	end
	
	local enemyRoot = self.model:FindFirstChild("HumanoidRootPart")
	if not enemyRoot then
		return math.huge
	end
	
	return (target.PrimaryPart.Position - enemyRoot.Position).Magnitude
end

---@param target Character
function Enemy:updatePath(target)
	if not target or not target.PrimaryPart then
		return
	end
	
	local enemyRoot = self.model:FindFirstChild("HumanoidRootPart")
	if not enemyRoot then
		return
	end
	
	local currentTime = tick()
	if currentTime - self.lastPathUpdate < self.pathUpdateInterval then
		return
	end
	self.lastPathUpdate = currentTime
	
	local success, errorMessage = pcall(function()
		self.pathfindingAgent:ComputeAsync(enemyRoot.Position, target.PrimaryPart.Position)
	end)
	
	if success and self.pathfindingAgent.Status == Enum.PathStatus.Success then
		self.currentPath = self.pathfindingAgent:GetWaypoints()
	else
		self.currentPath = nil
	end
end

---@param target Character
function Enemy:moveToTarget(target)
	local humanoid = self.model:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end
	
	if not self.currentPath or #self.currentPath == 0 then
		self:updatePath(target)
		return
	end
	
	local enemyRoot = self.model:FindFirstChild("HumanoidRootPart")
	if not enemyRoot then
		return
	end
	
	-- Get the next waypoint
	local nextWaypoint = self.currentPath[1]
	if not nextWaypoint then
		return
	end
	
	-- Check if we've reached the waypoint
	local distanceToWaypoint = (nextWaypoint.Position - enemyRoot.Position).Magnitude
	if distanceToWaypoint < 3 then
		table.remove(self.currentPath, 1)
		if #self.currentPath == 0 then
			self:updatePath(target)
		end
		return
	end
	
	-- Move towards waypoint
	humanoid:MoveTo(nextWaypoint.Position)
	
	-- Play walk animation
	if self.walkAnimation and not self.walkAnimation.IsPlaying then
		if self.idleAnimation and self.idleAnimation.IsPlaying then
			self.idleAnimation:Stop()
		end
		self.walkAnimation:Play()
	end
end

---@param target Character
function Enemy:attackTarget(target)
	local currentTime = tick()
	if currentTime - self.lastAttackTime < self.attackCooldown then
		return
	end
	
	self.lastAttackTime = currentTime
	
	-- Play attack animation
	if self.attackAnimation then
		if self.walkAnimation and self.walkAnimation.IsPlaying then
			self.walkAnimation:Stop()
		end
		if self.idleAnimation and self.idleAnimation.IsPlaying then
			self.idleAnimation:Stop()
		end
		self.attackAnimation:Play()
	end
	
	-- Stop moving during attack
	local humanoid = self.model:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid:MoveTo(humanoid.RootPart.Position)
	end
	
	-- TODO: Add damage logic here
	-- You can fire an event or call a callback to handle damage
end

---@param target Character?
function Enemy:updateAI(target)
	if not self.model or not self.model.Parent then
		return
	end
	
	local humanoid = self.model:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then
		return
	end
	
	-- If no target, go idle
	if not target then
		self.state = "idle"
		self.currentTarget = nil
		self.currentPath = nil
		
		if humanoid then
			humanoid:MoveTo(humanoid.RootPart.Position)
		end
		
		if self.walkAnimation and self.walkAnimation.IsPlaying then
			self.walkAnimation:Stop()
		end
		if self.idleAnimation and not self.idleAnimation.IsPlaying then
			self.idleAnimation:Play()
		end
		return
	end
	
	-- Check if we can see the target
	if not self:canSeeTarget(target) then
		self.currentTarget = nil
		self.state = "idle"
		self.currentPath = nil
		
		if humanoid then
			humanoid:MoveTo(humanoid.RootPart.Position)
		end
		
		if self.walkAnimation and self.walkAnimation.IsPlaying then
			self.walkAnimation:Stop()
		end
		if self.idleAnimation and not self.idleAnimation.IsPlaying then
			self.idleAnimation:Play()
		end
		return
	end
	
	self.currentTarget = target
	local distance = self:getDistanceToTarget(target)
	
	-- Check if target is in attack range
	if distance <= self.attackRange then
		self.state = "attacking"
		self:attackTarget(target)
	else
		-- Chase the target
		self.state = "chasing"
		self:updatePath(target)
		self:moveToTarget(target)
	end
end

return Enemy