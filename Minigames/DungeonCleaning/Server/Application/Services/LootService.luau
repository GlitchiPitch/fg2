local Players = game:GetService("Players")
---@class ServerDungeonCleaningLootService
---@field diContainer DIContainer
---@field eventBus EventBus
---@field constants Constants
---@field itemRepository SharedItemRepository
---@field _lootListByCharacter table<string, table<string, table<string, number>>>
---@field _lootCahce table<string, Model>
local LootService = {}
LootService.__index = LootService

---@param diContainer DIContainer
---@return ServerDungeonCleaningLootService
function LootService.new(diContainer)
	local self = setmetatable({}, LootService)
	self.diContainer = diContainer
	self._lootCahce = {}
	return self
end

function LootService:init()
	---@type SharedDungeonCleaning
	local shared = self.diContainer:resolve("Shared")
	---@type ServerDungeonCleaningInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.eventBus = shared.eventBus
	self.constants = shared.constants
	self.itemsRepository = shared.infrastructure.repositories.itemsRepository
	self.lootVFX = shared.assets.LootVFX
	self.playerRepository = infrastructure.repositories.playerRepository
	self._lootListByCharacter = {
		-- Orc = {
		-- 	Poop = { chance = 10, amount = 1 },
		-- },
	}

	-- self:_setupLootPoints()
	-- self:_setupEventListeners()
end

function LootService:_setupEventListeners()
	-- Listen for loot destroyed events from LootController
	self.eventBus:connect(self.constants.EVENTS.SPAWN_LOOT, function(data)
		self:_dropFromCharacter(data.character)
	end)
end

function LootService:_setupLootPoints()
	local lootFolder = workspace.Worlds.MainWorld.Loot
	---@param loot Model
	for _, loot in lootFolder:GetChildren() do
		self._lootCahce[loot] = loot:Clone()
		loot.Destroying:Connect(function()
			self.eventBus:fire("lootDestroyed", loot)
		end)
	end
end

function LootService:_dropFromCharacter(character)
	local characterName = character.Name
	local loots = self._lootListByCharacter[characterName] or {
		Poop = { chance = 100, amount = 1 },
	}

	for lootName, lootData in loots do
		if math.random(1, 100) <= lootData.chance then
			local loot = self.itemsRepository:getItemAsset(lootName)
			warn(loot)
			if not loot then
				continue
			end

			local lootClone = loot.Body:Clone() :: Model
			
			local lootVFX = self.lootVFX:Clone()
			local lootConn

			lootClone.Parent = workspace
			lootClone:PivotTo(
				CFrame.new(character.HumanoidRootPart.CFrame.Position)
					+ Vector3.new(math.random() * math.pi * 2, 0, math.random() * math.pi * 2) * 2
			)
			lootClone.PrimaryPart.Anchored = true
			lootClone.PrimaryPart.CanTouch = false
			
			lootVFX:PivotTo(CFrame.new(lootClone.PrimaryPart.CFrame.Position))
			lootVFX.Parent = lootClone.PrimaryPart

			task.delay(2, function()
				lootClone.PrimaryPart.CanTouch = true
			end)

			lootConn = lootClone.PrimaryPart.Touched:Connect(function(hit)
				local player = Players:GetPlayerFromCharacter(hit.Parent)
				if player and not lootClone:GetAttribute("PickedUp") then
					lootClone:SetAttribute("PickedUp", true)
					-- local playerEntity = self.playerRepository:getPlayerEntity(player)
					-- playerEntity:addItemToInventory(loot)
					lootConn:Disconnect()
					lootClone:Destroy()
				end
			end)
		end
	end
end

function LootService:_dropFromChest(chest, lootName)
	-- local loot = self._lootCahce[lootName]
	-- if not loot then
	-- 	return
	-- end

	-- local lootClone = loot:Clone()
	-- lootClone.Parent = chest
	-- lootClone:PivotTo(CFrame.new(chest.CFrame.Position + Vector3.new(0, 10, 0)))
end

return LootService
