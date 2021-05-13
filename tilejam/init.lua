local lg = love.graphics
local li = love.image
local ld = love.data

-- ===========================================================================
-- Tilejam
-- ===========================================================================

local Tilejam  = { 
  _URL         = "https://github.com/Ensiouel/Tilejam",
  _VERSION     = "1.0",
  _DESCRIPTION = "Tilemap library for LÖVE",
  imagecache = {}
}

local Tileset = {}
local Tilemap = {}
local Grid    = {}
local Layer   = {}

function Tilejam:new()
  local tilejam      = {}
  tilejam.conf       = {}
  tilejam.conf.debug = true
  setmetatable(tilejam, self)
  self.__index = self; return tilejam
end

-- ===========================================================================

function Tilejam:newTileset() --> Tileset

end

-- ===========================================================================

function Tilejam:newTilemap( path ) --> Tilemap
  local map, error, tilesets, tilemap, tileset

  -- Load a lua file with the Tiled data 
  map, error = love.filesystem.load( path )
  if error == nil then
    map = map()
  else
    self:debug( error )
  end

  tilesets = map.tilesets
  tilemap = Tilemap:new()

  for k, v in pairs( tilesets ) do
    tilemap:newTileset( v )
  end

  for k, v in pairs( tilemap.tilesets ) do
    print(k, v)
  end
end

-- ===========================================================================

function Tilejam:debug( ... ) --> nil
  if self.conf.debug then
    print( ... )
  end
end

-- ===========================================================================

function Tilejam:newTiled( path )

end

-- ===========================================================================

function Tilejam:newImage( path ) --> Image
  local hashPath = ld.hash( "md5", path )

  -- Search by image path
  if Tilejam.imagecache[hashPath] ~= nil then
    return Tilejam.imagecache[hashPath].image
  end

  local imageData = li.newImageData( path )
  local hashImage = ld.hash( "md5", imageData )

  -- Search by image content
  for k, image in pairs( Tilejam.imagecache ) do
    if image.hashImage == hashImage then
      return Tilejam.imagecache[k].image
    end
  end

  -- Creating an image cache
  Tilejam.imagecache[hashPath] = {
    hashImage = hashImage,
    image = lg.newImage( imageData )
  }

  return Tilejam.imagecache[hashPath].image
end

-- ===========================================================================

function Tilejam:getImage() --> Image

end

-- ===========================================================================
-- Tilemap
-- ===========================================================================

function Tilemap:new( params )
  local tilemap    = {}
  tilemap.tilesets = {} --[[ name, Tileset ]]
  tilemap.layers   = {} --[[ id,   Layer   ]]
  setmetatable(tilemap, self)
  self.__index = self; return tilemap
end

function Tilemap:newLayer( params ) --> Layer
  local layer = Layer:new( params )
  if self.layers[layer.name] == nil then
    self.layers[layer.name] = layer
    return self.layers[layer.name]
  end
end

function Tilemap:newTileset( params ) --> Tileset
  local tileset = Tileset:new( params )
  if self.tilesets[tileset.name] == nil then
    self.tilesets[tileset.name] = tileset
    return self.tilesets[tileset.name]
  end
  return nil
end

function Tilemap:update( dt )
  for k, layer in pairs( self.layers ) do

  end
end

function Tilemap:draw()
  for k, layer in pairs( self.layers ) do

  end
end

-- ===========================================================================
-- Tileset
-- ===========================================================================

function Tileset:new( params )
  local tileset              = {}
  tileset.name               = params.name
  tileset.firstgid           = params.firstgid
  tileset.tile               = {}
    tileset.tile.width       = params.tilewidth
    tileset.tile.height      = params.tileheight
    tileset.tile.сount       = params.tilecount
    tileset.tile.offset      = {}
      tileset.tile.offset.x  = params.tileoffset.x
      tileset.tile.offset.y  = params.tileoffset.y
  tileset.grid               = {}
    tileset.grid.orientation = params.grid.orientation
    tileset.grid.width       = params.grid.width
    tileset.grid.height      = params.grid.height
  tileset.spacing            = params.spacing
  tileset.margin             = params.margin
  tileset.columns            = params.columns
  tileset.image              = Tilejam:newImage(params.image)
  tileset.imageWidth         = tileset.image:getWidth()
  tileset.imageHeight        = tileset.image:getHeight()
  tileset.objectAlignment    = params.objectalignment
  tileset.properties         = params.properties
  tileset.tiles              = params.tiles
  setmetatable(tileset, self)
  self.__index = self; return tileset
end

-- ===========================================================================
-- Layer
-- ===========================================================================

function Layer:new()
  local layer      = {}
  layer.id         = -1
  layer.type       = ""
  layer.name       = ""
  layer.visible    = true
  layer.opacity    = 1
  layer.position   = { x = 0, y = 0 }
  layer.offset     = { x = 0, y = 0 }
  layer.parallax   = { x = 1, y = 1 }
  layer.properties = {}
  layer.size       = { width = 64, height = 64 }
  layer.grid       = nil
  setmetatable(layer, self)
  self.__index = self; return layer
end

-- ===========================================================================
-- Grid
-- ===========================================================================

function Grid:new()
  local grid      = {}
  setmetatable(grid, self)
  self.__index = self; return grid
end

-- ===========================================================================

return Tilejam:new()