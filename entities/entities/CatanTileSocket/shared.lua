
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.AdjacentTiles = {}
ENT.ConnectedEdges = {}

function ENT:SetupDataTables()
	self:DTVar( "Entity", 0, "Piece" )
end

function ENT:GetPiece()
	return self.dt.Piece
end

function ENT:GetAdjacentTiles()
	return self.AdjacentTiles
end

function ENT:GetConnectedEdges()
	return self.ConnectedEdges
end

function ENT:AddAdjacentTile( pos, tile )
	self.AdjacentTiles[pos] = tile
end

function ENT:AddConnectedEdge( pos, edge )
	self.ConnectedEdges[pos] = edge
end
