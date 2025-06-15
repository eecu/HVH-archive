local enable = ui.new_checkbox('MISC', 'Settings', 'Fast Switch')

client.set_event_callback('grenade_thrown', function(e)
  if ui.get(enable) then
    local lp = entity.get_local_player();
    local userid = client.userid_to_entindex(e.userid);
  
    if userid ~= lp then
      return
    end
  
    client.exec('slot3; slot2; slot1');
  end
end);

client.set_event_callback('weapon_fire', function(e)
  if ui.get(enable) then
    if e.weapon ~= 'weapon_taser' then
      return
    end

    local lp = entity.get_local_player();
    local userid = client.userid_to_entindex(e.userid);

    if userid ~= lp then
      return
    end
  
    client.exec('slot3; slot2; slot1');
  end
end);