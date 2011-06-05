
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
	
	pl:SetModel( "models/Player/Group01/Male_01.mdl" )
	
	if( !host_player ) then
		
		host_player = pl
		
	end
	
	umsg.Start( "SkyCamPos", pl )
		umsg.Vector( self.skycam:GetPos() )
	umsg.End()
	
	pl:SetHullDuck( Vector( -16, -16, 0 ), Vector( 16, 16, 72 ) )
	
end

function GM:PlayerSpawn( pl )
	
	--Temporary
	local chair = ents.FindByName( "prop_chair" )[1]
	pl:SetPos( chair:LocalToWorld( Vector( 65, 0, 0 ) ) )
	local ang = chair:GetAngles()
	ang:RotateAroundAxis( Vector( 0, 0, 1 ), 180 )
	pl:SetEyeAngles( ang )
	----------
	
	pl:SetMoveType( MOVETYPE_CUSTOM )
	
end

function GM:PlayerNoClip( pl )
	
	return false
	
end

function GM:CanPlayerSuicide( pl )
	
	return false
	
end