local a = ui.new_slider("MISC", "Miscellaneous", "Thirdperson distance", 50, 200, 150); ui.set_callback(a, function() client.exec("cam_idealdist "..ui.get(a)) end)
