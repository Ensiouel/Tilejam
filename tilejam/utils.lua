local utils = {}

function utils.pixelChunkSum(image, x, y, w, h)
  local sum = 0
    for i = 0, h - 1 do
      for j = 0, w - 1 do
      local r, g, b, a = image:getPixel( x + i, y + j )
      if a ~= 0 then
        sum = sum + 1
      end
    end
  end
  return sum
end

function utils.jamTileImages(imageDatas, tileWidth, tileHeight)
  local firstgid = 0
  local tileWidth, tileHeight = tileWidth, tileHeight
  local tileCount = 0
  
  for i, v in pairs(imageDatas) do
    local bitmap = {}
    local imageWidth, imageHeight = v.imageData:getWidth(), v.imageData:getHeight()
    local cols, rows = imageWidth / tileWidth, imageHeight / tileHeight
    for r = 0, rows - 1 do
      for c = 0, cols - 1 do
        if utils.pixelChunkSum(v.imageData, c * tileWidth, r * tileHeight, tileWidth, tileHeight) ~= 0 then
          bitmap[#bitmap + 1] = { c, r }
        end
      end
    end
    v.firstgid = firstgid
    v.bitmap = bitmap
    v.cols = cols
    tileCount = tileCount + #bitmap
    firstgid = firstgid + cols * rows
  end

  local sizeMax = math.ceil(math.sqrt(tileCount))

  local resultImageData = love.image.newImageData( tileWidth * sizeMax, tileHeight * sizeMax )
  local fw, fh = 0, 0
  local tileset = {}

  for _, v in pairs(imageDatas) do
    for i, bit in pairs(v.bitmap) do
      resultImageData:paste(v.imageData, fw * tileWidth, fh * tileHeight, bit[1] * tileWidth, bit[2] * tileHeight, tileWidth, tileHeight)
      tileset[(bit[1] + 1) + bit[2] * v.cols + v.firstgid] = fw + fh * sizeMax + 1
      fw = fw + 1
      if fw + 1 > sizeMax then
        fw = 0
        fh = fh + 1
      end
    end
  end
  return resultImageData, tileset
end

return utils