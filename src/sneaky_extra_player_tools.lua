-- =======================================================================
-- ======================== EXTRA FUNCTIONALITY ==========================
-- =======================================================================
-- =========================== Player Tools ==============================
-- =======================================================================



SneakyExtrasPlayerTools = {}
SneakyExtrasPlayerTools.update_values = function(player)
  if player ~= nil then
    for _, admin in ipairs(SneakySuperAdminManager.get_all()) do
      if admin.extras.player_tools ~= nil then
        if admin.extras.player_tools.parent_frame ~= nil then
          admin.extras.player_tools.parent_frame.ex_pt_flow_2.ex_pt_cheat_checkbox.state = player.cheat_mode
          if player.character ~= nil then
            admin.extras.player_tools.parent_frame.ex_pt_flow_5.ex_pt_craft_slider.slider_value = player.character_crafting_speed_modifier
            admin.extras.player_tools.parent_frame.ex_pt_flow_6.ex_pt_mine_slider.slider_value = player.character_mining_speed_modifier
            admin.extras.player_tools.parent_frame.ex_pt_flow_7.ex_pt_run_slider.slider_value = player.character_running_speed_modifier
          end
        end
      end
    end
  end
end

SneakyExtrasPlayerTools.clear_armor = function(player)
  local p_armor = player.get_inventory(defines.inventory.player_armor)[1]
  if p_armor ~= nil then
    p_armor.clear()
  end
end

SneakyExtrasPlayerTools.delete_all_armor = function(player)
  SneakyExtrasPlayerTools.clear_armor(player)
  player.get_main_inventory().remove({name="power-armor-mk2", count = 4294967294})
  player.get_main_inventory().remove({name="power-armor", count = 4294967294})
  player.get_main_inventory().remove({name="modular-armor", count = 4294967294})
  player.get_main_inventory().remove({name="heavy-armor", count = 4294967294})
  player.get_main_inventory().remove({name="light-armor", count = 4294967294})
end

SneakyExtrasPlayerTools.give_op_armor = function(player)
  player.insert{name="power-armor-mk2", count = 1}
  local p_armor = player.get_inventory(defines.inventory.player_armor)[1].grid
  p_armor.put({name = "fusion-reactor-equipment"})
  p_armor.put({name = "fusion-reactor-equipment"})
  p_armor.put({name = "exoskeleton-equipment"})
  p_armor.put({name = "exoskeleton-equipment"})
  p_armor.put({name = "exoskeleton-equipment"})
  p_armor.put({name = "exoskeleton-equipment"})
  p_armor.put({name = "exoskeleton-equipment"})
  p_armor.put({name = "energy-shield-mk2-equipment"})
  p_armor.put({name = "energy-shield-mk2-equipment"})
  p_armor.put({name = "energy-shield-mk2-equipment"})
  p_armor.put({name = "energy-shield-mk2-equipment"})
  p_armor.put({name = "personal-roboport-mk2-equipment"})
  p_armor.put({name = "night-vision-equipment"})
  p_armor.put({name = "battery-mk2-equipment"})
  p_armor.put({name = "battery-mk2-equipment"})
end

SneakyExtrasPlayerTools.on_click_handler = function(event, superadmin)
  if superadmin.extras.player_tools == nil then
    return
  end
  local player = game.players[superadmin.extras.player_tools.player_name]
  if player == nil then
    return
  end

  if event.element.name == "ex_pt_kill" then
    if player.character ~= nil then
      player.character.die(player.force)
      SneakyExtrasPlayerTools.update_values(player)
    end
  elseif event.element.name == "ex_pt_kill_long" then
    if player.character ~= nil then
      player.character.die(player.force)
      SneakyExtrasPlayerTools.update_values(player)
    end
    player.ticks_to_respawn = 4294967294 -- max possible cooldown
  elseif event.element.name == "ex_pt_resurrect" then
    if player.character == nil then
      player.ticks_to_respawn = 1
    end
  elseif event.element.name == "ex_pt_give_armor" then
    SneakyExtrasPlayerTools.clear_armor(player)
    SneakyExtrasPlayerTools.give_op_armor(player)
  elseif event.element.name == "ex_pt_rm_armor" then
    SneakyExtrasPlayerTools.clear_armor(player)
  elseif event.element.name == "ex_pt_rm_all_armor" then
    SneakyExtrasPlayerTools.delete_all_armor(player)
  end
end

