
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.Edges = {}
ENT.Corners = {}

function ENT:SetupDataTables()
	self:DTVar( "Int", 0, "X" )
	self:DTVar( "Int", 1, "Y" )
	self:DTVar( "Entity", 0, "Board" )
end

function ENT:GetX()
	return self.dt.X
end

function ENT:GetY()
	return self.dt.Y
end

function ENT:GetBoard()
	return self.dt.Board
end

function ENT:AddCorner( pos, corner )
	self.Corners[pos] = corner
end

function ENT:AddEdge( pos, edge )
	self.Edges[pos] = edge
end

function ENT:GetEdges()
	return self.Edges
end

function ENT:GetCorners()
	return self.Corners
end

function ENT:SetDiceValue( value )
	self.DiceValue = value
end

function ENT:GetDiceValue()
	return self.DiceValue
end

function ENT:HasRobber()
	return self:GetBoard():GetRobber():GetTile() == self
end

function ENT:GetAdjacentTiles()
	
	if( self.adjacentTiles ) then
		
		return self.adjacentTiles
		
	end
	
	self.adjacentTiles = {}
	self.adjacentTiles[ "UP" ] = self:GetUP()
	self.adjacentTiles[ "DN" ] = self:GetDN()
	self.adjacentTiles[ "LL" ] = self:GetLL()
	self.adjacentTiles[ "UL" ] = self:GetUL()
	self.adjacentTiles[ "LR" ] = self:GetLR()
	self.adjacentTiles[ "UR" ] = self:GetUR()
	
	return self.adjacentTiles
	
end

function ENT:GetDN()
	
	--return Tile( self.x, self.y + 1 )
	return self:GetBoard():GetTileAt( self:GetX(), self:GetY() - 1 )
	
end

function ENT:GetUP()
	
	--return Tile( self.x, self.y - 1 )
	return self:GetBoard():GetTileAt( self:GetX(), self:GetY() + 1 )
	
end

function ENT:GetLL()
	
	--local col = self.x % 2
	--return Tile( self.x-1, self.y+col )
	return self:GetBoard():GetTileAt( self:GetX() - 1, self:GetY() - 1 )
	
end

function ENT:GetUL()
	
	--local col = (self.x + 1) % 2
	--return Tile( self.x-1, self.y-col )
	return self:GetBoard():GetTileAt( self:GetX() - 1, self:GetY() )
	
end

function ENT:GetLR()
	
	--local col = self.x % 2
	--return Tile( self.x+1, self.y+col )
	return self:GetBoard():GetTileAt( self:GetX() + 1, self:GetY() )
	
end

function ENT:GetUR()
	
	--local col = (self.x + 1) % 2
	--return Tile( self.x+1, self.y-col )
	return self:GetBoard():GetTileAt( self:GetX() + 1, self:GetY() + 1 )
	
end