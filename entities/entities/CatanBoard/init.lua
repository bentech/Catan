
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

function ENT:CreateTiles()
	
	local player_count = self:GetGame():GetNumPlayers()
	if( player_count > 4 ) then
	end
	
	self:OnBoardSpawned()
end

function ENT:OnBoardSpawned()

	--TODO: Usermessage the client and call OnBoardSpawned clientside
	
end