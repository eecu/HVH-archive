local sv_maxusrcmdprocessticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks")
client.set_event_callback("paint", function(ctx)
ui.set_visible(sv_maxusrcmdprocessticks,true)
end)