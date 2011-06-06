function GM:CalcMainActivity( ply, velocity )	
	ply.CalcIdeal = ACT_MP_STAND_IDLE
	ply.CalcSeqOverride = ply:LookupSequence( "sit_rollercoaster" )
	
	return ply.CalcIdeal, ply.CalcSeqOverride
end

function GM:UpdateAnimation( pl, velocity, maxseqgroundspeed )
	
	if ( pl:InVehicle() ) then
		
		local Vehicle =  pl:GetVehicle()
		
		// We only need to do this clientside..
		if ( CLIENT ) then
			//
			// This is used for the 'rollercoaster' arms
			//
			local Velocity = Vehicle:GetVelocity()
			pl:SetPoseParameter( "vertical_velocity", Velocity.z * 0.01 ) 

			// Pass the vehicles steer param down to the player
			local steer = Vehicle:GetPoseParameter( "vehicle_steer" )
			steer = steer * 2 - 1 // convert from 0..1 to -1..1
			pl:SetPoseParameter( "vehicle_steer", steer  ) 
		end
		
	end
	
end

function GM.PlayerMeta:GetCPlayer()
	
	return self:GetNWEntity( "CPlayer" )
	
end

function GM.PlayerMeta:IsInGame()
	
	local CPl = self:GetCPlayer()
	if( not ValidEntity( CPl ) ) then return false end
	
	if( CPl:IsInGame() ) then
		return true
	end
	
	return false
	
end

function GM.PlayerMeta:IsSpectatingGame()
	
	local CPl = self:GetCPlayer()
	if( not ValidEntity( CPl ) ) then return false end
	
	if( CPl:IsSpectatingGame() ) then
		return true
	end
	
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