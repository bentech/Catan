
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
 
function ENT:Initialize()
	
	self:SetModel( "models/Player/Group01/Male_01.mdl" )
	self:SetSequence( self:LookupSequence( "sit_rollercoaster" ) )
	
end

local function ConvertRelativeToEyesAttachment( Entity, Pos )

	// Convert relative to eye attachment
	local eyeattachment = Entity:LookupAttachment( "eyes" )
	if ( eyeattachment == 0 ) then return end
	local attachment = Entity:GetAttachment( eyeattachment )
	if ( !attachment ) then return end
	
	local LocalPos, LocalAng = WorldToLocal( Pos, Angle(0,0,0), attachment.Pos, attachment.Ang )
	
	return LocalPos
	
end

function ENT:Think()
	
	local pl = host_player
	if( not ValidEntity( pl ) ) then return end
	
	local pos = pl:EyePos() * 1/16 + GAMEMODE.skycampos
	
	--self:SetPoseParameter( "head_pitch", -34.8 )
	-- self:SetEyeTarget( ConvertRelativeToEyesAttachment( self, self.target:GetPos() ) )
	
end