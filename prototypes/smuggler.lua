data:extend{
  {
    type = "mod-data",
    name = "lambda-smuggled-data",
    data = {}
  }
}

function lambda.smuggle(name, data)
  data.raw["mod-data"]["lambda-smuggled-data"][name] = data
end
