
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	-- self:DrawShadow(false)
	self:SetMoveType( MOVETYPE_NONE )
end

function ENT:SetPlayer( pl )
	
	self.dt.Player = pl
	
end

function ENT:SetBoard( board )
	
	self.dt.Board = board
	
end