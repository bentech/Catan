function GM:InitSkybox()
	
	for _, prop in pairs( ents.FindByName( "prop_player" ) ) do
		prop:Remove()
	end
	
	self.Chairs = ents.FindByName( "prop_chair" )
	for i, chair in pairs( self.Chairs ) do
		chair:SetNWInt( "ID", i )
	end
	
end

function GM:GetChairByID( id )
	
	for i, chair in pairs( self.Chairs ) do
		
		if( chair:GetNWInt( "ID" ) == id ) then
			
			return chair
			
		end
		
	end
	
	Error( "Invalid Chair ID ", id, "\n" )
	
end