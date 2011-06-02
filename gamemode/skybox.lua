function GM:InitPostEntity()
	
	local prop_players = ents.FindByName( "prop_player" )
	for i, chair in pairs( ents.FindByName( "prop_chair" ) ) do
		local playerModel = prop_players[ i ]
		playerModel:SetSequence( playerModel:LookupSequence( "silo_sit" ) )
		playerModel:SetPos( chair:LocalToWorld( Vector( 65, 0, -22 ) ) )
		local ang = chair:GetAngles()
		ang:RotateAroundAxis( Vector( 0, 0, 1 ), 180 )
		playerModel:SetAngles( ang )
	end
	
end