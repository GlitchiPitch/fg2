local Players = game:GetService("Players")
---@class ClientToolService
---@field _currentTool Tool
---@field diContainer DIContainer
---@field debounce boolean
---@field attackIndex number
---@field lastTime number
---@field player Player
---@field animationService ClientAnimationService
---@field constants SharedDungeonCleaningConstants
---@field isEquipped boolean
local ToolService = {}
ToolService.__index = ToolService

---@param diContainer DIContainer
---@return ClientToolService
function ToolService.new(diContainer)
	local self = setmetatable({}, ToolService)
	self.diContainer = diContainer
	self._currentTool = nil
	self.player = Players.LocalPlayer
	self.isEquipped = false
	self.debounce = false
	self.attackIndex = 1
	self.lastTime = nil
	self.maxCombo = 4 -- @TODO: get value from animationService

	return self
end

function ToolService:init()
	---@type DungeonCleaningClientApp
	local application = self.diContainer:resolve("Application")
	---@type SharedDungeonCleaning
	local shared = self.diContainer:resolve("Shared")
	self.eventBus = shared.eventBus
	self.constants = shared.constants
	self.animationService = application.services.animationService
	self.remoteEventService = shared.remoteEventService
	self:_setupEventListeners()
end

function ToolService:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.CLIENT_EVENTS.USE_WEAPON] = function()
			self:useWeapon()
		end,
	})
end

function ToolService:checkCharacterTool()
	local character = self.player.Character
	---@param child Instance
	local function _onChildAdded(child)
		if child:IsA("Tool") then
			if child:HasTag("Weapon") then
				self:_setupTool(child)
			end
		end
	end
	---@param child Instance
	local function _onChildRemoved(child)
		if child:IsA("Tool") then
			if child:HasTag("Weapon") then
				self:_removeTool()
			end
		end
	end
	character.ChildAdded:Connect(_onChildAdded)
	character.ChildRemoved:Connect(_onChildRemoved)
end

function ToolService:_setupTool(currentTool)
	self.isEquipped = true
	self._currentTool = currentTool
	if currentTool:GetAttribute("WeaponType") == "OneHanded" then
		self.animationService:playAnimation("oneHandedIdle")
	elseif currentTool:GetAttribute("WeaponType") == "TwoHanded" then
		self.animationService:playAnimation("twoHandedIdle")
	end
end

function ToolService:_removeTool()
	self._currentTool = nil
	self.lastTime = nil
	self.isEquipped = false
	self.animationService:stopAllAnimations()
end

function ToolService:useWeapon()
	if not self.isEquipped then
		return
	end

	if self.debounce then
		return
	end

	self.debounce = true

	self:_useWeapon()
	self:_playWeaponAnimation()
	self.debounce = false
end

-- ---@param setBlock boolean
-- function ToolService:block(setBlock)
-- 	if setBlock then
-- 		self.animationService:playAnimation("block")
-- 	else
-- 		self.animationService:stopAnimation("block")
-- 	end
-- end

function ToolService:_playWeaponAnimation()
	local weaponType = self._currentTool:GetAttribute("WeaponType")
	local animationPrefix = weaponType == "OneHanded" and "oneHanded" or "twoHanded"

	if self.lastTime == nil then
		print("First Time")
	elseif os.time() - 2 > self.lastTime then
		self.attackIndex = 1
	else
		if self.attackIndex == self.maxCombo then
			self.attackIndex = 1
		else
			self.attackIndex = math.min(self.attackIndex + 1, self.maxCombo)
		end
	end

	self.lastTime = os.time()

	local animationName = animationPrefix .. self.attackIndex
	if self.animationService.animTracks[animationName] then
		self.animationService.animTracks[animationName]:Play()
		task.wait(self.animationService.animTracks[animationName].Length)
	else
		task.wait(0.5)
	end
end

function ToolService:_useWeapon()
	self.remoteEventService:fireServer({
		eventName = self.constants.REMOTE_EVENTS.USE_WEAPON,
		data = {
			weapon = self._currentTool,
		},
	})
end

function ToolService:destroy()
	self._currentTool = nil
	self.isEquipped = false
	self.debounce = false
end

return ToolService
