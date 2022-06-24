--[[--
    信息层
    BottomInfoLayer.lua
]]
local ConfirmationLayer = class("ConfirmationLayer", function()
    return display.newScene("ConfirmationLayer")
end)
-- local ConstDef = require("app.def.ConstDef")
-- local GameData = require("app.data.GameData")
--local BattleView = require("src\\app\\ui\\outgame\\view\\BattleView.lua")
--[[--
    构造函数

    @param none

    @return none
]]
function ConfirmationLayer:ctor()

    -- self.lifeLabelBmf_ = nil -- 类型：TextBMFont，生命值
    -- self.scoreLabelBmf_ = nil -- 类型：TextBMFont，分值
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function ConfirmationLayer:initView()
    local sprite0 = ccui.Button:
    create("res\\artcontent\\lobby(ongame)\\currency\\mask_popup.png")
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

    local sprite1 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_confirmationpopup\\basemap_popup.png")
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
    local sprite2= ccui.Button:
    create("res\\artcontent\\lobby(ongame)\\store\\goldstore_confirmationpopup\\button_purchase.png")
    self.container_:addChild(sprite2)
    sprite2:setAnchorPoint(0.5, 0.5)
    sprite2:setPosition(sprite1:getContentSize().width/2, -150)
    sprite2:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                self:removeFromParent(true)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_close.OGG",false)
                end
            end
        end
    )

    --金币
    local sprite3= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_confirmationpopup\\icon_gold.png")
    self.container_:addChild(sprite3)
    sprite3:setAnchorPoint(0.5, 0.5)
    sprite3:setPosition(sprite1:getContentSize().width/2-50, -50)


end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function ConfirmationLayer:update(dt)

end

return ConfirmationLayer

