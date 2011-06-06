
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	
	self.Players = {}
	self.Board = NewBoard( self )
	
end

AccessorFunc( ENT, "CHostPlayer", "Host" )
AccessorFunc( ENT, "Password", "Password" )

function ENT:UpdateTransmitState()
	
	return TRANSMIT_ALWAYS
	
end

function ENT:SetGameID( id )
	
	self.dt.GameID = id
	
end

function ENT:OnDiceRolled( CPlayer, result )
	
	self.TurnManager:OnDiceRolled( CPlayer, result )
	
end

ENUM( "GAME_STATE",
	"LOBBY",
	"STARTED"
	)

function ENT:SetState( game_state )
	
	self.dt.GameState = game_state
	
end

function ENT:StartGame()
	
	if( self:GetNumPlayers() < 2 ) then
		
		return false, "You need at least two players to start the game"
		
	end
	
	self:SetState( GAME_STATE.STARTED )
	
	self.TurnManager = GAMEMODE.TurnManager:GetTurnManager( self )
	
end

function ENT:AddPlayer( CPl )
	
	for i = 1, self:GetMaxPlayers() do
		
		local p = self.Players[ i ]
		if( not p ) then
			
			CPl:SetPlayerID( i )
			CPl:SetGame( self )
			local chair = GAMEMODE:GetChairByID( i )
			CPl:SetPos( chair:LocalToWorld( Vector( 0, 0, 0 ) ) )
			local ang = chair:GetAngles()
			-- ang:RotateAroundAxis( Vector( 0, 0, 1 ), 180 )
			CPl:SetAngles( ang )
			
			self.Players[ i ] = CPl
			
			return true
			
		end
		
	end
	
	Error( "Failed to Add Player ", CPl, " to the game!\n" )
	return false
	
end

function ENT:GetPlayers()
	
	return self.Players
	
end

function ENT:RemovePlayer( CPl )
end

function ENT:CanPlayerJoin( CPl )
	
	if( CPl:IsInGame() ) then return false end
	if( self:GetState() ~= GAME_STATE.LOBBY ) then
		
		CPl:GetPlayer():ChatPrint( "The game has already started" )
		return false
		
	end
	return self:GetNumPlayers() < self:GetMaxPlayers()
	
end

function ENT:SetMaxPlayers( num )
	
	num = math.Clamp( num, 2, 6 )
	
	self.dt.MaxPlayers = num
	
end