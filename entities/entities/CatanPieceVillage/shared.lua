
ENT.Type = "anim"
ENT.Base = "CatanPiece"

function ENT:SetupDataTables()
	self.BaseClass.SetupDataTables(self)
	self:DTVar( "Entity", 1, "Corner" )
end

function ENT:GetCorner()
	return self.dt.Corner
end
