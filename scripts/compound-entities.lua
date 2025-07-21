lambda.on_event(lambda.defines.events.on_init, function()
  if not storage.lambda_compound_entity_pairs then
    storage.lambda_compound_entity_pairs = {}
  end
end)

function lambda.register_compound_entities()
  local info = lambda.get_smuggled_data("compound-info")

  for machine, children in pairs(info) do
    lambda.on_event(lambda.defines.events.on_built, function(event)
      if not event.entity.valid or machine ~= event.entity.name then return end
      
      local position = event.entity.position

      storage.lambda_compound_entity_pairs[event.entity.unit_number] = {}

      for _, info in pairs(children) do
        local new_position = position
        -- game.print(serpent.line(info.position_offset))
        if info.position_offset then
          new_position = {
            x = (position[1] or position.x) + (info.position_offset[1] or info.position_offset.x),
            y = (position[2] or position.y) + (info.position_offset[2] or info.position_offset.y)
          }
          -- game.print(serpent.line(position) .. " vs. " .. serpent.line(new_position))
        end
        
        local new_entity = event.entity.surface.create_entity{
          name = info.child,
          position = new_position,
          force = "player"
        }

        storage.lambda_compound_entity_pairs[event.entity.unit_number][new_entity.unit_number] = new_entity
      end
    end)

    lambda.on_event(lambda.defines.events.on_removed, function(event)
      if not event.entity.valid or machine ~= event.entity.name then return end

      -- Check if the thing exists
      if not storage.lambda_compound_entity_pairs[event.entity.unit_number] then
        return
      end

      for _, child in pairs(storage.lambda_compound_entity_pairs[event.entity.unit_number]) do
        if child and child.valid then
          child.destroy()
        end

        child = nil
      end
    end)

    lambda.on_event(lambda.defines.events.on_gui_opened, function(event)
      if not event.entity or not event.entity.valid or not machine == event.entity.name then return end
      
      local player = game.players[event.player_index]
      local entity = event.entity

      if player.gui.relative["compound-entity-children"] then
        player.gui.relative["compound-entity-children"].destroy()
      end
      if not storage.lambda_compound_entity_pairs[event.entity.unit_number] then
        return
      end
      local root = player.gui.relative.add{
        type = "frame",
        name = "compound-entity-children",
        caption = "Children",
        direction = "vertical",
        anchor = {
          gui = defines.relative_gui_type.assembling_machine_gui,
          position = defines.relative_gui_position.right
        },
      }


      for _, info in pairs(storage.lambda_compound_entity_pairs[event.entity.unit_number]) do
        root.add{
          type = "button",
          name = "open-compound-entity-child-" .. info.unit_number,
          caption = {"", "Open ", {"entity-name." .. info.name}, " gui"},
          tags = {
            unit_number = entity.unit_number,
            child_unit_number = info.unit_number,
          },
        }
      end
      
      return
    end)

    script.on_event(defines.events.on_gui_click, function(event)
      local player = game.players[event.player_index]
      if not ((string.find(event.element.name, "open-compound-entity-child", 1, true) or -1) >= 0) then return end
      if not storage.lambda_compound_entity_pairs[event.element.tags.unit_number] then return end

      player.opened = storage.lambda_compound_entity_pairs[event.element.tags.unit_number][event.element.tags.child_unit_number]
    end)
  end
end

lambda.register_compound_entities()
