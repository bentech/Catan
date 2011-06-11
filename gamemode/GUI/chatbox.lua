------------------------------
-- Adapted from STBase
--  for Settlers of GMod
-- By Spacetech
------------------------------
-- STChatBox v2.7
------------------------------

TAG_ALL = surface.GetTextureID("sog/tag_all")
TAG_GAME = surface.GetTextureID("sog/tag_game")

GM.Chatbox = {}
GM.Chatbox.Chat = {}
GM.Chatbox.ChatFont = "SOG.ChatFont"
GM.Chatbox.ChatLabelDefault = "Chat"
GM.Chatbox.ChatLabel = GM.Chatbox.ChatLabelDefault

GM.Chatbox.MaxLines = 10
GM.Chatbox.FadeOutTime = 10

GM.Chatbox.XOrigin = 80
GM.Chatbox.YOrigin = ScrH() - 145

GM.Chatbox.ColorChat = Color(255, 255, 255, 255)
GM.Chatbox.ColorConsole = Color(217, 0, 25, 255)

GM.Chatbox.TeamPrefixColor = Color(0, 255, 0, 255)

surface.CreateFont("Tahoma", 16, 1000, true, false, GM.Chatbox.ChatFont) 

function GM.Chatbox:AddChatManual(ply, Name, Text, NameColor, TextColor, Prefix, Time, TeamOnly)
	table.insert(self.Chat, {
		Prefix = Prefix,
		Name = Name,
		Text = Text,
		NameColor = NameColor,
		TextColor = TextColor,
		Time = Time or os.clock()
	})
	if(ply) then
		if(ply:Team() == TEAM_SPEC) then
			NameColor = color_white
		end
		if(TeamOnly) then
			chat.AddText(self.TeamPrefixColor, "(GAME) ", NameColor, Name, color_white, ": ", TextColor, Text)
		else
			chat.AddText(color_white, "(ALL) ", NameColor, Name, color_white, ": ", TextColor, Text)
		end
	else
		if(Name and NameColor) then
			chat.AddText(NameColor, Name, color_white, ": ", TextColor, Text)
		else
			chat.AddText(TextColor, Text)
		end
	end
end

function GM.Chatbox:AddChat(ply, Text, TeamOnly, PlayerIsDead)
	if(string.Trim(Text) == "") then
		return
	end
	if(ValidEntity(ply)) then
		local Prefix = TAG_ALL
		if(TeamOnly) then
			Prefix = TAG_GAME
		end
		self:AddChatManual(ply, ply:Name(), Text, team.GetColor(ply:Team()), self.ColorChat, Prefix, nil, TeamOnly)
	else
		if(string.find(string.lower(Text), "connected", 1, true) or string.find(string.lower(Text), "dropped", 1, true)) then
			return
		end
		if(string.find(string.lower(Text), "joined the game", 1, true) or string.find(string.lower(Text), "left the game", 1, true)) then
			return
		end
		self:AddChatManual(nil, nil, Text, nil, self.ColorConsole)
	end
end

function GM.Chatbox:GetTopY()
	if(!self.CacheTopY) then
		surface.SetFont(self.ChatFont)
		self.CacheTopY = GM.Chatbox.YOrigin - (select(2, surface.GetTextSize(" ")) * GM.Chatbox.MaxLines)
	end
	return self.CacheTopY
end

function GM.Chatbox:DrawText(X, Y, Red, Green, Blue, Alpha, Text)
	surface.SetTextPos(X + 1, Y + 1)
	surface.SetTextColor(0, 0, 0, Alpha)
	surface.DrawText(Text)
	surface.SetTextPos(X, Y)
	surface.SetTextColor(Red, Green, Blue, Alpha)
	surface.DrawText(Text)
end

