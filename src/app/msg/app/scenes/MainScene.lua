
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)


local MsgController = require("app.msg.MsgController")
local Log = require("app.util.Log")
local TAG = "MainScene"
local OutgameMsg = require("app.msg.OutgameMsg")





function MainScene:ctor()

    -- 初始化连接按钮
    local connectBtn = ccui.Button:create()
    connectBtn:setTitleText("开始连接")
    connectBtn:setTitleFontSize(48)
    connectBtn:setAnchorPoint(0.5, 0.5)
    connectBtn:setPosition(display.cx, display.cy + 200)
    self:addChild(connectBtn)
    connectBtn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            OutgameMsg:connect()
        end
    end)

    -- 初始化发送按钮
    local sendBtn = ccui.Button:create()
    sendBtn:setTitleText("发送消息")
    sendBtn:setTitleFontSize(48)
    sendBtn:setAnchorPoint(0.5, 0.5)
    sendBtn:setPosition(display.cx, display.cy)
    self:addChild(sendBtn)
    sendBtn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            OutgameMsg:login("duwang108","duqw1201")
            OutgameMsg:getData("duwang108","financeData")
        end
    end)

    -- 初始化断开按钮
    local disconnectBtn = ccui.Button:create()
    disconnectBtn:setTitleText("断开连接")
    disconnectBtn:setTitleFontSize(48)
    disconnectBtn:setAnchorPoint(0.5, 0.5)
    disconnectBtn:setPosition(display.cx, display.cy - 200)
    self:addChild(disconnectBtn)
    disconnectBtn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            OutgameMsg:getdataFromMsg()
        end
    end)
end

function MainScene:onEnter()
    MsgController:registerListener(self, handler(self, self.handleMsg))
end

function MainScene:onExit()
    MsgController:unregisterListener(self)
end

function MainScene:handleMsg(msg)

    Log.i(TAG, "handleMsg() msg=", msg)
end

return MainScene
