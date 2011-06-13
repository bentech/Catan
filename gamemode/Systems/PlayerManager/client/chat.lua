

function GM:ChatThink()

	if( not self.Chatbox ) then return end
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
	
end

function GM:ChatPaint()
	
	if( not self.Chatbox ) then return end
	
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