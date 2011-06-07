
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
	
	self.Tiles = {}
	self:CreateTiles()
	
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

local tiles_setup_6_players = {
				{ 0, 3},	{ 1, 3},	{ 2, 3},
			{-1, 2},	{ 0, 2},	{ 1, 2},	{ 2, 2},
		{-2, 1},	{-1, 1},	{ 0, 1},	{ 1, 1},	{ 2, 1},
	{-3, 0},	{-2, 0},	{-1, 0},	{ 0, 0},	{ 1, 0},	{ 2, 0},
		{-3,-1},	{-2,-1},	{-1,-1},	{ 0,-1},	{ 1,-1},
			{-3,-2},	{-2,-2},	{-1,-2},	{ 0,-2},
				{-3,-3},	{-2,-3},	{-1,-3},
}

function ENT:CreateTiles()
	
	local player_count = self:GetGame():GetNumPlayers()
	if( player_count > 4 ) then
		
		--Generate larger board
		
	else
	
		--Generate regular board
		
	end
	
	local tile = ents.Create( "CatanTile" )
	tile:SetPos( self:GetPos() )
	tile:SetParent( self )
	tile:Spawn()
	tile:Activate()
	self.Tiles[ 1 ] = tile
	
	self:OnBoardSpawned()
end

function ENT:OnBoardSpawned()

	--TODO: Usermessage the client and call OnBoardSpawned clientside
	
end