
include("shared.lua")

function LocalCPlayer()
	
	return LocalPlayer():GetCPlayer()
	
end

function ENT:Initialize()
end

function ENT:Draw()
	
	self:DrawModel()
	
end