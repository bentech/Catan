
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	
	self:SetModel( "models/mrgiggles/sog/tile_base.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_NONE )
	
end

function ENT:UpdateTransmitState()
	
	return TRANSMIT_ALWAYS
	
end

function ENT:SetX( x )
	self.dt.X = x
end

function ENT:SetY( y )
	self.dt.Y = y
end

function ENT:SetBoard( board )
	self.dt.Board = board
end

function ENT:SetTerrain( terrainType )
	self:SetSkin( terrainType-1 )
	self.dt.TerrainType = terrainType
end