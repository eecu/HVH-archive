dmg = ui.reference("RAGE", "Aimbot", "Minimum damage")

client.set_event_callback("paint", function()
	xx, yy = client.screen_size()
	y = yy / 2
	x = xx / 2
	if entity.get_local_player() == nil or not entity.is_alive(entity.get_local_player()) then
		return
	end
	renderer.text(x+10,y-18,255,250,250,255,"C",0, ui.get(dmg))
end)
