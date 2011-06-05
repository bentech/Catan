function GM:CalcMainActivity( ply, velocity )	
	ply.CalcIdeal = ACT_MP_STAND_IDLE
	ply.CalcSeqOverride = ply:LookupSequence( "sit_rollercoaster" )
	
	return ply.CalcIdeal, ply.CalcSeqOverride
end

function GM.PlayerMeta:IsInGame()
	
	return true
	
end

function GM.PlayerMeta:IsSpectatingGame()
	
	return false
	
end

function GM:SetupMove( pl, mv )
	
	mv:SetForwardSpeed( 0 )
	mv:SetUpSpeed( 0 )
	mv:SetSideSpeed( 0 )
	mv:SetVelocity( Vector(0) )
	
end

function GM:Move( pl, data )
	
	data:SetForwardSpeed( 0 )
	data:SetUpSpeed( 0 )
	data:SetSideSpeed( 0 )
	data:SetVelocity( Vector(0) )
	
end