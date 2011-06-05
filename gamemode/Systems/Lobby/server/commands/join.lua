concommand.Add( "join", function( pl, cmd, args )
	
	if( not ValidEntity( pl ) ) then return end
	
	local CPl = pl:GetCPlayer()
	if( not ValidEntity( CPl ) ) then return end
	
	if( CPl:IsInGame() ) then
		
		pl:ChatPrint( "You cannot join a game while you are in one" )
		return
		
	end
	
	local gameID = tonumber( args[1] )
	local game_pass = args[2]
	
	GAMEMODE.Lobby:JoinGame( CPl, game_id, game_pass )
	
end )