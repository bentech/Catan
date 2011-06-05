
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	
	self:SetModel( "models/props_c17/furniturechair001a.mdl" )
	-- self:PhysicsInitBox( Vector() * -1, Vector() )
	self:PhysicsInit( SOLID_VPHYSICS )
	
	self:SetMoveType(MOVETYPE_CUSTOM)
	self:SetSolid(SOLID_VPHYSICS)
	
	local phys = self:GetPhysicsObject()
	if( IsValid( phys ) ) then
		
		phys:EnableMotion( false )
		
	end
	
	ErrorNoHalt( self, "\n" )
	
end

function ENT:Think()
	
	ErrorNoHalt( "Thinking\n" )
	self:SetAngles( Angle( 0, CurTime() * 4, 0 ) )
	
end

-- function ENT:UpdateTransmitState()
	
	-- return TRANSMIT_ALWAYS
	
-- end

function ENT:SetGame( CGame )
	
	self.dt.Game = CGame
	
end

function ENT:UniqueID()
	
	return self.UniqueID
	
end

function ENT:SetPlayerID( id )
	
	self.dt.PlayerID = id
	
end

function ENT:SetPlayer( pl )
	
	self.dt.Player = pl
	self.UniqueID = pl:UniqueID()
	
end