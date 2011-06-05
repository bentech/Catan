
GM.Lobby = {}
GM.Lobby.Games = {}

local Lobby = GM.Lobby

local gameIDIncrement = 1
local defaultMaxPlayers = 6

function Lobby:CreateGame( CPlayerHost, MaxPlayers )
	
	local CGame = ents.Create( "CatanGame" )
	CGame:Spawn()
	CGame:SetMaxPlayers( MaxPlayers or defaultMaxPlayers )
	CGame:SetState( GAME_STATE.LOBBY )
	CGame:AddPlayer( CPlayerHost )
	CGame:SetHost( CPlayerHost )
	CGame:Activate()
	
	CGame:SetGameID( gameIDIncrement )
	gameIDIncrement = gameIDIncrement + 1
	
	self.Games[ CGame:GameID() ] = CGame
	
	CPlayerHost:GetPlayer():ChatPrint( "You've successfully created a new game." )
	
end

function Lobby.GetGameByID( id )
	
	for _, CGame in pairs( GAMEMODE.Lobby.Games ) do
		
		if( CGame:GameID() == id ) then
			
			return CGame
			
		end
		
	end
	
end