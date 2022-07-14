--[[--
    开启宝箱层
    ObtainItemLayer.lua
]]
local ObtainItemLayer = class("ObtainItemLayer", function()
    return display.newLayer()
end)
local OutGameData = require("app.data.outgame.OutGameData")
local EventDef = require("app.def.outgame.EventDef")
local EventManager = require("app.manager.EventManager")
local ConfirmationLayer = require("app.ui.outgame.layer.ConfirmationLayer")
--[[--
    构造函数

    @param none

    @return none
]]
function ObtainItemLayer:ctor()

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function ObtainItemLayer:initView()
    local tempfilename
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

    --底图
    local sprite1 = display.newSprite("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/basemap_popup.png")
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
    local sprite2= ccui.Button:create("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/button_off.png")
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
    goldprice=self.gold
    diamondprice=self.price
    local sprite3= ccui.Button:create("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/button_on.png")
    self.container_:addChild(sprite3)
    sprite3:setAnchorPoint(0.5, 0.5)
    sprite3:setPosition(sprite1:getContentSize().width/2, 0)
    sprite3:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                --ConfirmationLayer:new():addTo(self)
                EventManager:doEvent(EventDef.ID.COMFIRMATION)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_close.OGG",false)
                end
                OutGameData:setGold(goldprice)
                OutGameData:setDiamond(-diamondprice)
                EventManager:doEvent(EventDef.ID.GAMEDATA_CHANGE)
                self:removeFromParent(true)
            end
        end
    )

    --金币底图
    local sprite4= display.newSprite("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/basemap_gold.png")
    self.container_:addChild(sprite4)
    sprite4:setAnchorPoint(0.5, 0.5)
    sprite4:setPosition(sprite1:getContentSize().width/2-150, sprite1:getContentSize().height/2-10)
    display.newTTFLabel({
        text = "+"..self.gold,
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite4:getContentSize().width/2,sprite4:getContentSize().height/2-45)
    :addTo(sprite4)

    --金币图标
    local sprite5= display.newSprite("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/icon_gold.png")
    sprite4:addChild(sprite5)
    sprite5:setAnchorPoint(0.5, 0.5)
    sprite5:setPosition(sprite4:getContentSize().width/2, sprite4:getContentSize().height/2+10)

    --图标和文本
    --碎片类型和文本
    local sprite6= display.newSprite("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/icon_normal.png")
    self.container_:addChild(sprite6)
    sprite6:setAnchorPoint(0.5, 0.5)
    sprite6:setPosition(sprite1:getContentSize().width/2-30, sprite1:getContentSize().height/2+30)

    local sprite7= display.newSprite("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/basemap_text.png")
    sprite6:addChild(sprite7)
    sprite7:setAnchorPoint(0.5, 0.5)
    sprite7:setPosition(sprite6:getContentSize().width+40, sprite6:getContentSize().height/2+20)
    display.newTTFLabel({
        text = "普通",
        size = 20,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite7:getContentSize().width/2,sprite7:getContentSize().height/2)
    :addTo(sprite7)

    local sprite8= display.newSprite("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/basemap_text.png")
    sprite6:addChild(sprite8)
    sprite8:setAnchorPoint(0.5, 0.5)
    sprite8:setPosition(sprite6:getContentSize().width+40, sprite6:getContentSize().height/2-10)
    display.newTTFLabel({
        text = "X"..self.num1,
        size = 20,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite7:getContentSize().width/2,sprite7:getContentSize().height/2)
    :addTo(sprite8)

    local spriteA6= display.newSprite("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/icon_rare.png")
    self.container_:addChild(spriteA6)
    spriteA6:setAnchorPoint(0.5, 0.5)
    spriteA6:setPosition(sprite1:getContentSize().width/2+150, sprite1:getContentSize().height/2+30)

    local spriteA7= display.newSprite("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/basemap_text.png")
    spriteA6:addChild(spriteA7)
    spriteA7:setAnchorPoint(0.5, 0.5)
    spriteA7:setPosition(sprite6:getContentSize().width+40, sprite6:getContentSize().height/2+20)

    local spriteA8= display.newSprite("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/basemap_text.png")
    spriteA6:addChild(spriteA8)
    spriteA8:setAnchorPoint(0.5, 0.5)
    spriteA8:setPosition(sprite6:getContentSize().width+40, sprite6:getContentSize().height/2-10)
    display.newTTFLabel({
        text = "稀有",
        size = 20,
        color = cc.c3b(0,255, 255)
    })
    :align(display.CENTER, sprite7:getContentSize().width/2,sprite7:getContentSize().height/2)
    :addTo(spriteA7)
    display.newTTFLabel({
        text = "X"..self.num2,
        size = 20,
        color = cc.c3b(0,255, 255)
    })
    :align(display.CENTER, sprite7:getContentSize().width/2,sprite7:getContentSize().height/2)
    :addTo(spriteA8)

    local spriteB6= display.newSprite("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/icon_epic.png")
    self.container_:addChild(spriteB6)
    spriteB6:setAnchorPoint(0.5, 0.5)
    spriteB6:setPosition(sprite1:getContentSize().width/2-30, sprite1:getContentSize().height/2-60)

    local spriteB7= display.newSprite("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/basemap_text.png")
    spriteB6:addChild(spriteB7)
    spriteB7:setAnchorPoint(0.5, 0.5)
    spriteB7:setPosition(sprite6:getContentSize().width+40, sprite6:getContentSize().height/2+20)

    local spriteB8= display.newSprite("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/basemap_text.png")
    spriteB6:addChild(spriteB8)
    spriteB8:setAnchorPoint(0.5, 0.5)
    spriteB8:setPosition(sprite6:getContentSize().width+40, sprite6:getContentSize().height/2-10)
    display.newTTFLabel({
        text = "史诗",
        size = 20,
        color = cc.c3b(128,0, 128)
    })
    :align(display.CENTER, sprite7:getContentSize().width/2,sprite7:getContentSize().height/2)
    :addTo(spriteB7)
    display.newTTFLabel({
        text = "X"..self.num3,
        size = 20,
        color = cc.c3b(128,0, 128)
    })
    :align(display.CENTER, sprite7:getContentSize().width/2,sprite7:getContentSize().height/2)
    :addTo(spriteB8)

    if self.num4~=nil then
        tempfilename="artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/icon_legend.png"
        local spriteC6= display.newSprite(tempfilename)
        self.container_:addChild(spriteC6)
        spriteC6:setAnchorPoint(0.5, 0.5)
        spriteC6:setPosition(sprite1:getContentSize().width/2+150, sprite1:getContentSize().height/2-60)

        tempfilename="artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/basemap_text.png"
        local spriteC7= display.newSprite(tempfilename)
        spriteC6:addChild(spriteC7)
        spriteC7:setAnchorPoint(0.5, 0.5)
        spriteC7:setPosition(sprite6:getContentSize().width+40, sprite6:getContentSize().height/2+20)

        tempfilename="artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/basemap_text.png"
        local spriteC8= display.newSprite(tempfilename)
        spriteC6:addChild(spriteC8)
        spriteC8:setAnchorPoint(0.5, 0.5)
        spriteC8:setPosition(sprite6:getContentSize().width+40, sprite6:getContentSize().height/2-10)
        display.newTTFLabel({
            text = "传说",
            size = 20,
            color = cc.c3b(255, 215, 0)
        })
        :align(display.CENTER, sprite7:getContentSize().width/2,sprite7:getContentSize().height/2)
        :addTo(spriteC7)
        display.newTTFLabel({
            text = "X"..self.num4,
            size = 20,
            color = cc.c3b(255, 215, 0)
        })
        :align(display.CENTER, sprite7:getContentSize().width/2,sprite7:getContentSize().height/2)
        :addTo(spriteC8)
    end

    --宝箱图片
    local sprite9= display.newSprite("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/"..self.filename)
    self.container_:addChild(sprite9)
    sprite9:setAnchorPoint(0.5, 0.5)
    sprite9:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height+80)

    --宝箱类型
    local sprite10= display.newSprite("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/"..self.chesttitle)
    self.container_:addChild(sprite10)
    sprite10:setAnchorPoint(0.5, 0.5)
    sprite10:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height-40)

end

--[[--
    传入数据

    @param data 类型：number,宝箱类型

    @return self.filename，类型：string,宝箱图片文件名
    @return self.chesttitle，类型：string,宝箱标题文件名
    @return self.price，类型：number,宝箱价格
    @return self.num1，类型：number,普通数
    @return self.num2，类型：number,稀有数
    @return self.num3，类型：number,史诗数
    @return self.num4，类型：number/string,传说数
    @return self.gold，类型：number,获得金币数
]]
function ObtainItemLayer:SetData(data,gold)
    ConfirmationLayer:SetData(data,gold)
    self.gold=gold
    if data==1 then
        self.packs, self.packsNum=OutGameData:ordinaryChests()
        self.filename="icon_normalchest.png"
        self.chesttitle="chesttitle_1.png"
        self.price=150
        self.num1=38
        self.num2=7
        self.num3=1
        self.num4=nil
    elseif data==2 then
        self.packs, self.packsNum=OutGameData:rarityChests()
        self.filename="icon_rarechest.png"
        self.chesttitle="chesttitle_2.png"
        self.price=250
        self.num1=74
        self.num2=14
        self.num3=2
        self.num4=nil
    elseif data==3 then
        self.packs, self.packsNum=OutGameData:epicChests()
        self.filename="icon_epicchest.png"
        self.chesttitle="chesttitle_3.png"
        self.price=750
        self.num1=139
        self.num2=36
        self.num3=7
        self.num4="0-1"
    elseif data==4 then
        self.packs, self.packsNum=OutGameData:legendChests()
        self.filename="icon_legendchest.png"
        self.chesttitle="chesttitle_4.png"
        self.price=2500
        self.num1=187
        self.num2=51
        self.num3=21
        self.num4=1
    end
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function ObtainItemLayer:update(dt)

end

return ObtainItemLayer