function GM.Chatbox:DrawLine(X, Y, Prefix, Name, Text, NameColor, TextColor, Alpha)
	local TWidth, THeight = surface.GetTextSize(Text)
	
	if(Name) then
		if(Prefix) then
			surface.SetDrawColor(255, 255, 255, Alpha)
			surface.SetTexture(Prefix)
			surface.DrawTexturedRect(X - 36, Y + 1, 32, 16)
		end
		
		Name = Name..": "
		self:DrawText(X, Y, NameColor.r, NameColor.g, NameColor.b, Alpha, Name)
		
		X = X + select(1, surface.GetTextSize(Name))
	end
	
	self:DrawText(X, Y, TextColor.r, TextColor.g, TextColor.b, Alpha, Text)
	
	return Y - THeight
end

local PANEL = {}

function PANEL:Init()
	self.Bool = true
	
	self:SetZPos(-1000)
	
	self:SetPos(40, ScrH() - 125)
	
    self:SetSize(ScrW() * 0.4, 22)
	
	local X = 5
	
	self.ChatLabel = vgui.Create("DLabel", self)
	self.ChatLabel:SetPos(X, 3)
	self.ChatLabel:SetFont(GAMEMODE.Chatbox.ChatFont)
	self.ChatLabel:SetText(GAMEMODE.Chatbox.ChatLabelDefault)
	
	self.ChatLabel:SizeToContents()
	
	X = X + self.ChatLabel:GetWide()
	
	self.TextEntry = vgui.Create("DTextEntry", self)
	self.TextEntry:SetPos(X, 2)
	self.TextEntry:SetSize(self:GetWide() - X - 3, self:GetTall() - 3)
	self.TextEntry.OnKeyCodeTyped = function(TextEntry, Code)
		local Text = TextEntry:GetValue()
		if(Code == KEY_ENTER) then
			if(Text and Text != "") then
				if(GAMEMODE.Chatbox.ChatLabel == "Command") then
					Text = "/"..Text
				end
				if(GAMEMODE.Chatbox.ChatLabel == "Game") then
					RunConsoleCommand("say_team", Text)
				else
					RunConsoleCommand("say", Text)
				end
			end
			self:ToggleVisible(false)
		elseif(Code == KEY_BACKSPACE) then
			if(GAMEMODE.Chatbox.ChatLabel != GAMEMODE.Chatbox.ChatLabelDefault and TextEntry:GetCaretPos() == 0) then
				GAMEMODE.Chatbox.ChatLabel = GAMEMODE.Chatbox.ChatLabelDefault
				TextEntry:OnTextChanged()
			elseif(Text == "") then
				self:OnKeyCodePressed(KEY_ESCAPE)
				return true
			end
		elseif(Code == KEY_TAB) then
			TextEntry:SetCaretPos(TextEntry:GetCaretPos())
			//Sassafrass
			-- self:CompleteName(TextEntry:GetValue(), TextEntry:GetCaretPos())
			return true
		elseif(Code == KEY_ESCAPE) then
			self:OnKeyCodePressed(Code)
			return true
		end
	end
	self.TextEntry.OnTextChanged = function(TextEntry)
		self:OnChatChange(TextEntry:GetValue())
	end
end

function PANEL:CalcResize()
	self.ChatLabel:SizeToContents()
	self.TextEntry:MoveRightOf(self.ChatLabel)
	self.TextEntry:SetWide(self:GetWide() - self.ChatLabel:GetWide() - 8)
end

function PANEL:OnChatChange(Text)
	local Sub = string.sub(string.Trim(Text), 1, 1)
	local ChatLabel = GAMEMODE.Chatbox.ChatLabel
	if(Sub == "/") then
		GAMEMODE.Chatbox.ChatLabel = "Command"
	end
	if(GAMEMODE.Chatbox.ChatLabel != self.ChatLabel.ChatLabel) then
		self.ChatLabel.ChatLabel = GAMEMODE.Chatbox.ChatLabel
		self.ChatLabel:SetText(GAMEMODE.Chatbox.ChatLabel..": ")
		self.TextEntry:SetText("")
		self:CalcResize()
	end
end

