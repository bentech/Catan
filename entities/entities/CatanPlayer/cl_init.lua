
include("shared.lua")

function LocalCPlayer()
	
	return LocalPlayer():GetCPlayer()
	
end

function ENT:Initialize()
end


local function GetPlayerTrace( pl )
	
	local aim = gui.ScreenToVector( gui.MouseX(), gui.MouseY() )
	local intersectPos = intersectRayPlane( GAMEMODE.View.origin, GAMEMODE.View.origin + aim * 2048, GAMEMODE.ViewOrigin, Vector( 0, 0, 1 ) )
	return intersectPos
	
end
local Laser = Material( "cable/redlaser" )
function ENT:Draw()
	
	render.SetMaterial( Laser )
	render.DrawBeam( GAMEMODE.View.origin + Vector( 1, 0, 0 ), GAMEMODE.View.origin + LocalPlayer():GetCursorAimVector() * 2048, 5, 0, 0, Color( 255, 255, 255, 255 ) ) 
	
	local tracePos = GetPlayerTrace( LocalPlayer() )
	
	if( not tracePos ) then return end
	render.DrawBeam( SkyboxToWorld( LocalPlayer():EyePos() ), tracePos, 5, 0, 0, Color( 255, 255, 255, 255 ) ) 
	
end