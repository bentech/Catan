
ENT.Type = "anim"
ENT.Base = "base_anim"

function ENT:SetupDataTables()
	
	self:DTVar( "Entity", 0, "Game" )
	
end

function ENT:GetGame()
	
	return self.dt.Game
	
end