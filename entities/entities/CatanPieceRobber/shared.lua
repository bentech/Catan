
ENT.Type = "anim"
ENT.Base = "catanpiece"

function ENT:SetupDataTables()
	self.BaseClass.SetupDataTables(self)
	self:DTVar( "Entity", 2, "Tile" )
end

function ENT:GetTile()
	return self.dt.Tile
end
