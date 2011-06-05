concommand.Add( "create", function( pl, cmd, args )
	
	local CPl = pl:GetCPlayer()
	if( not ValidEntity( CPl ) ) then return end
	
	if( CPl:IsInGame() ) then
		
		pl:ChatPrint( "You cannot make a game while you are in one" )
		return
		
	end
	
	GAMEMODE.Lobby:CreateGame( CPl, args[1] )
	
end )