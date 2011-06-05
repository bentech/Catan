
include("shared.lua")

function LocalCPlayer()
	
	return LocalPlayer():GetCPlayer()
	
end

function ENT:Initialize()
	
	ErrorNoHalt( self, "\n" )
	
end

function ENT:Draw()
	
	ErrorNoHalt( "what\n" )
	self:DrawModel()
	
end