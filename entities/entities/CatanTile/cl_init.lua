
include("shared.lua")

function ENT:Initialize()
	
	if( not self:GetBoard().Tiles[ self:GetX() ] ) then
		
		self:GetBoard().Tiles[ self:GetX() ] = {}
		
	end
	
	self:GetBoard().Tiles[ self:GetX() ][ self:GetY() ] = self
	
end

local Vector_Up = Vector( 0, 0, 50 )

surface.CreateFont ( "coolvetica", 40, 400, true, false, "CV20", true )
	

local Laser = Material( "cable/redlaser" )

function ENT:Draw()
	
	self:DrawModel()
	render.SetMaterial( Laser )
	local up = Vector( 0, 0, self:OBBMaxs().z )
	render.DrawBeam( self:GetPos() + up, self:GetBoard():TileToWorld( self:GetX() + 1, self:GetY() ) + up, 5, 0, 0, color_white )
	render.DrawBeam( self:GetPos() + up, self:GetBoard():TileToWorld( self:GetX() + 1, self:GetY() + 1 ) + up, 5, 0, 0, color_white )
	render.DrawBeam( self:GetPos() + up, self:GetBoard():TileToWorld( self:GetX(), self:GetY() + 1 ) + up, 5, 0, 0, color_white )
	render.DrawBeam( self:GetPos() + up, self:GetBoard():TileToWorld( self:GetX() - 1, self:GetY() ) + up, 5, 0, 0, color_white )
	render.DrawBeam( self:GetPos() + up, self:GetBoard():TileToWorld( self:GetX() - 1, self:GetY() - 1 ) + up, 5, 0, 0, color_white )
	render.DrawBeam( self:GetPos() + up, self:GetBoard():TileToWorld( self:GetX(), self:GetY() - 1 ) + up, 5, 0, 0, color_white )
	
	local CPl = LocalCPlayer()
	if( not ValidEntity( CPl ) ) then return end
	
	local CGame = CPl:GetGame()
	if( not ValidEntity( CGame ) ) then return end
	
	local board = CGame:GetBoard()
	if( not ValidEntity( board ) ) then return end
	
	local tr = GetPlayerTrace()
	local x, y, u, v = board:WorldToVertex( tr )
	local pos = board:VertexToWorld( x, y )
	render.DrawBeam( pos, pos + Vector_Up, 5, 0, 0, color_white )
	
end

hook.Add( "HUDPaint", "CatanTile.HUDPaint", function()
	
	local CPl = LocalCPlayer()
	if( not ValidEntity( CPl ) ) then return end
	
	local CGame = CPl:GetGame()
	if( not ValidEntity( CGame ) ) then return end
	
	local board = CGame:GetBoard()
	if( not ValidEntity( board ) ) then return end
	
	local tr = GetPlayerTrace()
	surface.SetFont( "CV20" )
	local w, h = surface.GetTextSize( "" )
	local localPos = board:WorldToLocal( tr )
	local x, y, u, v = board:WorldToVertex( tr )
	local pos, wx, wy = board:VertexToWorld( x, y )
	
	draw.DrawText( tostring( math.Round( x, 2 ) .. ", " .. math.Round( y, 2 ) ), "CV20", gui.MouseX(), gui.MouseY(), color_white, TEXT_ALIGN_CENTER )
	draw.DrawText( tostring( math.Round( u%1, 2 ) .. ", " .. math.Round( v/2%1, 2 ) ), "CV20", gui.MouseX(), gui.MouseY() + h, color_white, TEXT_ALIGN_CENTER )
	draw.DrawText( tostring( math.Round( wx, 2 ) .. ", " .. math.Round( wy, 2 ) ), "CV20", gui.MouseX(), gui.MouseY() + 2*h, color_white, TEXT_ALIGN_CENTER )
	
end )

hook.Add( "PostDrawOpaqueRenderables", "CatanTile.PostDrawOpaqueRenderables", function()
	
	local CPl = LocalCPlayer()
	if( not ValidEntity( CPl ) ) then return end
	
	local CGame = CPl:GetGame()
	if( not ValidEntity( CGame ) ) then return end
	
	local board = CGame:GetBoard()
	if( not ValidEntity( board ) ) then return end
	
	local tr = GetPlayerTrace()
	surface.SetFont( "CV20" )
	
	for _, ent in pairs( ents.FindByClass( "CatanTile" ) ) do
		local ang = ( ent:GetPos() - GAMEMODE.View.origin ):Angle()
		cam.Start3D2D( ent:GetPos() + Vector_Up, Angle( 0, ang.y-90, 90-ang.p ), 0.33 )
			
			local ok, err = pcall( ent.DebugDraw, ent, tr )
			
		cam.End3D2D()
	end
	
end )

function ENT:DebugDraw( tr )
	
	local w, h = surface.GetTextSize( "" )
	draw.DrawText( tostring( self:GetX() ) .. ", " .. tostring( self:GetY() ), "CV20", 0, 0, color_white, TEXT_ALIGN_CENTER )
	draw.DrawText( tostring( TerrainName( self:GetTerrain() ) ), "CV20", 0, h + 2, color_white, TEXT_ALIGN_CENTER )
	
	local board = self:GetBoard()
	if( not board ) then return end
	
	local x, y = board:WorldToTile( tr )
	if( board:GetTileAt( x, y ) == self ) then
		
		self:SetColor( 0, 0, 0, 255 )
		
	else
	
		self:SetColor( 255, 255, 255, 255 )
	
	end
	
end