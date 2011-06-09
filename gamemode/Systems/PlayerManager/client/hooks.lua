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

function GM:HUDPaint()
	local X = self.Chatbox.XOrigin
	local Y = self.Chatbox.YOrigin
	local Lines = 0
	local Count = table.Count(self.Chatbox.Chat)
	local k, v = 0, 0
	
	surface.SetFont(self.Chatbox.ChatFont)
	for i=0,Count do
		k = Count - i
		v = self.Chatbox.Chat[k]
		if(v and Lines < self.Chatbox.MaxLines) then
			Y = self.Chatbox:DrawLine(X, Y, v.Prefix, v.Name, v.Text, v.NameColor, v.TextColor, v.Alpha)
			Lines = Lines + 1
		else
			table.remove(self.Chatbox.Chat, k)
		end
	end
end

function GM:Think()
	for k,v in pairs(self.Chatbox.Chat) do
		if(!v.Alpha) then
			v.Alpha = 255
		end
		if(self.Chatbox.Chatting) then
			if(v.Alpha != 255) then
				v.Alpha = 255
			end
			if(v.Fade) then
				v.Fade = false
			end
			v.FadeTime = CurTime() + self.Chatbox.FadeOutTime
		else
			if(v.Fade) then
				if(v.Alpha != 0) then
					v.Alpha = math.Clamp(v.Alpha - 2, 0, 255)
				end
			end
			if(!v.FadeTime) then
				v.FadeTime = CurTime() + self.Chatbox.FadeOutTime
				v.FadeAmount = 1
			end
			if(v.FadeTime <= CurTime()) then
				v.Fade = true
			end
		end
	end
	
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

function GM:PlayerBindPress(ply, bind, pressed)
	if(bind:lower():find("duck")) then
		return true
	end
	
	if(!self.Chatbox.Panel or !self.Chatbox.Panel:IsValid()) then
		self.Chatbox.Panel = vgui.Create("GM.Chatbox.Panel")
		self.Chatbox.Panel:ToggleVisible(false)
	end
	
	if(bind == "messagemode" or bind == "messagemode2") then
		self.Chatbox.Panel:SetTeamChat(LocalPlayer():IsInGame() and bind == "messagemode2")
		self.Chatbox.Panel:ToggleVisible(true)
		return true
	end
end

local function GetPlayerTrace( pl )
	
	local intersectPos = intersectRayPlane( GAMEMODE.View.origin, GAMEMODE.View.origin + GAMEMODE.View.aim * 4096, GAMEMODE.ViewOrigin, Vector( 0, 0, 1 ) )
	return intersectPos
	
end

local lastPlayerToTalk
local lastTimePlayerTalked

function GM:StartChat()
	return true
end

function GM:ChatText(Index, Name, Text, Filter)
	if(tonumber(Index) == 0) then
		self.Chatbox:AddChat(false, Text)
	end
	return true
end

function GM:OnPlayerChat(ply, Text, TeamOnly, PlayerIsDead)
	if(bTeamOnly) then
		if(ValidEntity(ply) and ValidEntity(LocalPlayer())) then
			if(ply:IsInGame() and LocalPlayer():IsInGame()) then
				if(ply:GetCPlayer():GetGame() != LocalPlayer():GetCPlayer():GetGame()) then
					return
				end
			end
		end
	end
	lastPlayerToTalk = ply
	lastTimePlayerTalked = CurTime()
	self.Chatbox:AddChat(ply, Text, TeamOnly, PlayerIsDead)
	return true
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