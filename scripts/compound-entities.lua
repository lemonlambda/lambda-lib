function lambda.register_compound_entities()
  local info = lambda.get_smuggled_data("compound-info")

  for machine, children in pairs(info) do
    log("made it here")
    lambda.on_event(lambda.defines.events.on_built, function(event)
      log("check " .. machine .. ": " .. serpent.line(event.entity.valid) .. " " ..  serpent.line(machine ~= event.entity.name))
      if not event.entity.valid or machine ~= event.entity.name then return end
      
      local position = event.entity.position

      log("even farther")

      for _, name in pairs(children) do
        log("lil guy placed down " .. name)
        
        event.entity.surface.create_entity{
          name = name,
          position = position,
          force = "player"
        }
      end
    end)

    lambda.on_event(lambda.defines.events.on_gui_openeed, function(event)

    end)
  end
end

lambda.register_compound_entities()
