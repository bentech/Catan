concommand.Add( "sog_forfeit", function( pl, cmd, args )
	
	if( not ValidEntity( pl ) ) then return end
	
	local CPl = pl:GetCPlayer()
	if( not ValidEntity( CPl ) ) then return end
	
	--TODO: forfeiting
	pl:ChatPrint( "This feature isn't implemented yet" )
	
end )