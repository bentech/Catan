
GM.PlayerManager = {}
GM.PlayerManager.Players = {}

function GM.PlayerMeta:SetCPlayer( CPl )
	
	self:SetNWEntity( "CPlayer", CPl )
	
end

function GM:PlayerInitialSpawn( pl )
	
	gamemode.Call( "AssociatePlayer", pl )
	
	pl:ChatPrint( "We don't have a UI yet, so use these commands instead." )
	pl:ChatPrint( "/list to see a list of games" )
	pl:ChatPrint( "/join [GameID] to join a game" )
	pl:ChatPrint( "/spec [GameID] to spectate a game" )
	pl:ChatPrint( "/create to create a game lobby" )
	pl:ChatPrint( "/help to see available ingame commands" )
	
	self:SetupPlayerModel( pl )
	
	if( !host_player ) then
		
		host_player = pl
		
	end
	
	umsg.Start( "SkyCamPos", pl )
		umsg.Vector( self.skycam:GetPos() )
	umsg.End()
	
	pl:SetHullDuck( Vector( -16, -16, 0 ), Vector( 16, 16, 72 ) )
	-- pl:SetAllowFullRotation( true )
	
end

function GM:CanPlayerEnterVehicle( pl, vehicle )
	
	if( pl.CanEnterVehicle ) then
		
		ErrorNoHalt( "Entering vehicle\n" )
		pl.CanEnterVehicle = false
		return true
		
	end
	
	return false
	
end

function GM:CanExitVehicle()
	
	return false
	
end

function GM.PlayerManager.GetPlayers()
	
	return GAMEMODE.PlayerManager.Players
	
end

function GM:SetupPlayerModel( pl )
	
	pl:SetModel( "models/Player/Group01/Male_01.mdl" )
	
end

function GM:AssociatePlayer( pl )
	
	local associated = false
	
	for _, CPl in pairs( self.PlayerManager.GetPlayers() ) do
		
		if( CPl:UniqueID() == pl:UniqueID() ) then
			
			associated = true
			
			CPl:SetPlayer( pl )
			pl:SetCPlayer( CPl )
			pl:ChatPrint( "Welcome back " .. pl:Name() )
			break
			
		end
		
	end
	
	if( not associated ) then
		
		--No player found, create a new one
		local CPl = ents.Create( "CatanPlayer" )
		CPl:Spawn()
		CPl:SetPos( Vector( 0, 0, -CPl:OBBMins().z ) )
		CPl:SetPlayer( pl )
		pl:SetCPlayer( CPl )
		pl:ChatPrint( "Welcome " .. pl:Name() )
		CPl:Activate()
		
	end
	
	gamemode.Call( "SendGameData", pl )
	
end

function GM:SendGameData( pl )
	
	--TODO: send any custom networked variables to the player, stuff that was sent with usermessages.
	
end

function GM:PlayerSpawn( pl )
	
	-- pl:SetMoveType( MOVETYPE_NOCLIP )
	
end

function GM:PlayerNoClip( pl )
	
	return false
	
end

function GM:CanPlayerSuicide( pl )
	
	return false
	
end