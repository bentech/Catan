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

local lastPlayerToTalk
local lastTimePlayerTalked
function GM:OnPlayerChat( pl, txt, bTeam, bDead )
	
	lastPlayerToTalk = pl
	lastTimePlayerTalked = CurTime()
	-- chat.AddText( ply, Color( 255, 255, 255 ), ": "..txt )
	
end

function GM:CreateMove( cmd )
	
	local CPl = LocalCPlayer()
	if( ValidEntity( CPl ) ) then
		
		local ang
		
		if( ValidEntity( lastPlayerToTalk ) and lastPlayerToTalk ~= LocalPlayer() and CurTime() - lastTimePlayerTalked < 2 ) then
			
			local eyeattachment = lastPlayerToTalk:LookupAttachment( "eyes" )
			if ( eyeattachment == 0 ) then return end
			local attachment = lastPlayerToTalk:GetAttachment( eyeattachment )
			if ( not attachment ) then return end
			if ( not attachment.Pos ) then return end
			local eyeattachment = LocalPlayer():LookupAttachment( "eyes" )
			if ( eyeattachment == 0 ) then return end
			local attachment2 = LocalPlayer():GetAttachment( eyeattachment )
			if ( not attachment2 ) then return end
			if ( not attachment2.Pos ) then return end
			ang = ( attachment.Pos - attachment2.Pos ):Angle()
			ang.y = ang.y - CPl:GetAngles().y
			ang.y = math.NormalizeAngle( ang.y )
			ang.y = math.Clamp( ang.y, -45, 45 )
			ang.p = math.Clamp( ang.p, 0, 50 )
			
			local currentyaw = cmd:GetViewAngles().y
			ang.y = Lerp( 0.5, currentyaw, ang.y + 90 )
			
		else
			
			local tracePos = GetPlayerTrace( LocalPlayer() )
			
			if( not tracePos ) then return end
			local eyeattachment = LocalPlayer():LookupAttachment( "eyes" )
			if ( eyeattachment == 0 ) then return end
			local attachment = LocalPlayer():GetAttachment( eyeattachment )
			if ( not attachment ) then return end
			if ( not attachment.Pos ) then return end
			
			ang = (tracePos - SkyboxToWorld(attachment.Pos)):Angle()
			ang.y = ang.y - CPl:GetAngles().y
			ang.y = math.NormalizeAngle( ang.y )
			ang.y = math.Clamp( ang.y, -45, 45 )
			ang.p = math.Clamp( ang.p, 0, 50 )
			
			local currentyaw = cmd:GetViewAngles().y
			ang.y = math.Approach( currentyaw, ang.y + 90, math.min( 1, currentyaw - ang.y ) )
			
		end
		
		cmd:SetViewAngles( ang )
		
	end
	
end