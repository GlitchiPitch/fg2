local TaperMinigame = require(script.Modules.TaperMinigame)
local ClickerMinigame = require(script.Modules.ClickerMinigame)
local ComboMinigame = require(script.Modules.ComboMinigame)

---@class minigames
---@field taper TaperMinigame
---@field clicker ClickerMinigame
---@field combo ComboMinigame

---@class FoodEatingClientUI
---@field minigames minigames
---@field foodUI ScreenGui
local UI = {}
UI.__index = UI

---@param diContainer DIContainer
---@return FoodEatingClientUI
function UI.new(diContainer)
	local self = setmetatable({}, UI)
    self.diContainer = diContainer
    self.foodUI = script.FoodUI:Clone()
    self.minigames = {
        taper = TaperMinigame.new(self.foodUI.Taper),
        clicker = ClickerMinigame.new(self.foodUI.Clicker),
        combo = ComboMinigame.new(self.foodUI.Combo),
    }
	return self
end

function UI:init()
    ---@type ClientApp
    local application = self.diContainer:resolve("CoreApplication")
    self.foodUI.Parent = application.services.playerService.player.PlayerGui

    for _, minigame in self.minigames do
        minigame:setup()
    end
end

function UI:toggle(state)
    self.foodUI.Enabled = state
end

---@class foodMinigameData
---@field eatingType eatingType

---@param data foodMinigameData
function UI:showFoodMinigame(data)
    for _, minigame in self.minigames do
        minigame:stop()
    end
    
    local minigame = self.minigames[data.eatingType]
    minigame:start()

end

return UI