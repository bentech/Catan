
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	
	self.Players = {}
	self.Board = NewBoard( self )
	
end

function ENT:SetGameID( id )
	
	self.dt.GameID = id
	
end

function ENT:StartGame()
	
	if( self:GetNumPlayers() < 2 ) then
		
		return false, "You need at least two players to start the game"
		
	end
	
end

function ENT:AddPlayer( pl )
end

function ENT:CanPlayerJoin( pl )
end

function ENT:SetMaxPlayers( num )
	
	num = math.Clamp( num, 2, 6 )
	
	self.dt.MaxPlayers = num
	
end