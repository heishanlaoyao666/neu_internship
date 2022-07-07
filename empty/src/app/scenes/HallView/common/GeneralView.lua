local GeneralView = class("GeneralView")

function GeneralView:popUpLayer(grayLayer,msgType)
    self.Type = {"Gold","Diamond","Cup","CardGold","CardFragment"}
    --弹窗背景
    local generalBg = ccui.ImageView:create("ui/hall/common/SecondaryInterface-General notification Popup/bg-pop-up.png")
    generalBg:setPosition(display.cx,display.cy)
    generalBg:addTo(grayLayer)
    generalBg:setTouchEnabled(true)

    if msgType == self.Type[1] then
        self.text = ccui.ImageView:create("ui/hall/common/SecondaryInterface-General notification Popup/Text - your gold coins are insufficient.png")
    elseif msgType == self.Type[2] then
        self.text = ccui.ImageView:create("ui/hall/common/SecondaryInterface-General notification Popup/Text - you don't have enough diamonds.png")
    elseif msgType == self.Type[3] then
        self.text = ccui.ImageView:create("ui/hall/common/SecondaryInterface-General notification Popup/Text - your trophy is insufficient.png")
    elseif msgType == self.Type[4] then
        self.text = ccui.ImageView:create("ui/hall/common/SecondaryInterface-General notification Popup/Text - upgrade failed - you do not have enough gold coins.png")
    elseif msgType == self.Type[5] then
        self.text = ccui.ImageView:create("ui/hall/common/SecondaryInterface-General notification Popup/Text - upgrade failed - you have insufficient cards")
    end

    self.text:setAnchorPoint(0.5,0.5)
    self.text:setPosition(cc.p(display.cx-100, 180))
    self.text:addTo(generalBg)

    self:confirmButton(grayLayer,generalBg)

end

--[[
    函数用途：确认按钮
    参数：灰色背景层，弹窗层
    --]]
function GeneralView:confirmButton(grayLayer,generalBg)
    local confirmButton = ccui.Button:create(
            "ui/hall/common/SecondaryInterface-General notification Popup/Button - confirm.png",
            "ui/hall/common/SecondaryInterface-General notification Popup/Button - confirm.png",
            "ui/hall/common/SecondaryInterface-General notification Popup/Button - confirm.png")
    confirmButton:setAnchorPoint(0.5,0.5)
    confirmButton:setPosition(cc.p(display.cx-100, 70))
    confirmButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        elseif eventType == ccui.TouchEventType.ended then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
            if self.text == "Exit" then
                cc.Director:getInstance():popScene()
            else
                grayLayer:setVisible(false)--隐藏二级弹窗
            end
        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    confirmButton:addTo(generalBg)
end

return GeneralView