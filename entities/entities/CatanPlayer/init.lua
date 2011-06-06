
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	
	self:SetModel( "models/props_c17/furniturechair001a.mdl" )
	-- self:PhysicsInitBox( Vector() * -1, Vector() )
	self:PhysicsInit( SOLID_VPHYSICS )
	
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_NONE )
	
	self.Vehicle = ents.Create( "prop_vehicle_prisoner_pod" )
	self.Vehicle:SetModel( "models/props_c17/furniturechair001a.mdl" )
	self.Vehicle:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
	self.Vehicle:SetKeyValue( "limitview", 0 )
	self.Vehicle:SetPos( self:GetPos() )
	self.Vehicle:SetNoDraw( true )
	self.Vehicle:SetAngles( self:GetAngles() )
	self.Vehicle:SetParent( self )
	self.Vehicle:SetMoveType( MOVETYPE_NONE )
	self.Vehicle:SetSolid( SOLID_NONE )
	self.Vehicle:Spawn()
	self.Vehicle:Activate()
	self.Vehicle:GetPhysicsObject():EnableMotion( false )
	
	local phys = self:GetPhysicsObject()
	if( IsValid( phys ) ) then
		
		phys:EnableMotion( false )
		
	end
	
end

function ENT:Think()
	
	-- self:SetAngles( Angle( 0, self:GetAngles().y + 1, 0 ) )
	
end

function ENT:UpdateTransmitState()
	
	return TRANSMIT_ALWAYS
	
end

function ENT:SetGame( CGame )
	
	self.dt.Game = CGame
	
end

function ENT:UniqueID()
	
	return self.UniqueID
	
end

function ENT:SetPlayerID( id )
	
	self.dt.PlayerID = id
	
end

function ENT:RollDie()
	
	timer.Simple( 4, function()
		self:GetGame():OnDiceRolled( self, math.random( 1, 12 ) )
	end )
	
end

function ENT:SetEyeTarget( targetPos )
	
	self.dt.EyeTarget = targetPos
	
end

function ENT:SetPlayer( pl )
	
	self.dt.Player = pl
	self.UniqueID = pl:UniqueID()
	
	pl.CanEnterVehicle = true
	pl:EnterVehicle( self.Vehicle )
	
end