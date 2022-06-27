--[[--
    信息层
    BottomInfoLayer.lua
]]
local ConfirmationLayer = class("ConfirmationLayer", function()
    return display.newScene("ConfirmationLayer")
end)
local OutGameData = require("src\\app\\data\\outgame\\OutGameData.lua")
local EventDef = require("src\\app\\def\\outgame\\EventDef.lua")
local EventManager = require("app.manager.EventManager")
--[[--
    构造函数

    @param none

    @return none
]]
function ConfirmationLayer:ctor()

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
    create("res\\artcontent\\lobby(ongame)\\currency\\chestopen_confirmationpopup\\button_confirm.png")
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
    sprite3:setPosition(sprite1:getContentSize().width/2-30, -50)
    display.newTTFLabel({
        text = self.gold,
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite1:getContentSize().width/2+30, -50)
    :addTo(self.container_)

    --获得的塔和数目
    local sprite4= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_confirmationpopup\\icon_tower\\"
    ..self.packs[1]:getTowerId()..".png")
    self.container_:addChild(sprite4)
    sprite4:setScale(0.8)
    sprite4:setAnchorPoint(0.5, 0.5)
    sprite4:setPosition(sprite1:getContentSize().width/2-180, sprite1:getContentSize().height/2)
    display.newTTFLabel({
        text ="x"..self.packsNum[1],
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_TOP, sprite4:getContentSize().width, sprite4:getContentSize().height)
    :addTo(sprite4)
    display.newTTFLabel({
        text = "普通",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite4:getContentSize().width/2, -30)
    :addTo(sprite4)

    local sprite5= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_confirmationpopup\\icon_tower\\"
    ..self.packs[2]:getTowerId()..".png")
    self.container_:addChild(sprite5)
    sprite5:setScale(0.8)
    sprite5:setAnchorPoint(0.5, 0.5)
    sprite5:setPosition(sprite1:getContentSize().width/2-60, sprite1:getContentSize().height/2)
    display.newTTFLabel({
        text ="x"..self.packsNum[2],
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_TOP, sprite4:getContentSize().width, sprite4:getContentSize().height)
    :addTo(sprite5)
    display.newTTFLabel({
        text = "普通",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite4:getContentSize().width/2, -30)
    :addTo(sprite5)

    local sprite6= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_confirmationpopup\\icon_tower\\"
    ..self.packs[3]:getTowerId()..".png")
    self.container_:addChild(sprite6)
    sprite6:setScale(0.8)
    sprite6:setAnchorPoint(0.5, 0.5)
    sprite6:setPosition(sprite1:getContentSize().width/2+60, sprite1:getContentSize().height/2)
    display.newTTFLabel({
        text ="x"..self.packsNum[3],
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_TOP, sprite4:getContentSize().width, sprite4:getContentSize().height)
    :addTo(sprite6)
    a3=display.newTTFLabel({
        text = "稀有",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite4:getContentSize().width/2, -30)
    :addTo(sprite6)

    local sprite7= display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_confirmationpopup\\icon_tower\\"
    ..self.packs[4]:getTowerId()..".png")
    self.container_:addChild(sprite7)
    sprite7:setScale(0.8)
    sprite7:setAnchorPoint(0.5, 0.5)
    sprite7:setPosition(sprite1:getContentSize().width/2+180, sprite1:getContentSize().height/2)
    display.newTTFLabel({
        text ="x"..self.packsNum[4],
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_TOP, sprite4:getContentSize().width, sprite4:getContentSize().height)
    :addTo(sprite7)
    a4=display.newTTFLabel({
        text = "史诗",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite4:getContentSize().width/2, -30)
    :addTo(sprite7)

    if #self.packsNum==8 then
        sprite4:setPositionY(sprite1:getContentSize().height/2+50)
        sprite5:setPositionY(sprite1:getContentSize().height/2+50)
        sprite6:setPositionY(sprite1:getContentSize().height/2+50)
        sprite7:setPositionY(sprite1:getContentSize().height/2+50)
        a3:setString("普通")
        a4:setString("普通")
        local sprite8= display.
        newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_confirmationpopup\\icon_tower\\"
        ..self.packs[5]:getTowerId()..".png")
        self.container_:addChild(sprite8)
        sprite8:setScale(0.8)
        sprite8:setAnchorPoint(0.5, 0.5)
        sprite8:setPosition(sprite1:getContentSize().width/2-120, sprite1:getContentSize().height/2-90)
        display.newTTFLabel({
            text ="x"..self.packsNum[5],
            size = 25,
            color = display.COLOR_WHITE
        })
        :align(display.RIGHT_TOP, sprite4:getContentSize().width, sprite4:getContentSize().height)
        :addTo(sprite8)
        display.newTTFLabel({
            text = "稀有",
            size = 30,
            color = display.COLOR_WHITE
        })
        :align(display.CENTER, sprite4:getContentSize().width/2, -30)
        :addTo(sprite8)

        local sprite9= display.
        newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_confirmationpopup\\icon_tower\\"
        ..self.packs[6]:getTowerId()..".png")
        self.container_:addChild(sprite9)
        sprite9:setScale(0.8)
        sprite9:setAnchorPoint(0.5, 0.5)
        sprite9:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height/2-90)
        display.newTTFLabel({
            text ="x"..self.packsNum[6],
            size = 25,
            color = display.COLOR_WHITE
        })
        :align(display.RIGHT_TOP, sprite4:getContentSize().width, sprite4:getContentSize().height)
        :addTo(sprite9)
        display.newTTFLabel({
            text = "稀有",
            size = 30,
            color = display.COLOR_WHITE
        })
        :align(display.CENTER, sprite4:getContentSize().width/2, -30)
        :addTo(sprite9)

        local sprite10= display.
        newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_confirmationpopup\\icon_tower\\"
        ..self.packs[7]:getTowerId()..".png")
        self.container_:addChild(sprite10)
        sprite10:setScale(0.8)
        sprite10:setAnchorPoint(0.5, 0.5)
        sprite10:setPosition(sprite1:getContentSize().width/2+120, sprite1:getContentSize().height/2-90)
        display.newTTFLabel({
            text ="x"..self.packsNum[7],
            size = 25,
            color = display.COLOR_WHITE
        })
        :align(display.RIGHT_TOP, sprite4:getContentSize().width, sprite4:getContentSize().height)
        :addTo(sprite10)
        display.newTTFLabel({
            text = "史诗",
            size = 30,
            color = display.COLOR_WHITE
        })
        :align(display.CENTER, sprite4:getContentSize().width/2, -30)
        :addTo(sprite10)
        if self.packsNum[8]==1 then
            local sprite11= display.
            newSprite("res\\artcontent\\lobby(ongame)\\currency\\chestopen_confirmationpopup\\icon_tower\\"
            ..self.packs[8]:getTowerId()..".png")
            self.container_:addChild(sprite11)
            sprite11:setScale(0.8)
            sprite11:setAnchorPoint(0.5, 0.5)
            sprite11:setPosition(sprite1:getContentSize().width/2+180, sprite1:getContentSize().height/2-90)
            display.newTTFLabel({
                text ="x"..self.packsNum[8],
                size = 25,
                color = display.COLOR_WHITE
            })
            :align(display.RIGHT_TOP, sprite4:getContentSize().width, sprite4:getContentSize().height)
            :addTo(sprite11)
            display.newTTFLabel({
                text = "传说",
                size = 30,
                color = display.COLOR_WHITE
            })
            :align(display.CENTER, sprite4:getContentSize().width/2, -30)
            :addTo(sprite11)

            sprite8:setPositionX(sprite1:getContentSize().width/2-180)
            sprite9:setPositionX(sprite1:getContentSize().width/2-60)
            sprite10:setPositionX(sprite1:getContentSize().width/2+60)
        end
    end

end
--[[--
    传入数据

    @param data 类型：number,宝箱类型

    @return self.packs，类型：table，塔图片
    @return self.packs，类型：table，塔数

]]
function ConfirmationLayer:SetData(data,gold)
    self.gold=gold
    if data==1 then
        self.packs, self.packsNum=OutGameData:ordinaryChests()
    elseif data==2 then
        self.packs, self.packsNum=OutGameData:rarityChests()
    elseif data==3 then
        self.packs, self.packsNum=OutGameData:epicChests()
    elseif data==4 then
        self.packs, self.packsNum=OutGameData:legendChests()
    end
end
--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function ConfirmationLayer:update(dt)

end

return ConfirmationLayer

