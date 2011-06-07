
local Prefix = string.sub(GM.Folder, 11)
local PrefixGamemode = Prefix.."/gamemode"

local old_include = include
local trace_include = true
function include( filename )
	
	if( trace_include ) then
		Msg("\tincluding "..filename,"\n")
	end
	old_include( filename )
	
end

function AddCSLuaFolder( foldername )
	Msg("AddCSLuaDirectory: "..foldername.."...\n")
	for k,v in pairs(file.FindInLua( foldername.."/*.lua")) do
		Msg("\tAddCSLuaFile "..v..":")
		AddCSLuaFile(foldername.."/"..v)
		Msg("Successful\n")
	end
	Msg("AddCSLuaDirectory: Successful\n")
end

function includeFolder( foldername )
	Msg("Loading "..foldername.." Files...\n")
	trace_include = false
	for k,v in pairs(file.FindInLua( foldername.."/*.lua")) do
		Msg("\tLoading "..v..":")
		include(foldername.."/"..v)
		Msg("Loaded Successfully\n")
	end
	Msg("Loaded Successfully\n")
	trace_include = true
end

print( "#################################" )
print( "# Loading shared files          #" )

include("enums.lua")
include("utilities.lua")
include("Systems/PlayerManager/shared/hooks.lua")

print( "# Done loading shared files     #" )
print( "#################################" )

if( SERVER ) then

	print( "#################################" )
	print( "# Adding CSLua files            #" )

	AddCSLuaFolder( PrefixGamemode.."/Systems/PlayerManager/client" )
	AddCSLuaFolder( PrefixGamemode.."/Systems/PlayerManager/shared" )
	AddCSLuaFolder( PrefixGamemode.."/Systems/TurnManager/client" )
	AddCSLuaFolder( PrefixGamemode.."/Systems/TurnManager/shared" )
	AddCSLuaFolder( PrefixGamemode.."/Systems/Lobby/client" )
	AddCSLuaFolder( PrefixGamemode.."/Systems/Lobby/shared" )
	AddCSLuaFolder( PrefixGamemode.."/GUI" )
	AddCSLuaFile( "utilities.lua" )

	print( "# Done adding CSLua files       #" )
	print( "#################################" )

	print( "#################################" )
	print( "# Loading serverside files      #" )

	include("resources.lua")
	include("skybox.lua")
	include("hooks.lua")

	include("Systems/PlayerManager/server/hooks.lua")
	includeFolder( PrefixGamemode.."/Systems/PlayerManager/server/commands" )
	include("Systems/Lobby/server/core.lua")
	includeFolder( PrefixGamemode.."/Systems/Lobby/server/commands" )

	print( "# Done loading shared files     #" )
	print( "#################################" )

elseif( CLIENT ) then

	print( "#################################" )
	print( "# Loading clientside files      #" )

	include("Systems/PlayerManager/client/core.lua")
	include("Systems/PlayerManager/client/hooks.lua")
	include("GUI/core.lua")

	print( "# Done loading shared files     #" )
	print( "#################################" )

end

include = old_include