cc = cc or {}
---TileMapAtlas object
---@class TileMapAtlas : AtlasNode
local TileMapAtlas = {}
cc.TileMapAtlas = TileMapAtlas

--------------------------------
--- initializes a TileMap with a tile file (atlas) with a map file and the width and height of each tile in points.<br>
---The file will be loaded using the TextureMgr.
---@param tile string
---@param mapFile string
---@param tileWidth int
---@param tileHeight int
---@return bool
function TileMapAtlas:initWithTileFile(tile, mapFile, tileWidth, tileHeight) end

--------------------------------
--- dealloc the map from memory
---@return TileMapAtlas
function TileMapAtlas:releaseMap() end

--------------------------------
---Returns a tile from position x,y.<br>
---For the moment only channel R is used
---@param position vec2_table
---@return color3b_table
function TileMapAtlas:getTileAt(position) end

--------------------------------
--- sets a tile at position x,y.<br>
---For the moment only channel R is used
---@param tile color3b_table
---@param position vec2_table
---@return TileMapAtlas
function TileMapAtlas:setTile(tile, position) end

--------------------------------
--- creates a TileMap with a tile file (atlas) with a map file and the width and height of each tile in points.<br>
---The tile file will be loaded using the TextureMgr.
---@param tile string
---@param mapFile string
---@param tileWidth int
---@param tileHeight int
---@return TileMapAtlas
function TileMapAtlas:create(tile, mapFile, tileWidth, tileHeight) end

--------------------------------
---js ctor
---@return TileMapAtlas
function TileMapAtlas:TileMapAtlas() end

return TileMapAtlas