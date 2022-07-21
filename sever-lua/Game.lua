local cjson = require "cjson"
local MsgDef = require("lua.MsgDef")
local GameEntity = require("lua.game.GameEntity")

local newGames={}
local function traceback()
    local retstr = "\r\n"
    local level = 3
    while true do
        local info = debug.getinfo(level, "Sln")
        if not info then break end
        if info.what == "C" then -- is a C function?
            retstr = retstr .. string.format("level: %s C function '%s'\r\n", tostring(level), tostring(info.name))
        else -- a Lua function
            retstr = retstr .. string.format("[%s]:%s  in function '%s'\r\n",
                tostring(info.source), tostring(info.currentline), tostring(info.name))
        end
        level = level + 1
    end

    return retstr
end

function __G__TRACKBACK__(errorMessage)
    local log = "LUA ERROR: " .. tostring(errorMessage) .. debug.traceback("", 2)
            .. "\r\nFull Path:" .. traceback()
    print(log)
end

function initGameModule()
	--init game module here
	print("init game module succ")
end

local gameSerial = 0
function createGameEntity(msg)
	gameSerial = gameSerial + 1
	local newGame = GameEntity.new()
	newGame:init(gameSerial, msg)
	newGames[#newGames+1] = newGame
	print("xxxxxxxxxxxxxxxxxxxx")
end

function processGameMsg()
	local msgStr = recvGameMsg()
	if (msgStr == nil or msgStr == '') then
		return
	end
	--消息data处理
	local msg = cjson.decode(msgStr)
	if (msg["type"] == MsgDef.REQTYPE.CREATEGAME) then
		createGameEntity(msg)
	elseif (msg["type"] == MsgDef.REQTYPE.BOSSTRUE) then
		newGames[msg["serialNumber"]]:setBoss(msg)
	elseif (msg["type"] == MsgDef.REQTYPE.TOWERCREATE) then
		newGames[msg["serialNumber"]]:towerCreate(msg)
	elseif (msg["type"] == MsgDef.REQTYPE.GAMEPLAY) then
		newGames[msg["serialNumber"]]:gamePlay(msg)
	elseif (msg["type"] == MsgDef.REQTYPE.LIFECHANGE) then
		newGames[msg["serialNumber"]]:lifeChange(msg)
	elseif (msg["type"] == MsgDef.REQTYPE.SURRENDER) then
		print("收到"..msg["pid"].."的投降")
		newGames[msg["serialNumber"]]:playerSurrender(msg)
	elseif (msg["type"] == MsgDef.REQTYPE.GAMEDATAOVER) then
		countGame(msg)
	end

end

function update()
	--main loop
	processGameMsg()
	for i = 1, #newGames do
		newGames[i]:update()
	end
	--other logic update
end

function main()
	initGameModule()
	while true do
		update()
	end
end

xpcall(main, __G__TRACKBACK__)
