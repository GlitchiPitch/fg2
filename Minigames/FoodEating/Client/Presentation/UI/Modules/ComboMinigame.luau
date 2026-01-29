---@class ComboMinigameUIModule
---@field diContainer DIContainer
---@field minigameFrame Frame
---@field comboImageTemplate TextButton
---@field keyImages table<Enum.KeyCode, string>
local ComboMinigame = {}
ComboMinigame.__index = ComboMinigame

---@param diContainer DIContainer
---@param minigameFrame Frame
---@return ComboMinigameUIModule
function ComboMinigame.new(diContainer, minigameFrame)
	local self = setmetatable({}, ComboMinigame)
	self.diContainer = diContainer
	self.minigameFrame = minigameFrame
	self.comboImageTemplate = self.minigameFrame.Template
	self._keys = {}
	return self
end

function ComboMinigame:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus
	self.keyImages = shared.data.KeyImages
	self:_setupEventListeners()
end

function ComboMinigame:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.CLIENT_EVENTS.COMBO_MINIGAME_INPUT_SUCCESS] = function(data)
			self:onInputSuccess(data.currentIndex)
		end,
	})
end

function ComboMinigame:start(combo)
	self.combo = combo
	self.minigameFrame.Visible = true
	self:_createComboImages()
end

function ComboMinigame:stop()
	self.minigameFrame.Visible = false
	self:_clearComboImages()
end

function ComboMinigame:_clearComboImages()
	for _, comboImage in self._keys do
		comboImage:Destroy()
	end
	self._keys = {}
end

function ComboMinigame:_createComboImages()
	---@param keyCode Enum.KeyCode
	---@param index number
	for i, keyCode in self.combo do
		local comboImage = self.comboImageTemplate:Clone()
		comboImage.Name = keyCode.Name
		comboImage.Parent = self.minigameFrame
		comboImage.Visible = true
		comboImage.LayoutOrder = i
		comboImage.Image = self.keyImages[keyCode.Name]
		self._keys[i] = comboImage
	end
end

function ComboMinigame:onInputSuccess(currentIndex)
	for i, comboImage in self._keys do
		if currentIndex > #self.combo then
			comboImage.ImageTransparency = 0.5
		else
			if i < currentIndex then
				comboImage.ImageTransparency = 0.5
			else
				comboImage.ImageTransparency = 0
			end
		end
	end
end

return ComboMinigame
