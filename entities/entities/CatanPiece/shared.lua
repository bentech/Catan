
ENT.Type = "anim"
ENT.Base = "base_anim"

function ENT:SetupDataTables()
	self:DTVar( "Entity", 0, "Player" )
end

function ENT:GetPlayer()
	return self.dt.Player
end
