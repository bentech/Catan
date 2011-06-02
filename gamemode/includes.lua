

function AddCSLuaFolder( foldername, bRecursive )
	
	--TODO: AddCSLuaFile() all lua files in this folder
	
end

function includefolder( foldername, bRecursive )
	
	--TODO: include all lua files in this folder
	
end

print( "#################################" )
print( "# Loading shared files          #" )

print( "# Done loading shared files     #" )
print( "#################################" )

if( SERVER ) then

print( "#################################" )
print( "# Adding CSLua files            #" )

print( "# Done adding CSLua files       #" )
print( "#################################" )

print( "#################################" )
print( "# Loading serverside files      #" )

print( "# Done loading shared files     #" )
print( "#################################" )

elseif( CLIENT ) then

print( "#################################" )
print( "# Loading clientside files      #" )

print( "# Done loading shared files     #" )
print( "#################################" )

end