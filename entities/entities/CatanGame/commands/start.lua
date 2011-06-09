concommand.Add( "sog_start", function( pl, cmd, args )
	
	if( not ValidEntity( pl ) ) then return end
	
	local CPl = pl:GetCPlayer()
	if( not ValidEntity( CPl ) ) then return end
	
	if( not CPl:IsInGame() ) then
		
		pl:ChatPrint( "You are not in a game" )
		return
		
	end
	
	if( not CPl:IsGameHost() ) then
		
		pl:ChatPrint( "You are not the game host" )
		return
		
	end
	
	local started, message = CPl:GetGame():StartGame()
	if( not started ) then
		pl:ChatPrint( message )
	end
	
end )