concommand.Add( "sog_start", function( pl, cmd, args )
	
	if( not ValidEntity( pl ) ) then return end
	
	local CPl = pl:GetCPlayer()
	if( not ValidEntity( CPl ) ) then return end
	
	if( not CPl:IsInGame() ) then
		
		CPl:GetPlayer():ChatPrint( "You are not in a game" )
		return
		
	end
	
	if( not CPl:IsGameHost() ) then
		
		CPl:GetPlayer():ChatPrint( "You are not the game host" )
		return
		
	end
	
end )