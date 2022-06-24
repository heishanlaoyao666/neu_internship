--[[--
    信息层
    BottomInfoLayer.lua
]]
local ObtainItemLayer = class("ObtainItemLayer", function()
    return display.newScene("ObtainItemLayer")
end)
-- local ConstDef = require("app.def.ConstDef")
-- local GameData = require("app.data.GameData")
--local BattleView = require("src\\app\\ui\\outgame\\view\\BattleView.lua")
--[[--
    构造函数

    @param none

    @return none
]]
function ObtainItemLayer:ctor()

    -- self.lifeLabelBmf_ = nil -- 类型：TextBMFont，生命值
    -- self.scoreLabelBmf_ = nil -- 类型：TextBMFont，分值
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function ObtainItemLayer:initView()
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

    --底图
    local sprite1 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\basemap_popup.png")
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

    --x按钮
    local sprite2= ccui.Button:
    create("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\button_off.png")
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

    --开启按钮
    local sprite3= ccui.Button:
    create("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\button_on.png")
    self.container_:addChild(sprite3)
    sprite3:setAnchorPoint(0.5, 0.5)
    sprite3:setPosition(sprite1:getContentSize().width/2, 0)
    sprite3:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                require("src\\app\\ui\\outgame\\layer\\ConfirmationLayer.lua"):new():addTo(self)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_close.OGG",false)
                end
            end
        end
    )

    --金币底图
    local sprite4= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\basemap_gold.png")
    self.container_:addChild(sprite4)
    sprite4:setAnchorPoint(0.5, 0.5)
    sprite4:setPosition(sprite1:getContentSize().width/2-150, sprite1:getContentSize().height/2-10)

    --金币图标
    local sprite5= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\icon_gold.png")
    sprite4:addChild(sprite5)
    sprite5:setAnchorPoint(0.5, 0.5)
    sprite5:setPosition(sprite4:getContentSize().width/2, sprite4:getContentSize().height/2+10)

    --图标和文本
    local sprite6= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\icon_normal.png")
    self.container_:addChild(sprite6)
    sprite6:setAnchorPoint(0.5, 0.5)
    sprite6:setPosition(sprite1:getContentSize().width/2-30, sprite1:getContentSize().height/2+30)

    local sprite7= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\basemap_text.png")
    sprite6:addChild(sprite7)
    sprite7:setAnchorPoint(0.5, 0.5)
    sprite7:setPosition(sprite6:getContentSize().width+40, sprite6:getContentSize().height/2+20)

    local sprite8= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\basemap_text.png")
    sprite6:addChild(sprite8)
    sprite8:setAnchorPoint(0.5, 0.5)
    sprite8:setPosition(sprite6:getContentSize().width+40, sprite6:getContentSize().height/2-10)

    local spriteA6= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\icon_rare.png")
    self.container_:addChild(spriteA6)
    spriteA6:setAnchorPoint(0.5, 0.5)
    spriteA6:setPosition(sprite1:getContentSize().width/2+150, sprite1:getContentSize().height/2+30)

    local spriteA7= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\basemap_text.png")
    spriteA6:addChild(spriteA7)
    spriteA7:setAnchorPoint(0.5, 0.5)
    spriteA7:setPosition(sprite6:getContentSize().width+40, sprite6:getContentSize().height/2+20)

    local spriteA8= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\basemap_text.png")
    spriteA6:addChild(spriteA8)
    spriteA8:setAnchorPoint(0.5, 0.5)
    spriteA8:setPosition(sprite6:getContentSize().width+40, sprite6:getContentSize().height/2-10)
    
    local spriteB6= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\icon_epic.png")
    self.container_:addChild(spriteB6)
    spriteB6:setAnchorPoint(0.5, 0.5)
    spriteB6:setPosition(sprite1:getContentSize().width/2-30, sprite1:getContentSize().height/2-60)

    local spriteB7= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\basemap_text.png")
    spriteB6:addChild(spriteB7)
    spriteB7:setAnchorPoint(0.5, 0.5)
    spriteB7:setPosition(sprite6:getContentSize().width+40, sprite6:getContentSize().height/2+20)

    local spriteB8= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\basemap_text.png")
    spriteB6:addChild(spriteB8)
    spriteB8:setAnchorPoint(0.5, 0.5)
    spriteB8:setPosition(sprite6:getContentSize().width+40, sprite6:getContentSize().height/2-10)

    local spriteC6= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\icon_legend.png")
    self.container_:addChild(spriteC6)
    spriteC6:setAnchorPoint(0.5, 0.5)
    spriteC6:setPosition(sprite1:getContentSize().width/2+150, sprite1:getContentSize().height/2-60)

    local spriteC7= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\basemap_text.png")
    spriteC6:addChild(spriteC7)
    spriteC7:setAnchorPoint(0.5, 0.5)
    spriteC7:setPosition(sprite6:getContentSize().width+40, sprite6:getContentSize().height/2+20)

    local spriteC8= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\basemap_text.png")
    spriteC6:addChild(spriteC8)
    spriteC8:setAnchorPoint(0.5, 0.5)
    spriteC8:setPosition(sprite6:getContentSize().width+40, sprite6:getContentSize().height/2-10)

    local sprite9= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\icon_normalchest.png")
    self.container_:addChild(sprite9)
    sprite9:setAnchorPoint(0.5, 0.5)
    sprite9:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height+80)

    local sprite10= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_ obtainitemspopup\\chesttitle_1.png")
    self.container_:addChild(sprite10)
    sprite10:setAnchorPoint(0.5, 0.5)
    sprite10:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height-40)

end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function ObtainItemLayer:update(dt)

end

return ObtainItemLayer

