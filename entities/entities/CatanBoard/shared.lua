
ENT.Type = "anim"
ENT.Base = "base_anim"

CTILE_HEIGHT = 16
CTILE_HALF_HEIGHT = CTILE_HEIGHT * 0.5
CTILE_NARROW_WIDTH = CTILE_HEIGHT / math.cos( math.rad( 30 ) )
CTILE_SIZE = CTILE_NARROW_WIDTH * 0.5
CTILE_SEGMENT = CTILE_SIZE * math.sin( math.rad( 30 ) )
CTILE_WIDTH = (3*CTILE_HALF_HEIGHT) / (2*math.sin( math.rad( 60 ) ))

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
	
	local x = math.floor( (wpos.x + (2/3*CTILE_WIDTH))/CTILE_WIDTH  )
	local y = math.floor( (wpos.y + CTILE_HALF_HEIGHT)/CTILE_HEIGHT + x*0.5 )
	
	return x, y
	
end

function ENT:GetTileAt( PosX, PosY )

	if( not self.Tiles ) then return end
	
end