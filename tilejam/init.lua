local lg = love.graphics
local li = love.image
local ld = love.data

-- ===========================================================================
-- Tilejam
-- ===========================================================================
local Tilejam  = { 
  _URL         = "https://github.com/Ensiouel/Tilejam",
  _VERSION     = "1.0",
  _DESCRIPTION = "Tilemap library for LÖVE"
}
function Tilejam:new()
  local tilejam      = {}
  tilejam.conf       = {}
  tilejam.conf.debug = true
  tilejam.imagecache = {}
  setmetatable(tilejam, self)
  self.__index = self; return tilejam
end
-- ===========================================================================
function Tilejam:debug(message) --> nil
  if self.conf.debug then
    print(message)
  end
end
-- ===========================================================================
function Tilejam:newTiled(path)

end
-- ===========================================================================
function Tilejam:newImage( path ) --> Image
  local hashPath = ld.hash( "md5", path )

  -- Search by image path
  if self.imagecache[hashPath] ~= nil then
    return self.imagecache[hashPath].image
  end

  local imageData = li.newImageData( path )
  local hashImage = ld.hash( "md5", imageData )

  -- Search by image content
  for k, image in pairs(self.imagecache) do
    if image.hashImage == hashImage then
      return self.imagecache[k].image
    end
  end

  -- Creating an image cache
  self.imagecache[hashPath] = {
    hashImage = hashImage,
    image = lg.newImage(imageData)
  }

  return self.imagecache[hashPath].image
end
-- ===========================================================================
function Tilejam:getImage() --> Image

end
-- ===========================================================================
-- Tilemap
-- ===========================================================================
local Tilemap = {}
function Tilemap:new()
  local tilemap      = {}
  setmetatable(tilemap, self)
  self.__index = self; return tilemap
end
-- ===========================================================================

return Tilejam:new()