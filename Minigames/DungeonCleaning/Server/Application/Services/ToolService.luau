local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
---@class ServerDungeonCleaningToolService
local ToolService = {}
ToolService.__index = ToolService

---@param diContainer DIContainer
---@return ServerDungeonCleaningToolService
function ToolService.new(diContainer)
	local self = setmetatable({}, ToolService)
	self.diContainer = diContainer
	return self
end

function ToolService:init()
    ---@type SharedDungeonCleaning
	local shared = self.diContainer:resolve("Shared")
	---@type DungeonCleaningServerApp
	local application = self.diContainer:resolve("Application")
	self.eventBus = shared.eventBus
	self.constants = shared.constants
	self.remoteEventService = shared.remoteEventService
	self.lootService = application.services.lootService
    self.hitbox = shared.assets.Hitbox
    self.hitEnemyVFX = shared.assets.HitEnemyVFX

	self:_setupRemoteEventListeners()
end

function ToolService:_setupRemoteEventListeners()
	self.remoteEventService:connectToEvents({
		[self.constants.REMOTE_EVENTS.USE_WEAPON] = function(player, data)
			self:useWeapon(player, data)
		end,
	})
end

function ToolService:useWeapon(player, data)
	warn("useWeapon", data)
	self:_createHitbox({
		player = player,
		weapon = data.weapon,
	})
end

function ToolService:_createHitbox(data)
	local character = data.player.Character
    local weapon = data.weapon
	-- Validate that the weapon is equipped by the player
	-- if weapon.Parent ~= character then
	-- 	warn("Player attempted to use unequipped weapon:", weapon.Name)
	-- 	return
	-- end
    warn("weapon", weapon, character)
	-- -- Get weapon damage from repository
	-- local weaponData = self.weaponRepository:getWeaponData(weapon.Name)
	-- if not weaponData then
	-- 	warn("Weapon data not found for:", weapon.Name)
	-- 	return
	-- end

	local damage = 100 --weaponData.damage
	-- Spawn the hitbox in front of the player based on their look direction
	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then return end

	local forwardOffset = 7 -- studs in front of the player (adjust as needed)
	local hitboxCF = root.CFrame * CFrame.new(0, 0, -forwardOffset)
	local hitbox = self.hitbox:Clone()
	hitbox.Parent = workspace
	hitbox.CFrame = hitboxCF
	local partsInRadius = workspace:GetPartBoundsInBox(hitbox.CFrame, hitbox.Size)
	for _, part in partsInRadius do
		local humanoid = part.Parent:FindFirstChild("Humanoid")
        local isGate = part.Parent.Name == "Gate"

		if humanoid then
            local enemyId = humanoid.Parent:GetAttribute("Id")
			local isPlayer = humanoid == character.Humanoid
			if not isPlayer then
				-- humanoid:TakeDamage(damage)
                local p = humanoid.Parent.PrimaryPart :: Part
                local vfx = self.hitEnemyVFX:Clone()
                vfx.Parent = p
                vfx.CFrame = p.CFrame
                -- local tween = TweenService:Create(p, TweenInfo.new(10), {
                --     Position = p.Position + hitboxCF.LookVector * 10,
                -- })
                -- tween.Completed:Connect(function()
                --     humanoid.Parent:Destroy()
                -- end)

                -- tween:Play()

                p:ApplyImpulse((hitboxCF.LookVector * 1000 + Vector3.new(0, 5000, 0)))
                Debris:AddItem(vfx, 1)
                Debris:AddItem(p.Parent, 2)
                self.lootService:_dropFromCharacter(humanoid.Parent)
				-- if player has one handed use break for one damaged person
				-- if two handed not use break

				-- self.eventBus:fire(self.constants.SERVER_EVENTS.ENEMY_ATTACKED, {
				-- 	enemyId = enemyId,
				-- 	damage = damage,
				-- })

				break
			end
        elseif isGate then
            self.eventBus:fire(self.constants.SERVER_EVENTS.GATE_ATTACKED, {
                gateId = part.Parent.Name,
                damage = damage,
            })
		end
	end

	Debris:AddItem(hitbox, 0.2)
end
return ToolService