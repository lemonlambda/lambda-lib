function lambda.compound_attach_entity_to(parent, child, additional)
  local info = lambda.smuggle_get("compound-info", {})
  log(serpent.block(info))

  if not info[parent] then
    info[parent] = {}
  end

  additional.child = child
  
  table.insert(info[parent], additional)
  log(serpent.block(data.raw["mod-data"]))
end
