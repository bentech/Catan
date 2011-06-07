concommand.Add( "requestcolor", function( pl, cmd, args )
	
	if( not ValidEntity( pl ) ) then return end
	
	local CPl = pl:GetCPlayer()
	if( not ValidEntity( CPl ) ) then return end
	
	if( !CPl:IsInGame() ) then
		
		pl:ChatPrint( "You cannot choose a color when you are not in-game" )
		return
		
	end
	
	local col = tonumber( args[1] )
	if ( !col or col < 1 or col > 6 ) then
		
		pl:ChatPrint( "Invalid color value chosen" )
		return
		
	end
	
	if ( !CPl:GetGame():RequestColor( CPl, col ) ) then
		
		pl:ChatPrint( "You can not choose this color" )
		return
		
	end
	
end )