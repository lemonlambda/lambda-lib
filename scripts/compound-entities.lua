lambda._events = {
  ["on_built"] = {},
  ["on_removed"] = {}
}

lambda._event_match = {
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
  }
}

if not lambda.defines then lambda.defines = {} end

lambda.defines.events = {
  on_built = "on_built",
  on_removed = "on_removed"
}

function lambda.on_event(event_name, func)
  table.insert(lambda._events[event_name], func)
end

local function add_handler(event_name)
  log(event_name)
  for _, event_definition in pairs(lambda._event_match[event_name]) do
    script.on_event(event_definition, function(event)
      for _, func in pairs(lambda._events[event_name]) do
        func(event)
      end
    end)
  end
end

add_handler(lambda.defines.events.on_built)
add_handler(lambda.defines.events.on_removed)
