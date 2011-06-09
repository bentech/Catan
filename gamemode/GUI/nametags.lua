local COLORS

function GM:PostDrawOpaqueRenderables()
	if ( PlayerColor and !COLORS ) then
		COLORS = {
			[PlayerColor.Red] = Color( 255, 0, 0 ),
			[PlayerColor.Blue] = Color( 0, 0, 255 ),
			[PlayerColor.Green] = Color( 0, 255, 0 ),
			[PlayerColor.Orange] = Color( 255, 140, 0 ),
			[PlayerColor.White] = Color( 255, 255, 255 ),
			[PlayerColor.Brown] = Color( 139, 69, 19 )
		}
	end
	if ( !COLORS ) then return end
	
	for _, ply in ipairs( player.GetAll() ) do
		if ( !ply:GetCPlayer().IsInGame or !ply:GetCPlayer():IsInGame() ) then continue end
		
		local pos, ang = ply:GetBonePosition( ply:LookupBone( "ValveBiped.Bip01_Head1" ) )
		
		cam.Start3D2D( pos + Vector( 0, 0, 12 ), Angle( 0, ang.y + 90, 90 ), 0.1 )		
			surface.SetFont( "Trebuchet24" )
			local w, h = surface.GetTextSize( ply:Nick() )
			
			local col = COLORS[ply:GetCPlayer().dt.Color] or Color( 255, 255, 100 )
			surface.SetDrawColor( col.r, col.g, col.b, 128 )
			surface.DrawRect( -w/2-5 - (h+10)/2, 0, h + 10, h + 10 )
			
			surface.SetDrawColor( 0, 0, 0, 128 )
			surface.DrawRect( -w/2-5 + (h+10)/2, 0, w + 15, h + 10 )
			
			draw.DrawText( ply:Nick(), "Trebuchet24", -w/2 + 5 + (h+10)/2, 5, Color( 255, 255, 255, 255 ) )
		cam.End3D2D()
	end
end