
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