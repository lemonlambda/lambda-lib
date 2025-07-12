local item = {}
item.__index = item

local function prechecks(attributse)
  if not attributes.name then
    error("Item has no name")
  end
end

function lambda.item(attributes)
  prechecks(attributes)

  attributes.type = "item"

  data:extend{attributes}

  return item.new(attributes.name)
end

function item.new(name)
  local new_item = setmetatable({}, icon)

  item.name = name

  return new_item
end

local recipe = {}
recipe.__index = {}

function lambda.recipe(attributes)
  prechecks(attributes)

  attributes.type = "item"

  data:extend{attributes}

  return recipe.new(attributes.name)
end

function recipe.new(name)
  local new_recipe = setmetatable({}, recipe)

  recipe.name = name

  return new_recipe
end
