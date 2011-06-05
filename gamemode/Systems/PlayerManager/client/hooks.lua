usermessage.Hook( "SkyCamPos", function( um )
	
	GAMEMODE.skycampos = um:ReadVector()
	
end )

GM.ViewOrigin = Vector( 0, 0, 0 )
GM.ViewDistance = 100
GM.MinViewDistance = 200
GM.MaxViewDistance = 600
GM.ViewAngle = Angle( 20, 0, 0 )
GM.View = {}

function GM:CalcVehicleThirdPersonView( Vehicle, ply, origin, angles, fov )

end

function GM:CalcView( pl, pos, angles, fov )
	
	self.ViewDistance = math.Clamp( self.ViewDistance + self.MoveDelta, self.MinViewDistance, self.MaxViewDistance )
	self.MoveDelta = self.MoveDelta * 0.8
	
	self.ViewAngle.y = self.ViewAngle.y + self.RotationDelta
	self.RotationDelta = self.RotationDelta * 0.8
	
	local view = self.View
		view.origin = self.ViewOrigin + Vector( math.cos( math.Deg2Rad( self.ViewAngle.y ) ) * -self.ViewDistance,
												math.sin( math.Deg2Rad( self.ViewAngle.y ) ) * -self.ViewDistance,
												self.ViewDistance )
		view.angles = self.ViewAngle
		view.fov = 90
	
	return view
	
end

function GM:Think()
	
	-- for _, pl in pairs( player.GetAll() ) do
		
		-- if( pl:IsInGame() || pl:IsSpectatingGame() ) then
			
			-- pl:SetNoDraw( false )
			
		-- else
			
			-- pl:SetNoDraw( true )
			
		-- end
		
	-- end
	
end

function GM:ShouldDrawLocalPlayer( pl )
	
	return true
	-- return pl:IsInGame()
	
end

function GM:PrePlayerDraw()
	
end

function GM:PlayerBindPress( pl, bind )
	
	if( bind:find("duck") ) then return true end
	
end