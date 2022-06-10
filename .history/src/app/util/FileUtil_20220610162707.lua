FileUtil = FileUtil or {}
-- local
local fileUtil = cc.FileUtils:getInstance()
local writablePath = fileUtil:getWritablePath()

local json = require("dkjson")
--

function FileUtil.fileRead(filename)
    local absoluateFilename = writablePath .. filename
    local file = io.open(absoluateFilename, "r")
    local str = file:read()
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
end

function FileUtil.saveGame()
    local obj = GameHandler.toSave()
    local str = json.encode(obj, {indent = true})
    FileUtil.fileWrite(ConstantsUtil.PATH_SAVE_JSON, str)
end

function FileUtil.saveRank()
    -- body
end

function FileUtil.loadRank()
    -- body
end

return FileUtil
