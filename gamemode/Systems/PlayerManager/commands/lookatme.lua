concommand.Add( "lookatme", function( pl, cmd, args )
	
	for _, ent in pairs( ents.FindByName( "prop_player" ) ) do
		
		ent:SetEyeTarget( pl:EyePos() )
		
	end
	
end )