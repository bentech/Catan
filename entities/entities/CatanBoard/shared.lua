
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

function ENT:SharedInitialize()

	self.Tiles = {}
	
end

function ENT:SetupDataTables()
	
	self:DTVar( "Entity", 0, "Game" )
	
end

function ENT:GetGame()
	
	return self.dt.Game
	
end

function ENT:WorldToTile( WorldPos )
	
	WorldPos = self:WorldToLocal( WorldPos )
	
	local x = math.floor( (WorldPos.x + (2/3*CTILE_WIDTH))/CTILE_WIDTH  )
	local y = math.floor( (WorldPos.y + CTILE_HALF_HEIGHT)/CTILE_HEIGHT + x*0.5 )
	
	return x, y
	
end

function ENT:TileToWorld( PosX, PosY )
	
	local wx = (PosX + 2/3) * CTILE_WIDTH - (2/3*CTILE_WIDTH)
	local wy = (2*PosY - PosX + 1) * CTILE_HALF_HEIGHT - CTILE_HALF_HEIGHT
	
	return self:LocalToWorld( Vector( wx, wy ) )
	
end

function ENT:GetTileAt( PosX, PosY )

	if( not self.Tiles ) then return end
	
	local wx = (PosX + 2/3) * CTILE_WIDTH - (2/3*CTILE_WIDTH)
	
	if( not self.Tiles[ wx ] ) then return end
	
	local wy = (2*PosY - PosX + 1) * CTILE_HALF_HEIGHT - CTILE_HALF_HEIGHT
	
	return self.Tiles[ wx ][ wy ]
	
end