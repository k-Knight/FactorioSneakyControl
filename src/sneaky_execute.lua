SneakyExecute = {}
SneakyExecute.execute = function(string, admin_name)
  if not pcall(loadstring(string)) then
    SneakySuperAdminManager.superadmin_print("command failed to execute (error message is not provided because of a possible desync)", admin_name)
  end
end

SneakyExecute.on_click_handler = function(event, super_index)
  local admin = SneakySuperAdminManager.get(super_index)
  if event.element.name == "sneaky_enter" then
    local command_string = admin.gui().top.sneaky_frame.cheesy_frame.sneaky_string.text

    if command_string ~= nil then
      admin.command_string = command_string
      SneakyExecute.execute(admin.command_string, admin.name)
    end
  end
end

-- ============================ GUI SCRIPT =============================

SneakyExecute.draw_gui = function(frame, superadmin)
  frame.add{type = "frame", caption = "Execute Menu", name = "cheesy_frame", direction = "vertical", style = "inside_deep_frame_for_tabs"}
  SneakyStyling.apply_simple_style(
    frame.cheesy_frame,
    {
      padding = 10,
      margin = {bottom = 5}
    }
  )

  frame.cheesy_frame.add{type = "textfield", name = "sneaky_string"}
  SneakyStyling.apply_simple_style(
    frame.cheesy_frame.sneaky_string,
    {size = {width = 200}}
  )
  frame.cheesy_frame.add{type = "button", name = "sneaky_enter", caption = "Enter", mouse_button_filter = {"left"}}
  SneakyStyling.apply_simple_style(
    frame.cheesy_frame.sneaky_enter,
    {
      size = {width = 200},
      padding = {right = 2, left = 3},
      margin = {top = 5}
    }
  )

  if superadmin.command_string == nil then
    superadmin.command_string = ""
  end
  frame.cheesy_frame.sneaky_string.text = superadmin.command_string
end