function GM:InitSkybox()
	
	for _, prop in pairs( ents.FindByName( "prop_player" ) ) do
		prop:Remove()
	end
	
	for i, chair in pairs( ents.FindByName( "prop_chair" ) ) do
		local playerModel = ents.Create( "npc_catanplayer" )
		playerModel:Spawn()
		playerModel:Activate()
		playerModel:SetPos( chair:LocalToWorld( Vector( 65, 0, -20 ) ) )
		local ang = chair:GetAngles()
		ang:RotateAroundAxis( Vector( 0, 0, 1 ), 180 )
		playerModel:SetAngles( ang )
	end
	
end