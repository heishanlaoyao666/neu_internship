--[[
    QuitAccountDialog.lua
    退出账号弹窗
    描述：退出账号弹窗
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local QuitAccountDialog = class("QuitAccountDialog", require("app.ui.layer.BaseLayer"))
local ConstDef = require("app.def.ConstDef")

local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

--[[--
    构造函数

    @param none

    @return none
]]
function QuitAccountDialog:ctor()
    QuitAccountDialog.super.ctor(self)

    self.container_ = nil -- 全局容器

    self.listener_ = nil
    self.isListening_ = false -- 是否监听

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function QuitAccountDialog:initView()

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self.container_:setBackGroundColor(cc.c3b(0, 0, 0))
    self.container_:setBackGroundColorType(1)
    self.container_:setCascadeOpacityEnabled(false) -- 穿透
    self.container_:setOpacity(0.8 * 255)
    self:addChild(self.container_)

    -- 弹窗背景
    local dialogBG = ccui.ImageView:create("image/lobby/general/inform/dialog_bg.png")
    dialogBG:setPosition(0.5*display.width, 0.5*display.height)
    self.container_:addChild(dialogBG)

    -- 说明文字
    local introText = ccui.ImageView:create("image/lobby/general/inform/quit_confirm_text.png")
    introText:setPosition(0.5*display.width, 0.5*display.height)
    self.container_:addChild(introText)



    -- 确认按钮
    local confirmBtn = ccui.Button:create("image/lobby/general/inform/confirm_btn.png")
    confirmBtn:setPosition(0.5*display.width, 0.45*display.height)
    confirmBtn:addClickEventListener(function()
        -- 退出游戏
        self:exitAccount()
    end)
    self.container_:addChild(confirmBtn)



    -- 事件监听
    self.listener_ = cc.EventListenerTouchOneByOne:create()
    self.listener_:registerScriptHandler(function(touch, event)
        if self.isListening_ then
            local touchPosition = touch:getLocation()
            local x = dialogBG:getPositionX()
            local y = dialogBG:getPositionY()
            local nodeSize = dialogBG:getContentSize()

            local rect = cc.rect(x - nodeSize.width/2, y - nodeSize.height/2,
                    nodeSize.width, nodeSize.height)

            if not cc.rectContainsPoint(rect, touchPosition) then -- 点击黑色遮罩关闭弹窗
                self:hideView()
            end

            return true
        end
        return false
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    eventDispatcher:addEventListenerWithSceneGraphPriority(self.listener_, self)

end

--[[--
    退出账号

    @param none

    @return none
]]
function QuitAccountDialog:exitAccount()
    cc.UserDefault:getInstance():setStringForKey("nick", nil)
    cc.UserDefault:getInstance():setStringForKey("pwd", nil)
    cc.UserDefault:getInstance():setStringForKey("pid", nil)
    display.replaceScene(require("app.scenes.LoadingScene"):new())
end

return QuitAccountDialog