
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	
	self.Players = {}
	self.Board = NewBoard( self )
	
end

AccessorFunc( ENT, "CHostPlayer", "Host" )

function ENT:UpdateTransmitState()
	
	return TRANSMIT_ALWAYS
	
end

function ENT:SetGameID( id )
	
	self.dt.GameID = id
	
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
	
end

function ENT:AddPlayer( CPl )
	
	for i = 1, self:GetMaxPlayers() do
		
		local p = self.Players[ i ]
		ErrorNoHalt( i, "\t", p, "\n" )
		if( not p ) then
			
			CPl:SetID( i )
			CPl:SetGame( self )
			local chair = GAMEMODE:GetChairByID( i )
			CPl:SetPos( chair:LocalToWorld( Vector( 65, 0, 0 ) ) )
			local ang = chair:GetAngles()
			ang:RotateAroundAxis( Vector( 0, 0, 1 ), 180 )
			CPl:SetAngles( ang )
			-- CPl:GetPlayer():SetEyeAngles( ang )
			
			return true
			
		end
		
	end
	
	Error( "Failed to Add Player ", CPl, " to the game!\n" )
	return false
	
end

function ENT:RemovePlayer( CPl )
end

function ENT:CanPlayerJoin( CPl )
end

function ENT:SetMaxPlayers( num )
	
	num = math.Clamp( num, 2, 6 )
	
	self.dt.MaxPlayers = num
	
end