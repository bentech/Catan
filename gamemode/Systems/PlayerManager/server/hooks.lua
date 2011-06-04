
function GM:AssociatePlayer( pl )
end

function GM:PlayerInitialSpawn( pl )
	
	pl:ChatPrint( "Welcome " .. pl:Name() )
	pl:ChatPrint( "We don't have a UI yet, so use these commands instead." )
	pl:ChatPrint( "/list to see a list of games" )
	pl:ChatPrint( "/join [GameID] to join a game" )
	pl:ChatPrint( "/spec [GameID] to spectate a game" )
	pl:ChatPrint( "/create to create a game lobby" )
	pl:ChatPrint( "/help to see available ingame commands" )
	
	if( !host_player ) then
		
		host_player = pl
		
	end
	
	umsg.Start( "SkyCamPos", pl )
		umsg.Vector( self.skycam:GetPos() )
	umsg.End()
	
end

function GM:PlayerSpawn( pl )
	
	pl:SetMoveType( MOVETYPE_NOCLIP )
	
end

function GM:PlayerNoClip( pl )
	
	return false
	
end

function GM:CanPlayerSuicide( pl )
	
	return false
	
end