SneakyExtrasPlayerTools.on_select_handler = function(event, superadmin)
  if superadmin.extras.player_tools == nil then
    return
  end

  if event.element.name == "ex_pt_dropdown" then
    superadmin.extras.player_tools.player_name = event.element.items[event.element.selected_index]
    SneakyExtrasPlayerTools.update_values(game.players[superadmin.extras.player_tools.player_name])
  end
end

SneakyExtrasPlayerTools.on_checked_handler = function(event, superadmin)
  if superadmin.extras.player_tools == nil then
    return
  end
  local player = game.players[superadmin.extras.player_tools.player_name]
  if player == nil then
    return
  end

  if event.element.name == "ex_pt_cheat_checkbox" then
    player.cheat_mode = not player.cheat_mode
    for _, admin in ipairs(SneakySuperAdminManager.get_all()) do
      if superadmin.extras.player_tools ~= nil then
        if superadmin.extras.player_tools.parent_frame ~= nil then
          admin.extras.player_tools.parent_frame.ex_pt_flow_2.ex_pt_cheat_checkbox.state = player.cheat_mode
        end
      end
    end
  end
end

SneakyExtrasPlayerTools.on_value_handler = function(event, superadmin)
  if superadmin.extras.player_tools == nil then
    return
  end
  local player = game.players[superadmin.extras.player_tools.player_name]
  if player == nil then
    return
  end

  if player.character ~= nil then
    if event.element.name == "ex_pt_craft_slider" then
      player.character_crafting_speed_modifier = event.element.slider_value
    elseif event.element.name == "ex_pt_mine_slider" then
      player.character_mining_speed_modifier = event.element.slider_value
    elseif event.element.name == "ex_pt_run_slider" then
      player.character_running_speed_modifier = event.element.slider_value
    end
  end
end



-- =======================================================================
-- ============================= GUI SCRIPT ==============================
-- =======================================================================



