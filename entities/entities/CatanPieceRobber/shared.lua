
ENT.Type = "anim"
ENT.Base = "CatanPiece"

function ENT:SetupDataTables()
	self.BaseClass.SetupDataTables(self)
	self:DTVar( "Entity", 1, "Tile" )
end

function ENT:GetTile()
	return self.dt.Tile
end
