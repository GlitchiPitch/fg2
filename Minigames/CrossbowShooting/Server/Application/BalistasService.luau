---@class CrossbowShootingServerBalistasService
local BalistasService = {}
BalistasService.__index = BalistasService

---@param diContainer DIContainer
---@return CrossbowShootingServerBalistasService
function BalistasService.new(diContainer)
	local self = setmetatable({}, BalistasService)
    self.diContainer = diContainer
	return self
end

function BalistasService:init()
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
                if occupant then
                    balista:SetAttribute("PlayerId", occupant.UserId)
                    
                else
                    balista:SetAttribute("PlayerId", nil)
                end
            end
        end)
        
    end
end

return BalistasService