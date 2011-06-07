
GM.Lobby = {}
GM.Lobby.Games = {}

local Lobby = GM.Lobby

local gameIDIncrement = 1
local defaultMaxPlayers = 6

function Lobby:CreateGame( CPlayerHost, MaxPlayers, GameName, GamePass )
	
	if( self:NumGames() > 0 ) then
		
		CPlayerHost:GetPlayer():ChatPrint( "Only one game at a time is currently supported" )
		return
		
	end
	
	local CGame = ents.Create( "CatanGame" )
	CGame:Spawn()
	CGame:SetMaxPlayers( MaxPlayers or defaultMaxPlayers )
	CGame:SetState( GAME_STATE.LOBBY )
	CGame:AddPlayer( CPlayerHost )
	CGame:SetHost( CPlayerHost )
	CGame:SetName( GameName )
	CGame:SetPassword( GamePass )
	CGame:Activate()
	
	CGame:SetGameID( gameIDIncrement )
	gameIDIncrement = gameIDIncrement + 1
	
	self.Games[ CGame:GameID() ] = CGame
	
	CPlayerHost:GetPlayer():ChatPrint( "You've successfully created a new game." )
	
end

function Lobby:JoinGame( CPlayer, GameID, GamePass )
	
	local CGame = self.GetGameByID( GameID )
	if( not CGame ) then
		
		CPlayer:GetPlayer():ChatPrint( "Invalid GameID: Could not find game" )
		return
		
	end
	
	if( CGame:GetPassword() ~= GamePass ) then
		
		CPlayer:GetPlayer():ChatPrint( "Invalid Password" )
		return
		
	end
	
	if( CGame:CanPlayerJoin( CPlayer ) ) then
		
		CGame:AddPlayer( CPlayer )
		
		CPlayer:GetPlayer():ChatPrint( "You've successfully join the game." )
		
	end
	
end

function Lobby:List( CPlayer )
	
	for ID, CGame in pairs( Lobby.Games ) do
		
		local str = "[" .. ID .. "]" .. CGame:GetName()
		if( CGame:GetPassword() ) then
			
			str = str .. "(Passworded)"
			
		end
		
		CPlayer:GetPlayer():ChatPrint( str )
		
	end
	
end

function Lobby:NumGames()
	
	return table.Count( Lobby.Games )
	
end

function Lobby:RemoveGame( CGame )
	
	self.Games[ CGame:GameID() ] = nil
	
end

function Lobby.GetGameByID( id )
	
	id = tonumber( id )
	
	for ID, CGame in pairs( Lobby.Games ) do
		
		if( ID == id ) then
			
			return CGame
			
		end
		
	end
	
end