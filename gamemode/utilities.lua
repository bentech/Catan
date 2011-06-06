function intersectRayPlane( S1, S2, P, N ) --( startpoint, endpoint, point on plane, plane's normal )
	
	local u = S2 - S1
	local w = S1 - P
	
	local d = N:Dot( u )
	local n = N:Dot( w )*-1
	
	if (math.abs( d ) < 0) then
		ErrorNoHalt( "parallel! WTF\n" )
		if (n == 0) then return end	--segment is in the plane
		return				--no intersection
	end
	
	local sI = n/d
	if (sI < 0 || sI > 1) then return end	--no intersection
	return S1 + sI * u
	
end

function rpairs( t )
	
	local keys = {}
	for k,_ in pairs( t ) do table.insert( keys, k ) end
	
	return function()
		if #keys == 0 then return nil end
		
		local i = math.random( 1, #keys )
		local k = keys[ i ]
		local v = t[ k ]
		
		table.remove( keys, i )
		return k, v
	end
	
end

function WorldToSkybox( pos )
	
	return pos * 1/16 + GAMEMODE.skycampos
	
end

function SkyboxToWorld( pos )
	
	return (pos - GAMEMODE.skycampos) * 16
	
end