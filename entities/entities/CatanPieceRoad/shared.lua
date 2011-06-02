
ENT.Type = "anim"
ENT.Base = "CatanPiece"

function ENT:SetupDataTables()
	self.BaseClass.SetupDataTables(self)
	self:DTVar( "Entity", 1, "Edge" )
end

function ENT:GetEdge()
	return self.dt.Edge
end
