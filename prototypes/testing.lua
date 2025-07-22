lambda.compound_attach_entity_to("assembling-machine-1", "beacon", {
  position_offset = {-1, 0},
  enable_gui = true,
})
lambda.compound_attach_entity_to("assembling-machine-1", "tank", {
  position_offset = {1, 0},
  enable_gui = true,
  gui_function_name = "tank_grid",
})
