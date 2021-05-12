local tilejam = require "tilejam"

function love.load()
  local map = tilejam:newTilemap("map.lua")

end

function love.update(dt)
  map:update(dt)
end

function love.draw()
  map:draw()
end