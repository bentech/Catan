concommand.Add( "sog_ready", function( pl, cmd, args )
	
	if( not ValidEntity( pl ) ) then return end
	
	local CPl = pl:GetCPlayer()
	if( not ValidEntity( CPl ) ) then return end
	
	local CGame = CPl:GetGame()
	if( not ValidEntity( CGame ) ) then
		
		pl:ChatPrint( "You are not in a game" )
		return
		
	end
	
	if( CPl:ColorID() == 0 ) then
		
		pl:ChatPrint( "You cannot ready up until you choose a color" )
		return
		
	end
	
	if( CGame:GetState() ~= GAME_STATE.LOBBY ) then
		
		pl:ChatPrint( "You can only readyup in a lobby" )
		return
		
	end
	
	CPl:SetReady( tobool( args[1] ) )
	
end )