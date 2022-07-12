----内容：通用弹窗
----编写人员：郑蕾
---修订人员：郑蕾
---最后修改日期：7/12
local GeneralView = class("GeneralView")

--[[
    函数用途：通用弹窗
    --]]
function GeneralView:popUpLayer(grayLayer,msgType)
    self.Type = {"Gold","Diamond","Cup","CardGold","CardFragment"}
    --弹窗背景
    local generalBg = ccui.ImageView:create("ui/hall/common/SecondaryInterface-General notification Popup/bg-pop-up.png")
    generalBg:setPosition(display.cx,display.cy)
    generalBg:addTo(grayLayer)
    generalBg:setTouchEnabled(true)
    --根据参数判断弹窗内容
    if msgType == self.Type[1] then--商店：金币不足
        self.text = ccui.ImageView:create("ui/hall/common/SecondaryInterface-General notification Popup/Text - your gold coins are insufficient.png")
    elseif msgType == self.Type[2] then--商店：钻石不足
        self.text = ccui.ImageView:create("ui/hall/common/SecondaryInterface-General notification Popup/Text - you don't have enough diamonds.png")
    elseif msgType == self.Type[3] then--天梯：奖杯不足
        self.text = ccui.ImageView:create("ui/hall/common/SecondaryInterface-General notification Popup/Text - your trophy is insufficient.png")
    elseif msgType == self.Type[4] then--图鉴：金币不足
        self.text = ccui.ImageView:create("ui/hall/common/SecondaryInterface-General notification Popup/Text - upgrade failed - you do not have enough gold coins.png")
    elseif msgType == self.Type[5] then--图鉴：碎片不足
        self.text = ccui.ImageView:create("ui/hall/common/SecondaryInterface-General notification Popup/Text - upgrade failed - you have insufficient cards")
    end

    self.text:setAnchorPoint(0.5,0.5)
    self.text:setPosition(cc.p(display.cx-100, 180))
    self.text:addTo(generalBg)
    --确认按钮
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
            --按钮放缩
            self:setButtonScale(1,0.9,sender)
        elseif eventType == ccui.TouchEventType.ended then
            --按钮放缩
            self:setButtonScale(1,1,sender)
            --退出游戏
            if self.text == "Exit" then
                cc.Director:getInstance():popScene()
            else--隐藏弹窗
                grayLayer:setVisible(false)--隐藏二级弹窗
            end
        elseif eventType == ccui.TouchEventType.canceled then
            --按钮放缩
            self:setButtonScale(1,1,sender)
        end
    end)
    confirmButton:addTo(generalBg)
end

--[[
    函数用途：按钮放缩特效
    --]]
function GeneralView:setButtonScale(X,Y,sender)
    local scale = cc.ScaleTo:create(X,Y)
    local ease_elastic = cc.EaseElasticOut:create(scale)
    sender:runAction(ease_elastic)
end
return GeneralView