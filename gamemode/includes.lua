
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
	for k,v in pairs(file.FindInLua(PrefixGamemode.."/"..foldername.."/*.lua")) do
		Msg("\tAddCSLuaFile "..v..":")
		AddCSLuaFile(foldername.."/"..v)
		Msg("Successful\n")
	end
	Msg("AddCSLuaDirectory: Successful\n")
end

function includeFolder( foldername )
	Msg("Loading "..foldername.." Files...\n")
	trace_include = false
	for k,v in pairs(file.FindInLua(PrefixGamemode.."/"..foldername.."/*.lua")) do
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

	AddCSLuaFolder( "Systems/PlayerManager/client" )
	AddCSLuaFolder( "Systems/PlayerManager/shared" )
	AddCSLuaFolder( "Systems/TurnManager/client" )
	AddCSLuaFolder( "Systems/TurnManager/shared" )
	AddCSLuaFolder( "Systems/Lobby/client" )
	AddCSLuaFolder( "Systems/Lobby/shared" )
	AddCSLuaFolder( "GUI" )
	AddCSLuaFile( "utilities.lua" )
	AddCSLuaFile( "enums.lua" )

	print( "# Done adding CSLua files       #" )
	print( "#################################" )

	print( "#################################" )
	print( "# Loading serverside files      #" )

	include("resources.lua")
	include("skybox.lua")
	include("hooks.lua")

	include("Systems/PlayerManager/server/hooks.lua")
	include("Systems/TurnManager/server/core.lua")
	includeFolder( "Systems/PlayerManager/server/commands" )
	include("Systems/Lobby/server/core.lua")
	includeFolder( "Systems/Lobby/server/commands" )

	print( "# Done loading shared files     #" )
	print( "#################################" )

elseif( CLIENT ) then

	print( "#################################" )
	print( "# Loading clientside files      #" )

	include("Systems/PlayerManager/client/core.lua")
	include("Systems/PlayerManager/client/chat.lua")
	include("Systems/PlayerManager/client/hooks.lua")
	include("GUI/core.lua")
	include("GUI/nametags.lua")
	include("GUI/chatbox.lua")
	include( "enums.lua" )

	print( "# Done loading shared files     #" )
	print( "#################################" )

end

include = old_include