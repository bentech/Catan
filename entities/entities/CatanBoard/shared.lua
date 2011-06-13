
ENT.Type = "anim"
ENT.Base = "base_anim"

CTILE_HEIGHT = 88.8
CTILE_HALF_HEIGHT = CTILE_HEIGHT * 0.5
CTILE_NARROW_WIDTH = CTILE_HEIGHT / math.cos( math.rad( 30 ) )
CTILE_SIZE = CTILE_NARROW_WIDTH * 0.5
CTILE_SEGMENT = CTILE_SIZE * math.sin( math.rad( 30 ) )
CTILE_WIDTH = (3*CTILE_HALF_HEIGHT) / (2*math.sin( math.rad( 60 ) ))

ENUM( "Terrain",
	"Hills",
	"Pasture",
	"Mountains",
	"Fields",
	"Forest",
	"Desert"
	)
	

function TerrainName( terrainType )
	
	if( terrainType == Terrain.Desert ) then
		return "Desert"
	elseif( terrainType == Terrain.Hills ) then
		return "Hills"
	elseif( terrainType == Terrain.Pasture ) then
		return "Pasture"
	elseif( terrainType == Terrain.Mountains ) then
		return "Mountains"
	elseif( terrainType == Terrain.Fields ) then
		return "Fields"
	elseif( terrainType == Terrain.Forest ) then
		return "Forest"
	end
	
end

function ENT:SharedInitialize()

	self.Tiles = {}
	self.Vertexs = {}
	self.Edges = {}
	
end

function ENT:SetupDataTables()
	
	self:DTVar( "Entity", 0, "Game" )
	self:DTVar( "Entity", 1, "Robber" )
	
end

function ENT:GetGame()
	
	return self.dt.Game
	
end

function ENT:GetRobber()
	
	return self.dt.Robber
	
end

function ENT:WorldToTile( WorldPos )
	
	WorldPos = self:WorldToLocal( WorldPos )
	
	local x = (WorldPos.x + (2/3*CTILE_WIDTH))/CTILE_WIDTH
	local tx = x
	x = math.floor( x )
	local y = (WorldPos.y + CTILE_HALF_HEIGHT)/CTILE_HEIGHT + x*0.5
	local ty = y
	y = math.floor( y )
	
	local a = math.atan2( 0.5-ty%1, tx%1 )
	if( a < -1 ) then
		
		x = x - 1
		
	elseif( a > 1 ) then
		
		y = y - 1
		x = x - 1
		
	end
	
	return x, y, tx, ty
	
end

function ENT:WorldToVertex( WorldPos )
	
	WorldPos = self:WorldToLocal( WorldPos )
	local u = WorldPos.x / CTILE_WIDTH
	local v = WorldPos.y / CTILE_HALF_HEIGHT + u
	
	local b = v/2%1
	if( b > u%1 ) then
		
		v = v + 1
		
	end
	if( b > 0.5 ) then
		
		v = v - 1
		
	end
	
	return math.floor( u ), math.floor( v ), u, v
	
end

function ENT:VertexToWorld( PosX, PosY )
	
	local wx = PosX * CTILE_WIDTH
	local wy = (PosY - PosX) * CTILE_HALF_HEIGHT
	
	if( PosY % 2 == 0 ) then
		
		wx = wx + CTILE_SIZE
		
	else
		
		wx = wx + CTILE_SEGMENT
		
	end
	
	return self:LocalToWorld( Vector( wx, wy ) ), wx, wy
	
end

function ENT:TileToWorld( PosX, PosY )
	
	local wx = PosX * CTILE_WIDTH
	local wy = (2*PosY - PosX) * CTILE_HALF_HEIGHT
	
	return self:LocalToWorld( Vector( wx, wy ) )
	
end

function ENT:GetTileAt( PosX, PosY )
	
	if( not self.Tiles ) then return end
	if( not self.Tiles[ PosX ] ) then return end
	
	return self.Tiles[ PosX ][ PosY ]
	
end

function ENT:GetVertexAt( PosX, PosY )
	
	if( not self.Vertexs ) then return end
	if( not self.Vertexs[ PosX ] ) then return end
	
	return self.Vertexs[ PosX ][ PosY ]
	
end