
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	
	self:SetModel( "models/props_c17/furniturechair001a.mdl" )
	self:PhysicsInitBox( Vector() * -1, Vector() )
	
	local phys = self:GetPhysicsObject()
	if( IsValid( phys ) ) then
		
		phys:EnableMotion( false )
		
	end
	
end

function ENT:Think()
	
	self:SetAngles( Angle( 0, CurTime() * 4, 0 ) )
	
end

function ENT:UpdateTransmitState()
	
	return TRANSMIT_ALWAYS
	
end

function ENT:SetGame( CGame )
	
	self:SetDTEntity( 1, CGame )
	
end

function ENT:UniqueID()
	
	return self.UniqueID
	
end

function ENT:SetID( id )
	
	self.dt.PlayerID = id
	
end

function ENT:SetPlayer( pl )
	
	self.dt.Player = pl
	self.UniqueID = pl:UniqueID()
	
end