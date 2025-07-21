lambda._events = {
  ["on_init"] = {},
  ["on_built"] = {},
  ["on_removed"] = {},
  ["on_gui_opened"] = {},
}

lambda._event_match = {
  ["on_init"] = {},
  ["on_built"] = {
    defines.events.on_built_entity,
    defines.events.on_robot_built_entity,
    defines.events.on_entity_cloned,
    defines.events.script_raised_built,
    defines.events.script_raised_revive,
  },
  ["on_removed"] = {
    defines.events.on_player_mined_entity,
    defines.events.on_robot_mined_entity,
    defines.events.on_entity_died,
    defines.events.script_raised_destroy
  },
  ["on_gui_opened"] = {
    defines.events.on_gui_opened,
  },
}

if not lambda.defines then lambda.defines = {} end

lambda.defines.events = {
  on_init = "on_init",
  on_built = "on_built",
  on_removed = "on_removed",
  on_gui_opened = "on_gui_opened",
}

function lambda.on_event(event_name, func)
  table.insert(lambda._events[event_name], func)
end

local function add_handler(event_name)
  if event_name == "on_init" then
    script.on_init(function()
      for _, func in pairs(lambda._events[event_name]) do
        func(event)
      end
    end)
    return
  end
  
  for _, event_definition in pairs(lambda._event_match[event_name]) do
    script.on_event(event_definition, function(event)
      if lambda._events[event_name] ~= nil then
        for _, func in pairs(lambda._events[event_name]) do
          func(event)
        end
      end
    end)
  end
end

add_handler(lambda.defines.events.on_built)
add_handler(lambda.defines.events.on_removed)
add_handler(lambda.defines.events.on_gui_opened)
add_handler(lambda.defines.events.on_init)
