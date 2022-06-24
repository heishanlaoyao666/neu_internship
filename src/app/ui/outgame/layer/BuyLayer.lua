--[[--
    信息层
    BottomInfoLayer.lua
]]
local BuyLayer = class("BuyLayer", function()
    return display.newScene("SettiBuyLayerngLayer")
end)
-- local ConstDef = require("app.def.ConstDef")
-- local GameData = require("app.data.GameData")
--local BattleView = require("src\\app\\ui\\outgame\\view\\BattleView.lua")
--[[--
    构造函数

    @param none

    @return none
]]
function BuyLayer:ctor()

    -- self.lifeLabelBmf_ = nil -- 类型：TextBMFont，生命值
    -- self.scoreLabelBmf_ = nil -- 类型：TextBMFont，分值
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function BuyLayer:initView()
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
    newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore_confirmationpopup\\basemap_popup.png")
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

    local sprite2= ccui.Button:
    create("res\\artcontent\\lobby(ongame)\\store\\goldstore_confirmationpopup\\button_off.png")
    self.container_:addChild(sprite2)
    sprite2:setAnchorPoint(1, 1)
    sprite2:setPosition(sprite1:getContentSize().width-20, sprite1:getContentSize().height-20)
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

    local sprite3= ccui.Button:
    create("res\\artcontent\\lobby(ongame)\\store\\goldstore_confirmationpopup\\button_purchase.png")
    self.container_:addChild(sprite3)
    sprite3:setAnchorPoint(0.5, 0.5)
    sprite3:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height/2-100)
    sprite3:addTouchEventListener(
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

    local sprite4= ccui.Button:
    create("res\\artcontent\\lobby(ongame)\\store\\goldstore_confirmationpopup\\icon_goldcoin.png")
    sprite3:addChild(sprite4)
    sprite4:setAnchorPoint(0.5, 0.5)
    sprite4:setPosition(sprite3:getContentSize().width/2-50, sprite3:getContentSize().height/2)


end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function BuyLayer:update(dt)

end

return BuyLayer

