
ENT.Type = "anim"
ENT.Base = "base_anim"

VARTYPE_STRING = "String"
VARTYPE_SHORT = "Short"
VARTYPE_LONG = "Long"
VARTYPE_BOOL = "Bool"
VARTYPE_CHAR = "Char"

ENT.NWVars = {}

local function PlayerAccessorFuncNW( tab, varname, name, varDefault, vartype, bPrivate )
	
	if(not tab.NWVars) then return end
	
	tab[ "Get"..name ] = function ( self, default )
		return self[ varname ] or default or varDefault
	end
	
	--Add to NWVars table for loading newcomers
	tab.NWVars[ name ] = vartype
	
	if(CLIENT) then
		usermessage.Hook( "cplayer.NW"..vartype.."_"..name, function( um )
			local id = um:ReadShort()
			local emp = EMPIRES[id]
			if(not emp) then
				print("networked var on cplayer: ", emp, name, "\n")
				return
			end
			emp[ "Set"..name ]( emp, um[ "Read"..vartype ](um) )
		end )
	end
	
	if ( vartype == VARTYPE_STRING ) then
		tab[ "Set"..name ] = function ( self, v )
			self[varname] = tostring(v)
			if(SERVER) then
				umsg.Start( "cplayer.NW"..vartype.."_"..name, (bPrivate and ValidEntity(self:GetPlayer())) and self:GetPlayer() or nil )
					umsg.Short( self:GetID() )
					umsg[ vartype ]( v )
				umsg.End()
			end
		end
	return end
	
	if ( vartype == VARTYPE_SHORT ) then
		tab[ "Set"..name ] = function ( self, v )
			self[varname] = tonumber(v)
			if(SERVER) then
				umsg.Start( "cplayer.NW"..vartype.."_"..name, (bPrivate and ValidEntity(self:GetPlayer())) and self:GetPlayer() or nil )
					umsg.Short( self:GetID() )
					umsg[ vartype ]( v )
				umsg.End()
			end
		end
	return end
	
	if ( vartype == VARTYPE_LONG ) then
		tab[ "Set"..name ] = function ( self, v )
			self[varname] = tonumber(v)
			if(SERVER) then
				umsg.Start( "cplayer.NW"..vartype.."_"..name, (bPrivate and ValidEntity(self:GetPlayer())) and self:GetPlayer() or nil )
					umsg.Long( self:GetID() )
					umsg[ vartype ]( v )
				umsg.End()
			end
		end
	return end
	
end

local PRIVATE = true

PlayerAccessorFuncNW( ENT, "res_Wool", "Wool", 0, VARTYPE_SHORT, PRIVATE )
PlayerAccessorFuncNW( ENT, "res_Brick", "Brick", 0, VARTYPE_SHORT, PRIVATE )
PlayerAccessorFuncNW( ENT, "res_Ore", "Ore", 0, VARTYPE_SHORT, PRIVATE )
PlayerAccessorFuncNW( ENT, "res_Grain", "Grain", 0, VARTYPE_SHORT, PRIVATE )
PlayerAccessorFuncNW( ENT, "res_Lumber", "Lumber", 0, VARTYPE_SHORT, PRIVATE )

PRIVATE = nil

AccessorFuncNW( ENT, "victory_points", "VictoryPoints", FORCE_NUMBER )

function ENT:SetupDataTables()
	
	self:DTVar( "Int", 0, "PlayerID" )
	self:DTVar( "Entity", 0, "Player" )
	self:DTVar( "Entity", 1, "Game" )
	
end

function ENT:PlayerID()
	
	return self.dt.PlayerID
	
end

function ENT:GetPlayer()
	
	return self.dt.Player
	
end

function ENT:GetGame()
	
	return self:GetDTEntity( 1 )
	
end

function ENT:IsInGame()
	
	return ValidEntity( self:GetGame() )
	
end

function ENT:IsSpectatingGame()
	
	--TODO:
	return false
	
end