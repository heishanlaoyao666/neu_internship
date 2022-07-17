--[[
    MappingDialog.lua
    匹配弹窗
    描述：匹配弹窗
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local MappingDialog = class("MappingDialog", require("app.ui.layer.BaseLayer"))
local ConstDef = require("app.def.ConstDef")
local DialogManager = require("app.manager.DialogManager")
local PlayerData = require("app.data.PlayerData")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")
local MsgManager = require("app.manager.MsgManager")
local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

--[[--
    构造函数

    @param code number 失败代码

    @return none
]]
function MappingDialog:ctor(code)
    MappingDialog.super.ctor(self)

    self.container_ = nil -- 全局容器

    self:initParam(code)
    self:initView()
end

--[[--
    参数初始化

    @param none

    @return none
]]
function MappingDialog:initParam(code)
    self.listener_ = nil
    self.isListening_ = false -- 是否监听
    self.text_ = nil

end

--[[--
    界面初始化

    @param none

    @return none
]]
function MappingDialog:initView()

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self.container_:setBackGroundColor(cc.c3b(0, 0, 0))
    self.container_:setBackGroundColorType(1)
    self.container_:setCascadeOpacityEnabled(false) -- 穿透
    self.container_:setOpacity(0.8 * 255)
    self:addChild(self.container_)

    -- 弹窗背景
    local dialogBG = ccui.ImageView:create("image/lobby/index/mapping/dialog_bg.png")
    dialogBG:setPosition(0.5*display.width, 0.5*display.height)
    self.container_:addChild(dialogBG)

    -- 加载中
    local loadingImg = ccui.ImageView:create("image/lobby/index/mapping/loading.png")
    loadingImg:setPosition(0.5*display.width, 0.5*display.height)
    self.container_:addChild(loadingImg)

    -- 取消按钮
    local cancelBtn = ccui.Button:create("image/lobby/index/mapping/cancel_btn.png")
    cancelBtn:setPosition(0.5*display.width, 0.42*display.height)
    cancelBtn:addClickEventListener(function()
        -- 终止匹配
        MsgManager:endMapping()
        self:hideView()
    end)
    self.container_:addChild(cancelBtn)


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

            end

            return true
        end
        return false
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    eventDispatcher:addEventListenerWithSceneGraphPriority(self.listener_, self)

end

--[[--
    onEnter

    @param none

    @return none
]]
function MappingDialog:onEnter()
    -- 进入场景时发送开赛信息
    MsgManager:startMapping()

    EventManager:regListener(EventDef.ID.MAPPING_SUCCEED, self, function()
        print("Mapping succeed!")
        cc.Director:getInstance():pushScene(require("app.scenes.FightScene").new())
    end)
end

--[[--
    onExit

    @param none

    @return none
]]
function MappingDialog:onExit()

end

return MappingDialog