--[[
    TestTCPScene.lua
    描述：测试与服务端通信的场景
    编写：张昊煜
    修订：
    检查：
]]

local KEY_PLAYER_ID = "playerid"
local KEY_NICKNAME = "nick"
local KEY_HP = "hp"

local TestTCPScene = class("TestTCPScene", function()
    return display.newScene("TestScene")
end)

local tcp = require("app.data.TCP")
local gameData = require("app.data.GameData")

function TestTCPScene:ctor()

    gameData:init()

    hpText = ccui.Text:create(1000, "font/fzbiaozjw.ttf", 48)
    hpText:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 2像素纯黑色描边
    hpText:setTextColor(cc.c4b(255, 255, 255, 255))
    hpText:setPosition(display.cx, display.cy+150)
    hpText:addTo(self)
    hpText:setString("xx")

    hpTextResp = ccui.Text:create(1000, "font/fzbiaozjw.ttf", 48)
    hpTextResp:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 2像素纯黑色描边
    hpTextResp:setTextColor(cc.c4b(255, 255, 255, 255))
    hpTextResp:setPosition(display.cx, display.cy-50)
    hpTextResp:addTo(self)
    hpTextResp:setString("xx")

    btn = ccui.Button:create():pos(display.cx, display.cy+50):addTo(self)
	btn:setTitleText("发送数据并及时监听返回消息")
	btn:setTitleFontSize(40)
	btn:addTouchEventListener(function(ref, eventType)
		if cc.EventCode.ENDED == eventType then
            hpText:setString(math.random(0, 100))

            local msg = {} -- 要给服务器发送的table
            msg[KEY_PLAYER_ID] = 100007
            msg[KEY_NICKNAME] = "xujh"
            msg[KEY_HP] = hpText:getString()

            -- 此处演示了tcp.send四参数全部传入的情况
            -- 此处的意义是发送的type为6，发送的数据是msg，希望接收的type为0x80000+6，接收到数据之后进入回调函数
            -- 适合客户端发送数据之后服务端马上处理了数据并返回了值的情况
            tcp.send(6, msg, 0x80000+6, function(resp)
                print("in callback func")
                hpTextResp:setString(resp["hp"])
            end)
		end
	end)

    -- 此处演示了tcp.regListener的用法
    -- 此处意义为客户端监听服务端发来type为0x80000+6的消息，接收到数据之后进入回调函数
    -- 适合服务端向客户端发送消息，客户端只做监听的情况
    tcp.regListener(0x80000+6, function(resp)
        print("in listener")
        dump(resp)
    end)

    btn = ccui.Button:create():pos(display.cx, display.cy-150):addTo(self)
	btn:setTitleText("只发送数据")
	btn:setTitleFontSize(40)
	btn:addTouchEventListener(function(ref, eventType)
		if cc.EventCode.ENDED == eventType then
            -- 此按钮会把666发给服务器，服务器应该会返回1332
            local msg = {} -- 要给服务器发送的table
            msg[KEY_PLAYER_ID] = 100007
            msg[KEY_NICKNAME] = "xujh"
            msg[KEY_HP] = "666"

            -- 此处演示了tcp.send不传入后面两个参数的情况，即仅发送数据，不在此处做返回值监听
            -- 适合客户端仅发送数据，不需要及时处理服务端返回值的情况
            tcp.send(6, msg)
            -- tcp.unRegListener(0x80000+6)
		end
	end)

end

--[[--
    场景退出

    @param none

    @return none
]]
function TestTCPScene:onExit()
    tcp.close()
end

return TestTCPScene
