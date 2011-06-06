
include("shared.lua")

function LocalCPlayer()
	
	return LocalPlayer():GetCPlayer()
	
end

function ENT:Initialize()
	
	self:SetRenderBounds( Vector() * -100, Vector() * 100 )
	
end

function ENT:Draw()
end