
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
end

function ENT:SetID( id )
	
	self.dt.PlayerID = id
	
end

function ENT:SetPlayer( pl )
	
	self.dt.Player = pl
	
end