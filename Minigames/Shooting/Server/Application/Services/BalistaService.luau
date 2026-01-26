local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

---@class ServerShootingBalistaService
---@field diContainer DIContainer
---@field constants SharedConstants
---@field balistaRepository ServerShootingBalistaRepository
---@field eventBus EventBus
---@field application ServerShootingApp
local BalistaService = {}
BalistaService.__index = BalistaService

---@param diContainer DIContainer
---@return ServerShootingBalistaService
function BalistaService.new(diContainer)
	local self = setmetatable({}, BalistaService)
	self.diContainer = diContainer
	self._balistaEntities = {}
	return self
end

function BalistaService:init()
	---@type SharedShooting
	local shared = self.diContainer:resolve("Shared")
	---@type ServerShootingInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")

	self.application = self.diContainer:resolve("Application")

	self.balistaRepository = infrastructure.repositories.balistaRepository
	self.itemsRepository = shared.infrastructure.repositories.itemsRepository
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	self._ammoAssets = {
		Box = self.itemsRepository:getItemAsset("Box"),
		SpaceGirl = self.itemsRepository:getItemAsset("SpaceGirl"),
		SpaceMan = self.itemsRepository:getItemAsset("SpaceMan"),
	}

	self._ammoIndexes = { "Box", "SpaceGirl", "SpaceMan", "Box" }

	self.remoteEventService = shared.remoteEventService

	self.balistas = workspace.Workspace.Maps.Shooting.Balistas:GetChildren()

	self.remoteEventService:connectToEvents({
		[self.constants.REMOTE_EVENTS.SHOOT] = function(player, eventData)
			eventData.data.player = player
			self:onShoot(eventData.data)
		end,
	})
	self:_setup()
end

function BalistaService:_setup()
	---@param balista Model
	for _, balista in self.balistas do
		-- local seat = balista.Seat :: Seat
		local balistaEntity = self.balistaRepository:createBalistaEntity({
			id = HttpService:GenerateGUID(false),
			model = balista,
			ammo = {},
			isReloading = false,
		})

		balistaEntity:setup({
			---@param occupant Humanoid
			activateCallback = function(occupant)
				local player = Players:GetPlayerFromCharacter(occupant.Parent)

				balistaEntity:setAmmo(table.clone(self._ammoIndexes))
				self._balistaEntities[player.UserId] = balistaEntity

				self.eventBus:fire(self.constants.SERVER_EVENTS.PLAYER_JOINED_BALISTA, {
					player = player,
					balista = balistaEntity:toData(),
				})

				-- start app for test
				self.application:start()

				return player
			end,
			---@param ownerId number
			deactivateCallback = function(ownerId)
				local player = Players:GetPlayerByUserId(ownerId)
				if player then
					self.eventBus:fire(self.constants.SERVER_EVENTS.PLAYER_LEFT_BALISTA, {
						player = player,
						balista = balistaEntity:toData(),
					})
				end
				self._balistaEntities[ownerId] = nil
				self.application:stop()
			end,
			getRandomAmmoCallback = function(bulletName)
				local bullet = self._ammoAssets[bulletName]
				if not bullet then
					return nil
				end

				return bullet:Clone()
			end,
			hitCallback = function(hit)
				if hit.Parent:HasTag("Target") then
					self.eventBus:fire(self.constants.SERVER_EVENTS.TARGET_HIT, {
						targetId = hit.Parent:GetAttribute("TargetId"),
					})
				end
			end,
		})
	end
end

function BalistaService:onShoot(eventData)
	local player = eventData.player
	local balistaEntity = self:getBalistaByOwner(player)
	if not balistaEntity then
		return
	end

	if balistaEntity._isReloading then
		return
	end

	local result = balistaEntity:shoot()

	local function _onShootResult()
		self.remoteEventService:fireClient(player, {
			eventName = self.constants.REMOTE_EVENTS.SHOOT,
			data = {
				result = result,
				balista = balistaEntity:toData(),
			},
		})
	end

	if result == "reload" then
		_onShootResult()
		task.wait(2)
		balistaEntity:setAmmo(table.clone(self._ammoIndexes))
		_onShootResult()
	elseif result == "success" then
		_onShootResult()
	end
end

function BalistaService:getBalistaByOwner(player)
	return self._balistaEntities[player.UserId]
end

return BalistaService
