
ENT.Type = "anim"
ENT.Base = "base_anim"

function ENT:SharedInitialize()
	
	self.UsedColors = {}
	self.Players = {}
	self.Spectators = {}
	
end

function ENT:SetupDataTables()
	
	self:DTVar( "Int", 0, "GameID" )
	self:DTVar( "Int", 1, "NumPlayers" )
	self:DTVar( "Int", 2, "MaxPlayers" )
	self:DTVar( "Int", 3, "GameState" )
	self:DTVar( "Entity", 0, "Board" )
	
end

function ENT:GameID()
	
	return self.dt.GameID
	
end

function ENT:GetPlayers()
	
	return self.Players
	
end

function ENT:GetBoard()
	
	return self.dt.Board
	
end

function ENT:GetNumPlayers()
	
	return self.dt.NumPlayers
	
end

function ENT:GetSpectators()
	
	return self.Spectators
	
end

function ENT:GetNumSpectators()
	
	return #self.Spectators
	
end

function ENT:GetMaxPlayers()
	
	return self.dt.MaxPlayers
	
end

function ENT:GetState()
	
	return self.dt.GameState
	
end

function ENT:GetPlayerByID( id )
	
	return self.Players[ id ]
	
end

ENUM( "PlayerColor", "Red", "Blue", "Green", "Orange", "White", "Brown" )