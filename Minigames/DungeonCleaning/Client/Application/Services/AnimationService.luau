---@class ClientAnimationService
---@field diContainer DIContainer
---@field animTracks table<string, AnimationTrack>
local AnimationService = {}
AnimationService.__index = AnimationService

---@param diContainer DIContainer
---@return ClientAnimationService
function AnimationService.new(diContainer)
	local self = setmetatable({}, AnimationService)
	self.diContainer = diContainer
	self.animTracks = {}
	return self
end

function AnimationService:init()
	---@type SharedDungeonCleaning
	local shared = self.diContainer:resolve("Shared")
	---@type ClientApp
	local application = self.diContainer:resolve("CoreApplication")
	local player = application.services.playerService.player

	local character = player.Character or player.CharacterAdded:Wait()
	local animator = character:WaitForChild("Humanoid"):WaitForChild("Animator")

	local oneHandedAnimations = {
		shared.assets.Animations.OneHandednSlash4,
		shared.assets.Animations.OneHandednSlash3,
		shared.assets.Animations.OneHandednSlash2,
		shared.assets.Animations.OneHandednSlash1,
	}

	-- local twoHandedAnimations = {
	-- 	shared.assets.Animations.TwoHandednSlash4,
	-- 	shared.assets.Animations.TwoHandednSlash3,
	-- 	shared.assets.Animations.TwoHandednSlash2,
	-- 	shared.assets.Animations.TwoHandednSlash1,
	-- }

	-- self.animTracks.drink = animator:LoadAnimation(shared.assets.Animations.Drink)
	-- self.animTracks.eat = animator:LoadAnimation(shared.assets.Animations.Eat)

	-- self.animTracks.block = animator:LoadAnimation(shared.assets.Animations.Block) :: AnimationTrack
	-- self.animTracks.block.Looped = true
	-- self.animTracks.block.Priority = Enum.AnimationPriority.Action2

	self.animTracks.oneHandedIdle = animator:LoadAnimation(shared.assets.Animations.OneHandedIdle) :: AnimationTrack
	self.animTracks.oneHandedIdle.Looped = true
	self.animTracks.oneHandedIdle.Priority = Enum.AnimationPriority.Action

	-- self.animTracks.twoHandedIdle = animator:LoadAnimation(shared.assets.Animations.TwoHandedIdle) :: AnimationTrack
	-- self.animTracks.twoHandedIdle.Looped = true
	-- self.animTracks.twoHandedIdle.Priority = Enum.AnimationPriority.Action

	for i, animation in oneHandedAnimations do
		self.animTracks["oneHanded" .. i] = animator:LoadAnimation(animation) :: AnimationTrack
		self.animTracks["oneHanded" .. i].Looped = false
		self.animTracks["oneHanded" .. i].Priority = Enum.AnimationPriority.Action2
	end

	-- for i, animation in twoHandedAnimations do
	-- 	self.animTracks["twoHanded" .. i] = animator:LoadAnimation(animation) :: AnimationTrack
	-- 	self.animTracks["twoHanded" .. i].Looped = false
	-- 	self.animTracks["twoHanded" .. i].Priority = Enum.AnimationPriority.Action2
	-- end
end

---@param animationName '"oneHandedIdle"'
function AnimationService:playAnimation(animationName)
	if not self.animTracks[animationName] then
		warn(`Animation {animationName} not found`)
		return
	end

	self.animTracks[animationName]:Play()
end

---@param animationName '"oneHandedIdle"'
function AnimationService:stopAnimation(animationName)
	if not self.animTracks[animationName] then
		warn(`Animation {animationName} not found`)
		return
	end

	self.animTracks[animationName]:Stop()
end

function AnimationService:stopAllAnimations()
	for _, animation in self.animTracks do
		animation:Stop()
	end
end

return AnimationService
