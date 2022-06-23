local cjson = require "cjson"
local Timer = require("lua.Timer")
local LogDef = require("lua.LogDef")
local MsgDef = require("lua.MsgDef")
local GameEntity = require("lua.game.GameEntity")

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
	newGame = GameEntity.new()
	newGame:init(gameSerial, msg)
	print("xxxxxxxxxxxxxxxxxxxx")
end

function processGameMsg()
	local msgStr = recvGameMsg()
	if (msgStr == nil or msgStr == '') then
		return
	end
	print("开赛消息来了")
	local msg = cjson.decode(msgStr)
	print(msg["type"])
	if (msg["type"] == MsgDef.REQTYPE.CREATEGAME) then
		createGameEntity(msg)
	end
end

function update()
	--main loop
	processGameMsg()
	--other logic update
end

function main()
	initGameModule()
	local loopTimer = Timer.new()
	loopTimer:beginTimer(50)
	while true do
		if loopTimer:countingTimer() then
			update()
		end
		msSleep(1)
	end
end

xpcall(main, __G__TRACKBACK__)
