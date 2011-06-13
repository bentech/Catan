concommand.Add( "sog_requestcolor", function( pl, cmd, args )
	
	if( not ValidEntity( pl ) ) then return end
	
	local CPl = pl:GetCPlayer()
	if( not ValidEntity( CPl ) ) then return end
	
	if( not CPl:IsInGame() ) then
		
		pl:ChatPrint( "You cannot choose a color when you are not in-game" )
		return
		
	end
	
	local col = tonumber( args[1] )
	if ( not col ) then
		
		col = tostring( args[1] or "" ):lower()
		if( col == "red" ) then
			col = PlayerColor.Red
		elseif( col == "green" ) then
			col = PlayerColor.Green
		elseif( col == "blue" ) then
			col = PlayerColor.Blue
		elseif( col == "orange" ) then
			col = PlayerColor.Orange
		elseif( col == "brown" ) then
			col = PlayerColor.Brown
		elseif( col == "white" ) then
			col = PlayerColor.White
		else
			pl:ChatPrint( "Invalid color value chosen" )
			return
		end
		
	elseif( col < 1 or col > 6 ) then
		
		pl:ChatPrint( "Invalid color value chosen" )
		return
		
	end
	
	if ( not CPl:GetGame():RequestColor( CPl, col ) ) then
		
		return
		
	end
	
end )