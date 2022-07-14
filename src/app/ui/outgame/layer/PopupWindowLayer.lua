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
    local maskBtn = ccui.Button:create("artcontent/lobby(ongame)/currency/mask_popup.png")
    self:addChild(maskBtn)
    maskBtn:setAnchorPoint(0.5, 0.5)
    maskBtn:setOpacity(127)
    maskBtn:setPosition(display.cx,display.cy)

    maskBtn:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                self:removeFromParent(true)
            end
        end
    )

    local basemap = display.newSprite("artcontent/lobby(ongame)/currency/notice_popup/basemap_popup.png")
    basemap:setAnchorPoint(0.5, 0.5)

    self.container_ = ccui.Layout:create()
    -- self.container_:setBackGroundColor(cc.c3b(200, 0, 0))
    -- self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(basemap:getContentSize().width, basemap:getContentSize().height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5,0.5)
    self.container_:setPosition(display.cx, display.cy)
    self.container_:addChild(basemap)
    basemap:setPosition(basemap:getContentSize().width/2, basemap:getContentSize().height/2)

    --确认按钮
    local okBtn= ccui.Button:create("artcontent/lobby(ongame)/currency/notice_popup/button_ok.png")
    self.container_:addChild(okBtn)
    okBtn:setAnchorPoint(0.5, 0.5)
    okBtn:setPosition(basemap:getContentSize().width/2, basemap:getContentSize().height/2-100)
    okBtn:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                if self.index==6 then
                    AppBase:exit()
                else
                    self:removeFromParent(true)
                end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_click.OGG",false)
                end
            end
        end
    )

    --文字提示
    local text= display.newSprite("artcontent/lobby(ongame)/currency/notice_popup/text_"..self.index..".png")
    self.container_:addChild(text)
    text:setAnchorPoint(0.5, 0.5)
    text:setPosition(basemap:getContentSize().width/2, basemap:getContentSize().height/2)


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

