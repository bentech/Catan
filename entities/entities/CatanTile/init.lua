
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	
	self:SetModel( "models/mrgiggles/sog/tile_base.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	
end

function ENT:SetX( x )
	self.dt.X = x
end

function ENT:SetX( y )
	self.dt.Y = y
end

function ENT:SetBoard( board )
	self.dt.Board = board
end