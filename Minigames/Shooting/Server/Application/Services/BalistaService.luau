local Players = game:GetService("Players")

---@class ShootingServerBalistaService
---@field diContainer DIContainer
---@field constants SharedConstants
---@field balistaRepository ServerShootingBalistaRepository
---@field eventBus EventBus
local BalistaService = {}
BalistaService.__index = BalistaService

---@param diContainer DIContainer
---@return ShootingServerBalistaService
function BalistaService.new(diContainer)
	local self = setmetatable({}, BalistaService)
	self.diContainer = diContainer
	self._balistaEntities = {}
	return self
end

function BalistaService:init()
	---@type ShootingShared
	local shared = self.diContainer:resolve("Shared")
	---@type ShootingServerInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.balistaRepository = infrastructure.repositories.balistaRepository
	self.itemsRepository = shared.infrastructure.repositories.itemsRepository
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	self.ammo = {
		self.itemsRepository:getItemAsset("Box"),
		self.itemsRepository:getItemAsset("SpaceGirl"),
		self.itemsRepository:getItemAsset("SpaceMan"),
	}

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
		local balistaEntity = self.balistaRepository:getBalistaEntity(balista)
		balistaEntity:init({
			---@param occupant Humanoid
			activateCallback = function(occupant)
				local player = Players:GetPlayerFromCharacter(occupant.Parent)

				self.eventBus:fire(self.constants.SERVER_EVENTS.PLAYER_JOINED_BALISTA, {
					player = player,
				})
				balistaEntity:setAmmo(self.ammo)
				self._balistaEntities[player.UserId] = balistaEntity
				return player
			end,
			---@param ownerId number
			deactivateCallback = function(ownerId)
				local player = Players:GetPlayerByUserId(ownerId)
				if player then
					self.eventBus:fire(self.constants.SERVER_EVENTS.PLAYER_LEFT_BALISTA, {
						player = player,
					})
				end
				self._balistaEntities[ownerId] = nil
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

	balistaEntity:shoot()
end

function BalistaService:getBalistaByOwner(player)
	return self._balistaEntities[player.UserId]
end

return BalistaService
