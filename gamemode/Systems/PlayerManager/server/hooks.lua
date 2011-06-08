
GM.PlayerManager = {}
GM.PlayerManager.Players = {}

local PlayerManager = GM.PlayerManager

function GM.PlayerMeta:SetCPlayer( CPl )
	
	self:SetNWEntity( "CPlayer", CPl )
	
end

function GM:PlayerInitialSpawn( pl )
	
	self:SetupPlayerModel( pl )
	
	if( !host_player ) then
		
		host_player = pl
		
	end
	
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

function GM.PlayerManager.CreatePlayer( pl, uid )
	
	local CPl = ents.Create( "CatanPlayer" )
	CPl:Spawn()
	CPl:Activate()
	CPl:SetPos( Vector( 0, 0, -CPl:OBBMins().z ) )
	
	timer.Simple( 0, function()
		CPl:SetPlayer( pl )
		pl:SetCPlayer( CPl )
	end )
	
	PlayerManager.Players[ uid ] = CPl
	
	pl:ChatPrint( "Welcome " .. pl:Name() )
	
end

function GM:SetupPlayerModel( pl )
	
	if ( math.random( 1, 2 ) == 1 ) then
		pl:SetModel( "models/Player/Group01/Male_0" .. math.random( 1, 9 ) .. ".mdl" )
	else
		local r = math.random( 1, 7 ) if ( r == 5 ) then r = 6 end
		pl:SetModel( "models/Player/Group01/Female_0" .. r .. ".mdl" )
	end
	
end

concommand.Add( "~cl_ready", function( pl )
	
	if (!ValidEntity( pl )) then return end
	if pl.ready then return end
	
	pl.ready = true
	gamemode.Call( "PlayerInitialized", pl )
	
end )

function GM:PlayerInitialized( pl )
	
	gamemode.Call( "AssociatePlayer", pl )
	
	pl:ChatPrint( "We don't have a UI yet, so use these commands instead." )
	pl:ChatPrint( "/list to see a list of games" )
	pl:ChatPrint( "/join [GameID] to join a game" )
	pl:ChatPrint( "/spec [GameID] to spectate a game" )
	pl:ChatPrint( "/create to create a game lobby" )
	pl:ChatPrint( "/help to see available ingame commands" )
	
end

function GM:AssociatePlayer( pl )
	
	local associated = false
	local uid = pl:UniqueID()
	for _, CPl in pairs( self.PlayerManager.GetPlayers() ) do
		
		ErrorNoHalt( CPl:UniqueID(), uid, "\n" )
		
		if( CPl:UniqueID() == uid ) then
			
			associated = true
			
			CPl:SetPlayer( pl )
			pl:SetCPlayer( CPl )
			pl:ChatPrint( "Welcome back " .. pl:Name() )
			break
			
		end
		
	end
	
	if( not associated ) then
		
		--No player found, create a new one
		self.PlayerManager.CreatePlayer( pl, uid )
		
	end
	
	gamemode.Call( "SendGameData", pl )
	
end

function GM:SendGameData( pl )
	
	--TODO: send any custom networked variables to the player, stuff that was sent with usermessages.
	
	umsg.Start( "SkyCamPos", pl )
		umsg.Vector( self.skycam:GetPos() )
	umsg.End()
	
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