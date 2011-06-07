usermessage.Hook( "SkyCamPos", function( um )
	
	GAMEMODE.skycampos = um:ReadVector()
	
end )

GM.skycampos = Vector( 4808, 247.9688, 0 )
GM.ViewOrigin = Vector( 0, 0, 0 )
GM.ViewDistance = 400
GM.MinViewDistance = 200
GM.MaxViewDistance = 600
GM.ViewAngle = Angle( 64, 0, 0 )
GM.View = {}
GM.View.origin = Vector()
GM.View.angles = Angle()
GM.View.aim = Vector()

function GM:CalcVehicleThirdPersonView( Vehicle, ply, origin, angles, fov ) end

function GM:CalcView( pl, pos, angles, fov )
	
	self.ViewDistance = math.Clamp( self.ViewDistance + self.MoveDelta, self.MinViewDistance, self.MaxViewDistance )
	self.MoveDelta = self.MoveDelta * 0.8
	
	self.ViewAngle.y = self.ViewAngle.y + self.RotationDelta
	self.RotationDelta = self.RotationDelta * 0.8
	
	local view = self.View
		view.origin = self.ViewOrigin + Vector( math.cos( math.Deg2Rad( self.ViewAngle.y ) ) * -self.ViewDistance,
												math.sin( math.Deg2Rad( self.ViewAngle.y ) ) * -self.ViewDistance,
												self.ViewDistance )
		self.ViewAngle.p = (64-40) * (1 - (self.ViewDistance-self.MinViewDistance) / (self.MaxViewDistance-self.MinViewDistance)) + (40)
		view.angles = self.ViewAngle
		view.fov = fov
	
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
	
end

function GM:PrePlayerDraw( pl )
	
	local CPl = pl:GetCPlayer()
	if( ValidEntity( CPl ) ) then
		
		if( not (CPl:IsInGame() or CPl:IsSpectatingGame()) ) then
			
			return true
			
		end
		
	else
	
		return true
		
	end
	
end

function GM:PlayerBindPress( pl, bind )
	
	if( bind:find("duck") ) then return true end
	
end

local function GetPlayerTrace( pl )
	
	local intersectPos = intersectRayPlane( GAMEMODE.View.origin, GAMEMODE.View.origin + GAMEMODE.View.aim * 4096, GAMEMODE.ViewOrigin, Vector( 0, 0, 1 ) )
	return intersectPos
	
end

function GM:CreateMove( cmd )
	
	local CPl = LocalCPlayer()
	if( ValidEntity( CPl ) ) then
		
		local tracePos = GetPlayerTrace( LocalPlayer() )
		
		if( not tracePos ) then return end
		local eyeattachment = LocalPlayer():LookupAttachment( "eyes" )
		if ( eyeattachment == 0 ) then return end
		local attachment = LocalPlayer():GetAttachment( eyeattachment )
		if ( not attachment ) then return end
		if ( not attachment.Pos ) then return end
		
		local currentyaw = cmd:GetViewAngles().y
		local ang = (tracePos - SkyboxToWorld(attachment.Pos)):Angle()
		ang.y = ang.y - CPl:GetAngles().y
		ang.y = math.NormalizeAngle( ang.y )
		ang.y = math.Clamp( ang.y, -45, 45 )
		ang.p = math.Clamp( ang.p, 0, 50 )
		
		ang.y = math.Approach( currentyaw, ang.y + 90, math.min( 1, currentyaw - ang.y ) )
		
		-- ErrorNoHalt( ang, "\n" )
		
		cmd:SetViewAngles( ang )
		
	end
	
end