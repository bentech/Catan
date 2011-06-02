function ENUM( enumName, ... )
	
	if( not enumName ) then return end
	
	assert( _G[ "enumName" ] == nil )
	
	local e = {}
	
	for i = 1, #arg do
		e[ arg[i] ] = i
	end
	
	_G[ enumName ] = e
	
end