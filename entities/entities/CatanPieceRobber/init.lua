
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	
	self.BaseClass.Initialize( self )
	
	self:SetModel( "models/mrgiggles/sog/robber.mdl" )
	
end

function ENT:SetTile(tile)
	
	self.dt.Tile = tile
	self:SetPos( tile:GetPos() )
	
end