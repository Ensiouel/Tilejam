local tilejam = require "tilejam"

local map, tileset = tilejam:newTilemap("map.lua")

map = love.graphics.newImage(map)

function love.load()

end

function love.update(dt)
  -- map:update(dt)
end

function love.draw()
  love.graphics.draw(map, 0, 0, 0, 2, 2)
  -- map:draw()
end