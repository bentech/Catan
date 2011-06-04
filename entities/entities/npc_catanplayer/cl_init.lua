
include("shared.lua")

function ENT:Initialize()
end

function ENT:Draw()
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

function ENT:BuildBonePositions( NumBones, NumPhysBones )
	
	local ent = self:GetNWEntity( "ragdoll" )
	if( not ValidEntity( ent ) ) then return end
	
	ent:AddEffects( EF_BONEMERGE )
	-- ent:SetAngles( self:GetAngles() )
	-- ent:SetPos( self:GetPos() )
	-- for i = 1, NumBones do
		
		-- local pos, ang = self:GetBonePosition( i )
		-- ent:SetBonePosition( i, pos, ang )
		
	-- end
	
	if( GAMEMODE.skycampos ) then
		local pos = LocalPlayer():EyePos() * 1/16 + GAMEMODE.skycampos
		-- ErrorNoHalt( pos, "\n" )
		ent:SetEyeTarget( ConvertRelativeToEyesAttachment( ent, pos ) )
	end
	
	-- ent:SetFlexWeight( 0, 0 )
	-- ent:SetFlexWeight( 1, 0 )
	-- ent:SetFlexWeight( 2, 1 )
	-- ent:SetFlexWeight( 3, 1 )
	-- ent:SetFlexWeight( 4, 1 )
	-- ent:SetFlexWeight( 5, 1 )
	-- ent:SetFlexWeight( 6, 1 )
	-- ent:SetFlexWeight( 7, 1 )
	-- ent:SetFlexWeight( 8, 1 )
	-- ent:SetFlexWeight( 9, 1 )
	-- ent:SetFlexWeight( 48, math.sin( CurTime() * 4 + ent:EntIndex()*12 ) * 10 - 5 )
	-- ent:SetFlexWeight( 49, math.sin( CurTime() * 4 + ent:EntIndex()*12 ) * 10 - 5 )
	
end