function PANEL:CompleteName(Text, Pos)
	local reverse = Text:reverse();
	local startIndex = Text:len() - (reverse:find(" ", Text:len()-Pos+1) or Text:len()+1) + 2;
	local str = Text:sub( startIndex, Text:find(" ", Pos) );
	local pl = FindByPartial( str )
	if( ValidEntity(pl) ) then
		local leftStr = Text:sub( 0, startIndex-1 )
		local rightStr = Text:sub( Text:find( " ", startIndex ) or Text:len()+1 )
		self.TextEntry:SetText( leftStr .. pl:Name() .. rightStr )
		self.TextEntry:SetCaretPos( (leftStr..pl:Name()):len() )
	end
end

function PANEL:SetInput(Text)
	self.TextEntry:SetText(Text)
	self.TextEntry:SetCaretPos(string.len(Text))
end

function PANEL:SetTeamChat(TeamOnly)
	self.TeamOnly = TeamOnly
end

function PANEL:ToggleVisible(Bool)
	if(self.Bool == Bool) then
		return
	end
	
	self.Bool = Bool
	GAMEMODE.Chatbox.Chatting = Bool
	
	if(self.TeamOnly) then
		GAMEMODE.Chatbox.ChatLabel = "Game"
	else
		GAMEMODE.Chatbox.ChatLabel = GAMEMODE.Chatbox.ChatLabelDefault
	end
	
	self:OnChatChange("")
	
	if(Bool) then
		if(GAMEMODE.Chatbox.Remembered and GAMEMODE.Chatbox.Remembered == 2) then
			RestoreCursorPosition()
		end
	else
		if(!GAMEMODE.Chatbox.Remembered) then
			GAMEMODE.Chatbox.Remembered = 1
		elseif(GAMEMODE.Chatbox.Remembered == 1) then
			GAMEMODE.Chatbox.Remembered = 2
		end
		RememberCursorPosition()
	end
	
	self:SetKeyboardInputEnabled(Bool)
	self:SetMouseInputEnabled(Bool)
	
	self:SetVisible(Bool)
	
	if(Bool) then
		self:MakePopup()
		self:SetFocusTopLevel(true)
		self.TextEntry:RequestFocus()
	else
		self.TextEntry:SetText("")
	end
end

function PANEL:OnKeyCodePressed(Code)
	if(Code == KEY_ESCAPE) then
		self:ToggleVisible(false)
	end
end

function PANEL:Paint()
	draw.RoundedBox(4, 0, 0, self.ChatLabel:GetWide() + 6, self:GetTall(), Color(0, 0, 0, 200))
end

vgui.Register("GM.Chatbox.Panel", PANEL, "EditablePanel")

usermessage.Hook("GM.Chatbox.AddChat", function(um)
	local ply = um:ReadEntity()
	local Text = um:ReadString()
	local Col = um:ReadVector()
	
	if(!ValidEntity(ply)) then
		return
	end
	
	local NameColor = team.GetColor(ply:Team())
	local TextColor = Color(Col.x, Col.y, Col.z, 255)
	
	GM.Chatbox:AddChatManual(ply, ply:Name(), Text, NameColor, TextColor, ply:GetRank())
end)

usermessage.Hook("GM.Chatbox.AddCustomChat", function(um)
	local Name = um:ReadString()
	local Text = um:ReadString()
	local NameColor = um:ReadVector()
	local TextColor = um:ReadVector()
	
	NameColor = Color(NameColor.x, NameColor.y, NameColor.z, 255)
	TextColor = Color(TextColor.x, TextColor.y, TextColor.z, 255)
	
	GM.Chatbox:AddChatManual(nil, Name, Text, NameColor, TextColor, "guest")
end)

usermessage.Hook("GM.Chatbox.ConsoleMessage", function(um)
	local Text = um:ReadString()
	local Col = um:ReadVector()
	chat.AddText(Color(Col.x, Col.y, Col.z, 255), Text)
end)
