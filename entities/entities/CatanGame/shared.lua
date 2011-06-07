
ENT.Type = "anim"
ENT.Base = "base_anim"

function ENT:SetupDataTables()
	
	self:DTVar( "Int", 0, "GameID" )
	self:DTVar( "Int", 1, "NumPlayers" )
	self:DTVar( "Int", 2, "MaxPlayers" )
	self:DTVar( "Int", 3, "GameState" )
	
end

function ENT:GameID()
	
	return self.dt.GameID
	
end

function ENT:GetNumPlayers()
	
	return self.dt.NumPlayers
	
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

ENUM( "PlayerColor", "Red", "Blue", "Green", "Yellow", "White", "Black" )
ENT.UsedColors = {}

function ENT:RequestColor( CPlayer, Color_Enum )
	
	if ( CPlayer.dt.Color != 0 or self.UsedColors[Color_Enum] ) then return false end
	
	CPlayer.dt.Color = Color_Enum
	self.UsedColors[Color_Enum] = true
	
	return true
	
end