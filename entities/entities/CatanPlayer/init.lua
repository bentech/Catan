
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	
	self:SetModel( "models/props_c17/furniturechair001a.mdl" )
	-- self:PhysicsInitBox( Vector() * -1, Vector() )
	self:PhysicsInit( SOLID_VPHYSICS )
	
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_NONE )
	
	self:SetColorID( 0 )
	
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

function ENT:IsGameHost()
	
	if( not self:IsInGame() ) then return end
	return self:GetGame():GetHost() == self
	
end

function ENT:ChatPrint( msg )
	
	local pl = self:GetPlayer()
	if( ValidEntity( pl ) ) then
		
		pl:ChatPrint( msg )
		
	end
	
end

function ENT:SetGame( CGame )
	
	self.dt.Game = CGame
	
end

function ENT:UniqueID()
	
	return self.UID
	
end

function ENT:SetPlayerID( id )
	
	self.dt.PlayerID = id
	
end

function ENT:SetColorID( id )
	
	self.dt.Color = id
	
end

function ENT:SetReady( bool )
	
	self.readyflag = bool
	
	self:GetGame():OnPlayerReady( self, bool )
	
	umsg.Start( "CatanGame.PlayerReady", self:GetGame():GetRecipientFilter() )
		
		umsg.Char( self:PlayerID()-128 )
		umsg.Bool( bool )
		
	umsg.End()
	
end

function ENT:RollDie()
	
	self:ChatPrint( "You rolled the dice" )
	timer.Simple( 4, function()
		self:GetGame():OnDiceRolled( self, math.random( 2, 12 ) )
	end )
	
end

function ENT:SetEyeTarget( targetPos )
	
	self.dt.EyeTarget = targetPos
	
end

function ENT:SetPlayer( pl )
	
	self.dt.Player = pl
	self.UID = pl:UniqueID()
	
	pl.CanEnterVehicle = true
	pl:EnterVehicle( self.Vehicle )
	self:SetName( pl:GetName() )
	
end