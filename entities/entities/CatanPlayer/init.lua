
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
end

function ENT:UpdateTransmitState()
	
	return TRANSMIT_ALWAYS
	
end

function ENT:SetGame( CGame )
	
	self:SetDTEntity( 1, CGame )
	
end

function ENT:UniqueID()
	
	return self.UniqueID
	
end

function ENT:SetID( id )
	
	self.dt.PlayerID = id
	
end

function ENT:SetPlayer( pl )
	
	self.dt.Player = pl
	self.UniqueID = pl:UniqueID()
	
end