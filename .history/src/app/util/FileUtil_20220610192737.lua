FileUtil = FileUtil or {}
-- local
local fileUtil = cc.FileUtils:getInstance()
local writablePath = fileUtil:getWritablePath()

local json = require("dkjson")
--

function FileUtil.fileRead(filename)
    local absoluateFilename = writablePath .. filename
    local file = io.open(absoluateFilename, "r")
    if file == nil then
        Log.e("File not exists.")
        local tmp = io.open(absoluateFilename, "w+")
        tmp:write("test")
        tmp:close()
        file = io.open(absoluateFilename, "r")
    end
    local str = ""
    for line in file:lines() do
        str = str .. line
    end
    file:close()
    return str
end

function FileUtil.fileWrite(filename, str)
    local absoluateFilename = writablePath .. filename
    local file = io.open(absoluateFilename, "w+")
    file:write(str)
    file:close()
end

function FileUtil.loadGame()
    Log.i("FileUtil.loadGame")
    local str = FileUtil.fileRead(ConstantsUtil.PATH_SAVE_JSON)
    Log.i(str)
    local obj, pos, err = json.decode(str, 1, nil)
    if obj == nil then
        Log.e("JSON Error: obj is nullptr")
        return
    end
    GameHandler.toLoadGame(obj)
    if err then
        Log.e("Error:", err)
    end
end

function FileUtil.saveGame()
    Log.i("FileUtil.saveGame")
    local obj = GameHandler.toSaveGame()
    local str = json.encode(obj, {indent = true})
    FileUtil.fileWrite(ConstantsUtil.PATH_SAVE_JSON, str)
end

function FileUtil.saveRank()
    local obj = GameHandler.toSaveRank()
    local str = json.encode(obj, {indent = true})
    FileUtil.fileWrite(ConstantsUtil.PATH_RANK_JSON, str)
end

function FileUtil.loadRank()
    Log.i("FileUtil.loadGame")
    local str = FileUtil.fileRead(ConstantsUtil.PATH_RANK_JSON)
    Log.i(str)
    local obj, pos, err = json.decode(str, 1, nil)
    if obj == nil then
        Log.e("JSON Error: obj is nullptr")
        return
    end
    GameHandler.toLoadRank(obj)
    if err then
        Log.e("Error:", err)
    end
end

return FileUtil
