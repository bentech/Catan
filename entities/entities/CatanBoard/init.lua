
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function NewBoard( CGame )
	
	local b = ents.Create( "CatanBoard" )
	b:SetGame( CGame )
	b:Spawn()
	b:Activate()
	
	return b
	
end

function ENT:Initialize()
	
	self:SetModel( "models/Roller.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_NONE )
	
	self.desertTile = nil
	
	self:SharedInitialize()
	self:CreateTiles()
	self:CreatePieces()
	
	self:OnBoardSpawned()
	
	local phys = self:GetPhysicsObject()
	if( ValidEntity( phys ) ) then	
	
		phys:EnableMotion( false )
		
	end
	
end

function ENT:UpdateTransmitState()
	
	return TRANSMIT_ALWAYS
	
end

function ENT:SetGame( CGame )
	
	self.dt.Game = CGame
	
end

local tiles_setup_4_players = {
			{ 0, 2},	{ 1, 2},	{ 2, 2},
		{-1, 1},	{ 0, 1},	{ 1, 1},	{ 2, 1},
	{-2, 0},	{-1, 0},	{ 0, 0},	{ 1, 0},	{ 2, 0},
		{-2,-1},	{-1,-1},	{ 0,-1},	{ 1,-1},
			{-2,-2},	{-1,-2},	{ 0,-2},
}
local resource_counts_4_players = {}
	resource_counts_4_players[ Terrain.Desert ] = 1
	resource_counts_4_players[ Terrain.Hills ] = 3
	resource_counts_4_players[ Terrain.Pasture ] = 4
	resource_counts_4_players[ Terrain.Mountains ] = 3
	resource_counts_4_players[ Terrain.Fields ] = 4
	resource_counts_4_players[ Terrain.Forest ] = 4

local tiles_setup_6_players = {
				{ 0, 3},	{ 1, 3},	{ 2, 3},
			{-1, 2},	{ 0, 2},	{ 1, 2},	{ 2, 2},
		{-2, 1},	{-1, 1},	{ 0, 1},	{ 1, 1},	{ 2, 1},
	{-3, 0},	{-2, 0},	{-1, 0},	{ 0, 0},	{ 1, 0},	{ 2, 0},
		{-3,-1},	{-2,-1},	{-1,-1},	{ 0,-1},	{ 1,-1},
			{-3,-2},	{-2,-2},	{-1,-2},	{ 0,-2},
				{-3,-3},	{-2,-3},	{-1,-3},
}
local resource_counts_6_players = {}
	resource_counts_6_players[ Terrain.Desert ] = 2
	resource_counts_6_players[ Terrain.Hills ] = 5
	resource_counts_6_players[ Terrain.Pasture ] = 6
	resource_counts_6_players[ Terrain.Mountains ] = 5
	resource_counts_6_players[ Terrain.Fields ] = 6
	resource_counts_6_players[ Terrain.Forest ] = 6

function ENT:CreateTiles()
	
	local tiles = {}
	local player_count = self:GetGame():GetNumPlayers()
	local resource_counts
	local tiles_setup
	
	if( player_count > 4 ) then
		
		--Generate larger board
		resource_counts = resource_counts_6_players
		tiles_setup = tiles_setup_6_players
		
	else
		
		--Generate regular board
		resource_counts = resource_counts_4_players
		tiles_setup = tiles_setup_4_players
		
	end
	
	local tile_count = 0
	for terrainType, count in pairs( resource_counts ) do
		
		for i = 1, count do
			
			ErrorNoHalt( "Creating ", TerrainName( terrainType ), "\n" )
			tile_count = tile_count + 1
			tiles[ tile_count ] = self:CreateTile( terrainType )
			
		end
		
	end
	
	for _, tile_pos in rpairs( tiles_setup ) do
		
		local x, y = tile_pos[1], tile_pos[2]
		if( not self.Tiles[ x ] ) then
			
			self.Tiles[ x ] = {}
			
		end
		
		local tile = tiles[ tile_count ]
		tile:SetPos( self:TileToWorld( x, y ) )
		tile:SetX( x )
		tile:SetY( y )
		-- tile:SetParent( self )
		self.Tiles[ x ][ y ] = tile
		tile_count = tile_count - 1
		
		tile:Spawn()
		tile:Activate()
		
	end
	
	--TODO: Center the board on the table
	
end

function ENT:CreateTile( terrainType )
	
	local tile = ents.Create( "CatanTile" )
	tile:SetTerrain( terrainType )
	tile:SetBoard( self )
	tile:SetPos( self:GetPos() )
	tile:SetAngles( Angle( 0, 90 + math.random(1,6) * 60, 0 ) )
	
	if( terrainType == Terrain.Desert ) then
		self.desertTile = tile
	end
	
	return tile
	
end

function ENT:SetRobber( robber )
	
	self.dt.Robber = robber
	
end

function ENT:CreatePieces()
	
	self:CreateRobber()
	
end

function ENT:CreateRobber()
	
	local robber = ents.Create( "CatanPieceRobber" )
	robber:SetTile( self.desertTile )
	
	self:SetRobber( robber )
	
	robber:Spawn()
	robber:Activate()
	
end

function ENT:OnBoardSpawned()
	
end