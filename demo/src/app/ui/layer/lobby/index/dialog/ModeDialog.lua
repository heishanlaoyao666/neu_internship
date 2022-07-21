--[[
    ModeDialog.lua
    模式弹窗
    描述：模式弹窗
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local ModeDialog = class("ModeDialog", require("app.ui.layer.BaseLayer"))
local ConstDef = require("app.def.ConstDef")
local DialogManager = require("app.manager.DialogManager")
local PlayerData = require("app.data.PlayerData")
local MappingDialog = require("app.ui.layer.lobby.index.dialog.dialog.MappingDialog")
local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

--[[--
    构造函数

    @param code number 失败代码

    @return none
]]
function ModeDialog:ctor(code)
    ModeDialog.super.ctor(self)

    self.container_ = nil -- 全局容器

    self:initParam(code)
    self:initView()
end

--[[--
    参数初始化

    @param none

    @return none
]]
function ModeDialog:initParam(code)
    self.listener_ = nil
    self.isListening_ = false -- 是否监听
    self.text_ = nil

end

--[[--
    界面初始化

    @param none

    @return none
]]
function ModeDialog:initView()

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self.container_:setBackGroundColor(cc.c3b(0, 0, 0))
    self.container_:setBackGroundColorType(1)
    self.container_:setCascadeOpacityEnabled(false) -- 穿透
    self.container_:setOpacity(0.8 * 255)
    self:addChild(self.container_)

    -- 弹窗背景
    local dialogBG = ccui.ImageView:create("image/lobby/index/mode/dialog_bg.png")
    dialogBG:setPosition(0.5*display.width, 0.5*display.height)
    self.container_:addChild(dialogBG)

    -- 模式文本
    local modeText = ccui.Text:create("模式选择", "font/fzbiaozjw.ttf", 45)
    modeText:setTextColor(cc.c4b(255, 255, 255, 255))
    modeText:enableOutline(cc.c4b(0, 0, 0, 255), 1) -- 描边
    modeText:setPosition(0.5*display.width, 0.6125*display.height)
    self.container_:addChild(modeText)

    -- 单人模式按钮
    local soloBtn = ccui.Button:create("image/lobby/index/mode/solo_btn.png")
    soloBtn:setPosition(0.5*display.width, 0.42*display.height)
    soloBtn:addClickEventListener(function()
        self:hideView()
    end)
    self.container_:addChild(soloBtn)

    -- 多人模式按钮
    local multiBtn = ccui.Button:create("image/lobby/index/mode/multi_btn.png")
    multiBtn:setPosition(0.5*display.width, 0.5*display.height)
    multiBtn:addClickEventListener(function()
        -- 匹配
        local dialog = MappingDialog.new()
        DialogManager:showDialog(dialog)
    end)
    self.container_:addChild(multiBtn)



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

return ModeDialog