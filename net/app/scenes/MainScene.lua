
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)


local MsgController = require("app.msg.MsgController")
local Log = require("app.util.Log")

local TAG = "MainScene"

function MainScene:ctor()
    local label = display.newTTFLabel({
        text = "tcp测试",
        size = 64,
    })
    label:align(display.CENTER, display.cx, display.top - 100)
    label:addTo(self)

    -- 初始化连接按钮
    local connectBtn = ccui.Button:create()
    connectBtn:setTitleText("开始连接")
    connectBtn:setTitleFontSize(48)
    connectBtn:setAnchorPoint(0.5, 0.5)
    connectBtn:setPosition(display.cx, display.cy + 200)
    self:addChild(connectBtn)
    connectBtn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            MsgController:connect()
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
            local msg = {
                type = 0x3E7,
                userId = 0,
                heartSerial = 1,
            }
            MsgController:sendMsg(msg)
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
            MsgController:disconnect()
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
