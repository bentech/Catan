
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