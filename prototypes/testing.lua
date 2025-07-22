data:extend{
  {
    type = "equipment-grid",
    name = "rocket-silo-grid",
    equipment_categories = {"rocket-silo-equipment"},
    width = 5,
    height = 5
  },
  {
    type = "equipment-category",
    name = "rocket-silo-equipment",
  },
  {
    type = "car",
    name = "rocket-silo-equipment-grid",
    equipment_grid = "rocket-silo-grid",
    hidden = true,
    minimap_representation = {
      filename = util.empty_sprite().filename,
      width = 1,
      height = 1,
    },
    weight = 1,
    braking_power = "1W",
    friction = 1,
    energy_per_hit_point = 1,
    inventory_size = 1,
    effectivity = 1,
    consumption = "1W",
    rotation_speed = 1,
    rotation_snap_angle = 1,
    energy_source = {type = "void"},
    collision_mask = {
      layers = {},
    },
  },
}

lambda.compound_attach_entity_to("rocket-silo", "rocket-silo-equipment-grid", {
  enable_gui = true,
  gui_function_name = "tank_grid",
  gui_caption = "Rocket Silo Prototype",
})
