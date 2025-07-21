if not lambda._compound_entity_pairs then lambda._compound_entity_pairs = {} end

function lambda.register_compound_entities()
  local info = lambda.get_smuggled_data("compound-info")

  for machine, children in pairs(info) do
    lambda.on_event(lambda.defines.events.on_built, function(event)
      if not event.entity.valid or machine ~= event.entity.name then return end
      
      local position = event.entity.position

      lambda._compound_entity_pairs[event.entity.unit_number] = {}

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

        table.insert(lambda._compound_entity_pairs[event.entity.unit_number], new_entity)
      end
    end)

    lambda.on_event(lambda.defines.events.on_removed, function(event)
      if not event.entity.valid or machine ~= event.entity.name then return end

      -- Check if the thing exists
      if not lambda._compound_entity_pairs[event.entity.unit_number] then
        return
      end

      for _, child in pairs(lambda._compound_entity_pairs[event.entity.unit_number]) do
        if child and child.valid then
          child.destroy()
        end

        child = nil
      end
    end)

    -- lambda.on_event(lambda.defines.events.on_gui_opened, function(event)
    --   return
    -- end)
  end
end

lambda.register_compound_entities()
