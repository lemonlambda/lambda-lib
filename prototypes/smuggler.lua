data:extend{
  {
    type = "mod-data",
    name = "lambda-smuggled-data",
    data = {}
  }
}

function lambda.smuggle(name, to_smuggle)
  data.raw["mod-data"]["lambda-smuggled-data"].data[name] = to_smuggle
end

function lambda.smuggle_get(name, nil_value)
  if data.raw["mod-data"]["lambda-smuggled-data"].data[name] == nil then
    lambda.smuggle(name, nil_value)
  end
  
  return data.raw["mod-data"]["lambda-smuggled-data"].data[name]
end
