gui.EnableScreenClicker( true )

GM.MouseDragging = false
GM.MouseX = 0
GM.MouseY = 0
GM.RotationDelta = 0
GM.MoveDelta = 0

local WP = vgui.GetWorldPanel()

function WP:OnCursorMoved( x, y )
	
	local dx = x - ScrW() * 0.5
	local dy = y - ScrH() * 0.5
	gamemode.Call( "GUIMouseMoved", dx, dy )
	
end

function GM:GUIMousePressed( mc )
	
	if( mc == MOUSE_RIGHT ) then
		
		if( not self.MouseDragging ) then
			
			self.MouseDragging = true
			self.MouseX = gui.MouseX()
			self.MouseY = gui.MouseY()
			gui.SetMousePos( ScrW() * 0.5, ScrH() * 0.5 )
			WP:SetCursor( "blank" )
			
		end
		
	end
	
end

function GM:RenderScreenspaceEffects()
	
	local mx, my = gui.MousePos()
	if( self.MouseDragging ) then
		
		mx, my = self.MouseX, self.MouseY
		
	end
	
	self.View.aim = gui.ScreenToVector( mx, my )
	
end

function GM:GUIMouseMoved( dx, dy )
	
	if( not self.MouseDragging ) then return end
	
	gui.SetMousePos( ScrW() * 0.5, ScrH() * 0.5 )
	
	self.RotationDelta = self.RotationDelta + dx * 0.025 * GetConVarNumber( "sensitivity" )
	self.MoveDelta = self.MoveDelta + dy * 0.075 * GetConVarNumber( "sensitivity" )
	
end

function GM:GUIMouseReleased( mc )

	if( mc == MOUSE_RIGHT ) then	
		
		if( self.MouseDragging ) then
			
			self.MouseDragging = false
			WP:SetCursor( "none" )
			
			gui.SetMousePos( self.MouseX, self.MouseY )
			
		end
		
	end
	
end

function GM:HUDShouldDraw(Name)
	
	if(Name == "CHudHealth") then
		return false
	elseif(Name == "CHudChat") then
		return false
	elseif(Name == "CHudCrosshair") then
		return false
	end
	
	return true
	
end
