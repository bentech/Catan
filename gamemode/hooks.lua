function GM:InitPostEntity()
	
	self.skycam = ents.FindByClass( "sky_camera" )[1]
	self.skycampos = self.skycam:GetPos()
	self:InitSkybox()
	
end

function GM:Think()

end