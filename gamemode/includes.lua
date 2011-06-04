
local Prefix = string.sub(GM.Folder, 11)
local PrefixGamemode = Prefix.."/gamemode"

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
	for k,v in pairs(file.FindInLua(PrefixGamemode.."/"..foldername.."/*.lua")) do
		Msg("\tLoading "..v..":")
		include(foldername.."/"..v)
		Msg("Loaded Successfully\n")
	end
	Msg("Loaded Successfully\n")
end

print( "#################################" )
print( "# Loading shared files          #" )

include("enums.lua")
-- include("Systems/PlayerManager/shared/hooks.lua")

print( "# Done loading shared files     #" )
print( "#################################" )

if( SERVER ) then

print( "#################################" )
print( "# Adding CSLua files            #" )

print( "# Done adding CSLua files       #" )
print( "#################################" )

print( "#################################" )
print( "# Loading serverside files      #" )

include("resources.lua")
include("skybox.lua")
include("hooks.lua")

include("Systems/PlayerManager/server/hooks.lua")
includeFolder( "Systems/PlayerManager/commands" )

print( "# Done loading shared files     #" )
print( "#################################" )

elseif( CLIENT ) then

print( "#################################" )
print( "# Loading clientside files      #" )

include("Systems/PlayerManager/client/hooks.lua")

print( "# Done loading shared files     #" )
print( "#################################" )

end