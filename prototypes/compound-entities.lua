function lambda.compound_attach_entity_to(parent, child)
  local info = lambda.smuggle_get("compound-info")
  if not info then
    lambda.smuggle("compound-info", {})
  end

  if not info[parent] then
    info[parent] = {}
  end

  table.insert(info[parent], child)
end
