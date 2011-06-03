
ENT.Type = "anim"
ENT.Base = "base_anim"

function ENT:SetupDataTables()
	
	self:DTVar( "Int", 0, "GameID" )
	self:DTVar( "Int", 0, "NumPlayers" )
	
end

function ENT:GameID()
	
	return self.dt.GameID
	
end

function ENT:GetNumPlayers()
	
	return self.dt.NumPlayers
	
end

function ENT:GetPlayerByID( id )
	
	return self.Players[ id ]
	
end