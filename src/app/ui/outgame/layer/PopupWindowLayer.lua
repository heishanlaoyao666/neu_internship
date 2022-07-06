--[[--
    确认退出层
    PopupWindowLayer.lua
]]
local PopupWindowLayer = class("PopupWindowLayer", require("app.ui.outgame.layer.BaseLayer"))
local AppBase = require("framework.AppBase")
--[[--
    构造函数

    @param none

    @return none
]]
function PopupWindowLayer:ctor()

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function PopupWindowLayer:initView()
    local sprite0 = ccui.Button:create("artcontent/lobby(ongame)/currency/mask_popup.png")
    self:addChild(sprite0)
    sprite0:setAnchorPoint(0.5, 0.5)
    sprite0:setOpacity(127)
    sprite0:setPosition(display.cx,display.cy)

    sprite0:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                self:removeFromParent(true)
            end
        end
    )

    local sprite1 = display.newSprite("artcontent/lobby(ongame)/currency/notice_popup/basemap_popup.png")
    sprite1:setAnchorPoint(0.5, 0.5)

    self.container_ = ccui.Layout:create()
    -- self.container_:setBackGroundColor(cc.c3b(200, 0, 0))
    -- self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(sprite1:getContentSize().width, sprite1:getContentSize().height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5,0.5)
    self.container_:setPosition(display.cx, display.cy)
    self.container_:addChild(sprite1)
    sprite1:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height/2)

    --确认按钮
    local sprite2= ccui.Button:create("artcontent/lobby(ongame)/currency/notice_popup/button_ok.png")
    self.container_:addChild(sprite2)
    sprite2:setAnchorPoint(0.5, 0.5)
    sprite2:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height/2-100)
    sprite2:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                if self.index==6 then
                    AppBase:exit()
                else
                    self:removeFromParent(true)
                end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_close.OGG",false)
                end
            end
        end
    )

    --文字提示
    local sprite3= display.newSprite("artcontent/lobby(ongame)/currency/notice_popup/text_"..self.index..".png")
    self.container_:addChild(sprite3)
    sprite3:setAnchorPoint(0.5, 0.5)
    sprite3:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height/2)


end

--[[--
    设置图片

    @param index 类型：number，

    @return none
]]
function PopupWindowLayer:setIndex(index)
    self.index=index
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function PopupWindowLayer:update(dt)

end

return PopupWindowLayer

