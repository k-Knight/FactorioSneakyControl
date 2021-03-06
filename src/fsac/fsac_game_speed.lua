FSACGameSpeed = {}
FSACGameSpeed.change_speed = function(speed)
  if speed < 0.0167 then
    speed = 0.0167
  end
  if speed > 100 then
    speed = 100
  end

  global.game_speed = speed
  for _, admin in ipairs(FSACSuperAdminManager.get_all()) do
    local admin_gui = admin:get_gui()

    admin_gui.top.fsac_frame.game_speed_frame.gmspd_table1.gmspd_table1_1.game_speed_field.text = tostring(global.game_speed)
    admin_gui.top.fsac_frame.game_speed_frame.gmspd_table1.gmspd_slider.slider_value = global.game_speed
  end
  game.speed = global.game_speed
end

FSACGameSpeed.on_gui_value_changed_handler = function(event, super_index)
  if (event.element.name == "gmspd_slider") then
    event.element.slider_value = math.floor(event.element.slider_value * 10.0) / 10.0
    FSACGameSpeed.change_speed(event.element.slider_value)
  end
end

FSACGameSpeed.on_click_handler = function(event, super_index)
  local admin = FSACSuperAdminManager.get(super_index)

  if event.element.name == "gmspd_ss" then
    FSACGameSpeed.change_speed(global.game_speed - 1.0)
  elseif event.element.name == "gmspd_s" then
    FSACGameSpeed.change_speed(global.game_speed - 0.1)
  elseif event.element.name == "gmspd_f" then
    FSACGameSpeed.change_speed(global.game_speed + 0.1)
  elseif event.element.name == "gmspd_ff" then
    FSACGameSpeed.change_speed(global.game_speed + 1.0)
  elseif event.element.name == "set_game_speed" then
    local speed = tonumber(admin:get_gui().top.fsac_frame.game_speed_frame.gmspd_table1.gmspd_table1_1.game_speed_field.text)
    if speed ~= nil then
      FSACGameSpeed.change_speed(speed)
    else
      FSACSuperAdminManager.print("failed to understand the game speed number", admin.name)
    end
  elseif event.element.name == "reset_game_speed" then
    FSACGameSpeed.change_speed(1.0)
  end
end

-- ============================ GUI SCRIPT =============================

FSACGameSpeed.draw_gui = function(frame, superadmin)
  global.game_speed = game.speed

  frame.add{type = "frame", caption = "Game Speed", name = "game_speed_frame", direction = "vertical", style = "inside_deep_frame_for_tabs"}
  KMinimalistStyling.apply_style(
    frame.game_speed_frame,
    {padding = 10}
  )
  frame.game_speed_frame.add{type = "table", name = "gmspd_table1", column_count = 1}
  frame.game_speed_frame.gmspd_table1.add{type = "table", name = "gmspd_table1_1", column_count = 5}
  frame.game_speed_frame.gmspd_table1.add{type = "slider", name = "gmspd_slider", minimum_value = 0.1, maximum_value = 10, value = global.game_speed}
  KMinimalistStyling.apply_style(
    frame.game_speed_frame.gmspd_table1.gmspd_slider,
    {width_f = 203, vertical_margin = 5}
  )
  frame.game_speed_frame.gmspd_table1.add{type = "table", name = "gmspd_table1_2", column_count = 2}
  KMinimalistStyling.apply_style(
    frame.game_speed_frame.gmspd_table1.gmspd_table1_2,
    {top_margin = 5}
  )

  frame.game_speed_frame.gmspd_table1.gmspd_table1_1.add{type = "button", name = "gmspd_ss", caption = "<<", mouse_button_filter = {"left"}}
  KMinimalistStyling.apply_style(
    frame.game_speed_frame.gmspd_table1.gmspd_table1_1.gmspd_ss,
    {width_f = 30, horizontal_padding = 2}
  )
  frame.game_speed_frame.gmspd_table1.gmspd_table1_1.add{type = "button", name = "gmspd_s", caption = "<", mouse_button_filter = {"left"}}
  KMinimalistStyling.apply_style(
    frame.game_speed_frame.gmspd_table1.gmspd_table1_1.gmspd_s,
    {width_f = 25, horizontal_padding = 2}
  )
  frame.game_speed_frame.gmspd_table1.gmspd_table1_1.add{type = "textfield", name = "game_speed_field", text = tostring(global.game_speed)}
  KMinimalistStyling.apply_style(
    frame.game_speed_frame.gmspd_table1.gmspd_table1_1.game_speed_field,
    {width_f = 77}
  )
  frame.game_speed_frame.gmspd_table1.gmspd_table1_1.add{type = "button", name = "gmspd_f", caption = ">", mouse_button_filter = {"left"}}
  KMinimalistStyling.apply_style(
    frame.game_speed_frame.gmspd_table1.gmspd_table1_1.gmspd_f,
    {width_f = 25, horizontal_padding = 2}
  )
  frame.game_speed_frame.gmspd_table1.gmspd_table1_1.add{type = "button", name = "gmspd_ff", caption = ">>", mouse_button_filter = {"left"}}
  KMinimalistStyling.apply_style(
    frame.game_speed_frame.gmspd_table1.gmspd_table1_1.gmspd_ff,
    {width_f = 30, horizontal_padding = 2}
  )

  frame.game_speed_frame.gmspd_table1.gmspd_table1_2.add{type = "button", name="set_game_speed", caption = "Set", mouse_button_filter = {"left"}}
  KMinimalistStyling.apply_style(
    frame.game_speed_frame.gmspd_table1.gmspd_table1_2.set_game_speed,
    {width_f = 95, right_margin = 9}
  )
  frame.game_speed_frame.gmspd_table1.gmspd_table1_2.add{type = "button", name="reset_game_speed", caption = "Reset", mouse_button_filter = {"left"}}
  KMinimalistStyling.apply_style(
    frame.game_speed_frame.gmspd_table1.gmspd_table1_2.reset_game_speed,
    {width_f = 95}
  )
end