local Players = game:GetService("Players")
---@class CrossbowShootingServerBalistasService
---@field diContainer DIContainer
---@field constants SharedConstants
---@field eventBus EventBus
local BalistasService = {}
BalistasService.__index = BalistasService

---@param diContainer DIContainer
---@return CrossbowShootingServerBalistasService
function BalistasService.new(diContainer)
	local self = setmetatable({}, BalistasService)
    self.diContainer = diContainer
    self._connections = {}
	return self
end

function BalistasService:init()
    ---@type CrossbowShootingShared
    local shared = self.diContainer:resolve("Shared")
    self.constants = shared.constants
    self.eventBus = shared.eventBus

    self.balistas = workspace.Workspace.Balistas:GetChildren()
    self:_setup()
end

function BalistasService:_setup()
    ---@param balista Model
    for _, balista in self.balistas do
        local seat = balista.Seat :: Seat
        
        seat.Changed:Connect(function(property)
            if property == "Occupant" then
                local occupant = seat.Occupant
                local alignOrientation = seat.AlignOrientation :: AlignOrientation
                if occupant then
                    local player = Players:GetPlayerFromCharacter(occupant.Parent)
                    balista:SetAttribute("PlayerId", player.UserId)
                    self.eventBus:fire(self.constants.SERVER_EVENTS.PLAYER_JOINED_BALISTA, {
                        player = player,
                        balista = balista,
                    })
                    alignOrientation.CFrame = CFrame.new(0,0,0)

                    self._connections[seat] = player:GetAttributeChangedSignal("CameraCFrame"):Connect(function()
                        local cameraCFrame = player:GetAttribute("CameraCFrame")
                        alignOrientation.CFrame = cameraCFrame
                    end)
                else
                    local playerId = balista:GetAttribute("PlayerId")
                    local player = Players:GetPlayerByUserId(playerId)
                    if player then
                        self.eventBus:fire(self.constants.SERVER_EVENTS.PLAYER_LEFT_BALISTA, {
                            player = player,
                            balista = balista,
                        })
                    end
					alignOrientation.CFrame = CFrame.new(0, 0, 0)
                    self._connections[seat]:Disconnect()
                    self._connections[seat] = nil
                    balista:SetAttribute("PlayerId", nil)
                end
            end
        end)
        
    end
end

return BalistasService