SneakyExtrasPlayerTools.draw = function(frame, superadmin)
  if superadmin.extras.player_tools == nil then
    superadmin.extras.player_tools = {}
  end
  superadmin.extras.player_tools.parent_frame = frame

  frame.add{type = "flow", name="ex_pt_flow_1", direction="horizontal"}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_1,
    {
      margin = {horizontal = 5, top = 10},
      spacing = {horizontal = 8}
    }
  )

  frame.ex_pt_flow_1.add{type = "label", name="ex_pt_select_label", caption = "Select a player: "}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_1.ex_pt_select_label,
    {
      size = {width = 332},
      padding = 0,
      margin = 0
    }
  )

  local players_names = SneakyScript.get_player_names()
  frame.ex_pt_flow_1.add{type = "drop-down", name = "ex_pt_dropdown", selected_index = 1, items = players_names}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_1.ex_pt_dropdown,
    {size = {width = 400}}
  )
  superadmin.extras.player_tools.player_name = players_names[1]

  frame.add{type = "flow", name="ex_pt_flow_2", direction="horizontal"}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_2,
    {
      margin = {horizontal = 5, top = 30},
      spacing = {horizontal = 8}
    }
  )

  frame.ex_pt_flow_2.add{type = "label", name="ex_pt_cheat_label", caption = "Enable cheat mode: "}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_2.ex_pt_cheat_label,
    {
      size = {width = 712},
      padding = 0,
      margin = 0
    }
  )
  frame.ex_pt_flow_2.add{type = "checkbox", name="ex_pt_cheat_checkbox", caption = "", state = game.players[superadmin.extras.player_tools.player_name].cheat_mode}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_2.ex_pt_cheat_checkbox,
    {
      size = {height = 20, width = 20},
      margin = 0
    }
  )

  frame.add{type = "flow", name="ex_pt_flow_3", direction="horizontal"}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_3,
    {
      margin = {horizontal = 5, top = 5},
      spacing = {horizontal = 8}
    }
  )

  frame.ex_pt_flow_3.add{type = "label", name="ex_pt_kill_label", caption = "Kill player: "}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_3.ex_pt_kill_label,
    {
      size = {width = 454},
      padding = 0,
      margin = 0
    }
  )
  frame.ex_pt_flow_3.add{type = "button", name="ex_pt_kill", caption = "Kill", mouse_button_filter = {"left"}}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_3.ex_pt_kill,
    {
      size = {width = 135},
      margin = 0
    }
  )
  frame.ex_pt_flow_3.add{type = "button", name="ex_pt_kill_long", caption = "Kill Forever", mouse_button_filter = {"left"}}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_3.ex_pt_kill_long,
    {
      size = {width = 135},
      margin = 0
    }
  )

  frame.add{type = "flow", name="ex_pt_flow_4", direction="horizontal"}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_4,
    {
      margin = {horizontal = 5, top = 5},
      spacing = {horizontal = 8}
    }
  )

  frame.ex_pt_flow_4.add{type = "label", name="ex_pt_resurrect_label", caption = "Resurrect player: "}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_4.ex_pt_resurrect_label,
    {
      size = {width = 597},
      padding = 0,
      margin = 0
    }
  )
  frame.ex_pt_flow_4.add{type = "button", name="ex_pt_resurrect", caption = "Resurrect", mouse_button_filter = {"left"}}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_4.ex_pt_resurrect,
    {
      size = {width = 135},
      margin = 0
    }
  )

  frame.add{type = "flow", name="ex_pt_flow_5", direction="horizontal"}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_5,
    {
      margin = {horizontal = 5, top = 5},
      spacing = {horizontal = 8}
    }
  )

  frame.ex_pt_flow_5.add{type = "label", name="ex_pt_craft_label", caption = "Crafting speed modifier: "}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_5.ex_pt_craft_label,
    {
      size = {width = 332},
      padding = 0,
      margin = 0
    }
  )
  frame.ex_pt_flow_5.add{type = "slider", name="ex_pt_craft_slider", minimum_value = 0.0, maximum_value = 200.0, value = game.players[superadmin.extras.player_tools.player_name].character_crafting_speed_modifier}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_5.ex_pt_craft_slider,
    {
      size = {width = 400},
      margin = 0
    }
  )

  frame.add{type = "flow", name="ex_pt_flow_6", direction="horizontal"}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_6,
    {
      margin = {horizontal = 5, top = 5},
      spacing = {horizontal = 8}
    }
  )

  frame.ex_pt_flow_6.add{type = "label", name="ex_pt_mine_label", caption = "Mining speed modifier: "}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_6.ex_pt_mine_label,
    {
      size = {width = 332},
      padding = 0,
      margin = 0
    }
  )
  frame.ex_pt_flow_6.add{type = "slider", name="ex_pt_mine_slider", minimum_value = 0.0, maximum_value = 100.0, value = game.players[superadmin.extras.player_tools.player_name].character_mining_speed_modifier}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_6.ex_pt_mine_slider,
    {
      size = {width = 400},
      margin = 0
    }
  )

  frame.add{type = "flow", name="ex_pt_flow_7", direction="horizontal"}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_7,
    {
      margin = {horizontal = 5, top = 5},
      spacing = {horizontal = 8}
    }
  )

  frame.ex_pt_flow_7.add{type = "label", name="ex_pt_run_label", caption = "Running speed modifier: "}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_7.ex_pt_run_label,
    {
      size = {width = 332},
      padding = 0,
      margin = 0
    }
  )
  frame.ex_pt_flow_7.add{type = "slider", name="ex_pt_run_slider", minimum_value = 0.0, maximum_value = 50.0, value = game.players[superadmin.extras.player_tools.player_name].character_running_speed_modifier}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_7.ex_pt_run_slider,
    {
      size = {width = 400},
      margin = 0
    }
  )

  frame.add{type = "flow", name="ex_pt_flow_8", direction="horizontal"}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_8,
    {
      margin = {horizontal = 5, top = 5, bottom = 10},
      spacing = {horizontal = 8}
    }
  )

  frame.ex_pt_flow_8.add{type = "label", name="ex_pt_eq_label", caption = "Equipment manipulation: "}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_8.ex_pt_eq_label,
    {
      size = {width = 311},
      padding = 0,
      margin = 0
    }
  )
  frame.ex_pt_flow_8.add{type = "button", name="ex_pt_give_armor", caption = "Give OP Armor", mouse_button_filter = {"left"}}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_8.ex_pt_give_armor,
    {
      size = {width = 135},
      margin = 0
    }
  )
  frame.ex_pt_flow_8.add{type = "button", name="ex_pt_rm_armor", caption = "Remove Armor", mouse_button_filter = {"left"}}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_8.ex_pt_rm_armor,
    {
      size = {width = 135},
      margin = 0
    }
  )
  frame.ex_pt_flow_8.add{type = "button", name="ex_pt_rm_all_armor", caption = "Remove All Armor", mouse_button_filter = {"left"}}
  SneakyStyling.apply_simple_style(
    frame.ex_pt_flow_8.ex_pt_rm_all_armor,
    {
      size = {width = 135},
      margin = 0
    }
  )
end