
local noise = require("noise")


-- Utils
local remove_if_key = function(t, key)
  for k, e in pairs(t) do
    if e[key] then
      t[k] = nil
    end
  end
end

local remove_key = function(t, key, except)
  if except == nil then
    for _, e in pairs(t) do
      e[key] = nil
    end
  else
    for k, e in pairs(t) do
      if not except[k] then
        e[key] = nil
      end
    end
  end
end

-- Decoratives
remove_if_key(data.raw["optimized-decorative"], "autoplace")
remove_key(data.raw.turret, "spawn_decoration")
remove_key(data.raw["unit-spawner"], "spawn_decoration")
remove_key(data.raw.turret, "autoplace")
remove_key(data.raw["unit-spawner"], "autoplace")

-- Terrain
remove_key(data.raw.tile, "autoplace", { water = true, ["deep-water"] = true })

local tile = data.raw.tile["lab-dark-2"]
tile.autoplace = { probability_expression = noise.to_noise_expression(1) }
tile.map_color = {r=45,g=55,b=0}

-- Climate
data.raw["noise-expression"].cliffiness.expression = noise.to_noise_expression(0)
data.raw["noise-expression"]["temperature"].expression = noise.to_noise_expression(0)
data.raw["noise-expression"]["moisture"].expression = noise.to_noise_expression(0)

-- Trees, Rocks, Fish
remove_key(data.raw.tree, "autoplace")
remove_key(data.raw["simple-entity"], "autoplace")
data.raw["fish"].fish.autoplace = nil

-- Resources
data.raw.resource["uranium-ore"].autoplace = nil
data.raw.resource["stone"].autoplace = nil
data.raw.resource["coal"].autoplace = nil
data.raw.resource["crude-oil"].autoplace = nil
--data.raw.resource["copper-ore"].autoplace = nil

-- Remove all resources (only for performance measurement)
--remove_key(data.raw.resource, "autoplace")
-- Don't generate Water (influences resources)
--remove_key(data.raw.tile, "autoplace", {["lab-dark-2"] = true})
-- Don't compute elevation (influences water and hence resources)
--data.raw["noise-expression"].elevation.expression = noise.to_noise_expression(0)
