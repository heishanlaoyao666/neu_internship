--[[--
    开启宝箱层
    ObtainItemLayer.lua
]]
local ObtainItemLayer = class("ObtainItemLayer", require("app.ui.outgame.layer.BaseLayer"))
local OutGameData = require("app.data.outgame.OutGameData")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local ConfirmationLayer = require("app.ui.outgame.layer.ConfirmationLayer")
--local BattleLayer = require("app.ui.outgame.layer.BattleLayer")
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
    local offBtn= ccui.Button:create("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/button_off.png")
    self.container_:addChild(offBtn)
    offBtn:setAnchorPoint(1, 1)
    offBtn:setPosition(sprite1:getContentSize().width-20, sprite1:getContentSize().height-20)
    offBtn:addTouchEventListener(
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
    local goldprice=self.gold
    local diamondprice=self.price
    local onBtn= ccui.Button:create("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/button_on.png")
    self.container_:addChild(onBtn)
    onBtn:setAnchorPoint(0.5, 0.5)
    onBtn:setPosition(sprite1:getContentSize().width/2, 0)
    onBtn:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                --ConfirmationLayer:new():addTo(self)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/open_box.OGG",false)
                end
                if diamondprice<=OutGameData:getDiamond() then
                    EventManager:doEvent(EventDef.ID.COMFIRMATION)
                    OutGameData:setGold(goldprice)
                    OutGameData:setDiamond(-diamondprice)
                    if diamondprice==0 then
                        cc.UserDefault:getInstance():setIntegerForKey("imgstatus"..self.index,3)
                        EventManager:doEvent(EventDef.ID.BATTLE)
                    end
                    EventManager:doEvent(EventDef.ID.GAMEDATA_CHANGE)
                else
                    EventManager:doEvent(EventDef.ID.POPUPWINDOW,3)
                end
                self:removeFromParent(true)
            end
        end
    )

    --金币底图
    tempfilename="artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/basemap_gold.png"
    local basemapGold= display.newSprite(tempfilename)
    self.container_:addChild(basemapGold)
    basemapGold:setAnchorPoint(0.5, 0.5)
    basemapGold:setPosition(sprite1:getContentSize().width/2-150, sprite1:getContentSize().height/2-10)
    display.newTTFLabel({
        text = "+"..self.gold,
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, basemapGold:getContentSize().width/2,basemapGold:getContentSize().height/2-45)
    :addTo(basemapGold)

    --金币图标
    local iconGold= display.newSprite("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/icon_gold.png")
    basemapGold:addChild(iconGold)
    iconGold:setAnchorPoint(0.5, 0.5)
    iconGold:setPosition(basemapGold:getContentSize().width/2, basemapGold:getContentSize().height/2+10)

    --图标和文本
    --碎片类型和文本
    local normal= display.newSprite("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/icon_normal.png")
    self.container_:addChild(normal)
    normal:setAnchorPoint(0.5, 0.5)
    normal:setPosition(sprite1:getContentSize().width/2-30, sprite1:getContentSize().height/2+30)

    textfilename="artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/basemap_text.png"
    local basemapText1= display.newSprite(textfilename)
    normal:addChild(basemapText1)
    basemapText1:setAnchorPoint(0.5, 0.5)
    basemapText1:setPosition(normal:getContentSize().width+40, normal:getContentSize().height/2+20)
    display.newTTFLabel({
        text = "普通",
        size = 20,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, basemapText1:getContentSize().width/2,basemapText1:getContentSize().height/2)
    :addTo(basemapText1)

    local basemapText2= display.newSprite(textfilename)
    normal:addChild(basemapText2)
    basemapText2:setAnchorPoint(0.5, 0.5)
    basemapText2:setPosition(normal:getContentSize().width+40, normal:getContentSize().height/2-10)
    display.newTTFLabel({
        text = "X"..self.num1,
        size = 20,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, basemapText1:getContentSize().width/2,basemapText1:getContentSize().height/2)
    :addTo(basemapText2)

    local rare= display.newSprite("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/icon_rare.png")
    self.container_:addChild(rare)
    rare:setAnchorPoint(0.5, 0.5)
    rare:setPosition(sprite1:getContentSize().width/2+150, sprite1:getContentSize().height/2+30)

    local basemapText3= display.newSprite(textfilename)
    rare:addChild(basemapText3)
    basemapText3:setAnchorPoint(0.5, 0.5)
    basemapText3:setPosition(normal:getContentSize().width+40, normal:getContentSize().height/2+20)

    local basemapText4= display.newSprite(textfilename)
    rare:addChild(basemapText4)
    basemapText4:setAnchorPoint(0.5, 0.5)
    basemapText4:setPosition(normal:getContentSize().width+40, normal:getContentSize().height/2-10)
    display.newTTFLabel({
        text = "稀有",
        size = 20,
        color = cc.c3b(0,255, 255)
    })
    :align(display.CENTER, basemapText1:getContentSize().width/2,basemapText1:getContentSize().height/2)
    :addTo(basemapText3)
    display.newTTFLabel({
        text = "X"..self.num2,
        size = 20,
        color = cc.c3b(0,255, 255)
    })
    :align(display.CENTER, basemapText1:getContentSize().width/2,basemapText1:getContentSize().height/2)
    :addTo(basemapText4)

    local epic= display.newSprite("artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/icon_epic.png")
    self.container_:addChild(epic)
    epic:setAnchorPoint(0.5, 0.5)
    epic:setPosition(sprite1:getContentSize().width/2-30, sprite1:getContentSize().height/2-60)

    local basemapText5= display.newSprite(textfilename)
    epic:addChild(basemapText5)
    basemapText5:setAnchorPoint(0.5, 0.5)
    basemapText5:setPosition(normal:getContentSize().width+40, normal:getContentSize().height/2+20)

    local basemapText6= display.newSprite(textfilename)
    epic:addChild(basemapText6)
    basemapText6:setAnchorPoint(0.5, 0.5)
    basemapText6:setPosition(normal:getContentSize().width+40, normal:getContentSize().height/2-10)
    display.newTTFLabel({
        text = "史诗",
        size = 20,
        color = cc.c3b(128,0, 128)
    })
    :align(display.CENTER, basemapText1:getContentSize().width/2,basemapText1:getContentSize().height/2)
    :addTo(basemapText5)
    display.newTTFLabel({
        text = "X"..self.num3,
        size = 20,
        color = cc.c3b(128,0, 128)
    })
    :align(display.CENTER, basemapText1:getContentSize().width/2,basemapText1:getContentSize().height/2)
    :addTo(basemapText6)

    if self.num4~=nil then
        tempfilename="artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/icon_legend.png"
        local legend= display.newSprite(tempfilename)
        self.container_:addChild(legend)
        legend:setAnchorPoint(0.5, 0.5)
        legend:setPosition(sprite1:getContentSize().width/2+150, sprite1:getContentSize().height/2-60)

        local basemapText7= display.newSprite(textfilename)
        legend:addChild(basemapText7)
        basemapText7:setAnchorPoint(0.5, 0.5)
        basemapText7:setPosition(normal:getContentSize().width+40, normal:getContentSize().height/2+20)

        local basemapText8= display.newSprite(textfilename)
        legend:addChild(basemapText8)
        basemapText8:setAnchorPoint(0.5, 0.5)
        basemapText8:setPosition(normal:getContentSize().width+40, normal:getContentSize().height/2-10)
        display.newTTFLabel({
            text = "传说",
            size = 20,
            color = cc.c3b(255, 215, 0)
        })
        :align(display.CENTER, basemapText1:getContentSize().width/2,basemapText1:getContentSize().height/2)
        :addTo(basemapText7)
        display.newTTFLabel({
            text = "X"..self.num4,
            size = 20,
            color = cc.c3b(255, 215, 0)
        })
        :align(display.CENTER, basemapText1:getContentSize().width/2,basemapText1:getContentSize().height/2)
        :addTo(basemapText8)
    end

    --宝箱图片
    tempfilename="artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/"..self.filename
    local chestSprite= display.newSprite(tempfilename)
    self.container_:addChild(chestSprite)
    chestSprite:setAnchorPoint(0.5, 0.5)
    chestSprite:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height+80)

    --宝箱类型
    tempfilename="artcontent/lobby(ongame)/currency/chestopen_ obtainitemspopup/"..self.chesttitle
    local chestType= display.newSprite(tempfilename)
    self.container_:addChild(chestType)
    chestType:setAnchorPoint(0.5, 0.5)
    chestType:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height-40)

end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function ObtainItemLayer:setIndex(index)
    self.index=index
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
    elseif data==5 then
        self.packs, self.packsNum=OutGameData:epicChests()
        self.filename="icon_epicchest.png"
        self.chesttitle="chesttitle_3.png"
        self.price=0
        self.num1=139
        self.num2=36
        self.num3=7
        self.num4="0-1"
    elseif data==6 then
        self.packs, self.packsNum=OutGameData:legendChests()
        self.filename="icon_legendchest.png"
        self.chesttitle="chesttitle_4.png"
        self.price=0
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

