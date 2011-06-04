
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	
	self:SetModel( "models/humans/Group01/Male_01.mdl" )
	self:SetSequence( self:LookupSequence( "silo_sit" ) )
	--self:DrawShadow( false )
	--self:SetMoveType( MOVETYPE_CUSTOM )
	
	self.rag = ents.Create( "prop_ragdoll" )
	self.rag:SetModel( self:GetModel() )
	self.rag:SetPos( self:GetPos() )
	self.rag:SetAngles( self:GetAngles() )
	self.rag:Spawn()
	self.rag:Activate()
	self.rag:SetParent( self )
	self.rag:AddEffects( EF_BONEMERGE )
	self.rag:DrawShadow( false )
	self:SetNWEntity( "ragdoll", self.rag )
	
	local phys = self.rag:GetPhysicsObject()
	if( ValidEntity( phys ) ) then
		
		for i = 0, self.rag:GetPhysicsObjectCount()-1 do
			
			local bone = self.rag:GetPhysicsObjectNum( i )
			if( bone ) then bone:EnableMotion( false ) end
			
		end
		
	end
	
end
