concommand.Add( "list", function( pl, cmd, args )
	
	if( not ValidEntity( pl ) ) then return end
	
	local CPl = pl:GetCPlayer()
	if( not ValidEntity( CPl ) ) then return end
	
	GAMEMODE.Lobby:List( CPl )
	
end )