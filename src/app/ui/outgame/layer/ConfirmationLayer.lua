--[[--
    宝箱获得物品层
    ConfirmationLayer.lua
]]
local ConfirmationLayer = class("ConfirmationLayer", require("app.ui.outgame.layer.BaseLayer"))
local OutGameData = require("app.data.outgame.OutGameData")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
--[[--
    构造函数

    @param none

    @return none
]]
function ConfirmationLayer:ctor()
    ConfirmationLayer.super.ctor(self)

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function ConfirmationLayer:initView()
    local tempfileneme=nil
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

    local sprite1 = display.newSprite("artcontent/lobby(ongame)/currency/chestopen_confirmationpopup/basemap_popup.png")
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
    tempfileneme="artcontent/lobby(ongame)/currency/chestopen_confirmationpopup/button_confirm.png"
    local confirmBtn= ccui.Button:create(tempfileneme)
    self.container_:addChild(confirmBtn)
    confirmBtn:setAnchorPoint(0.5, 0.5)
    confirmBtn:setPosition(sprite1:getContentSize().width/2, -150)
    confirmBtn:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                self:removeFromParent(true)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_click.OGG",false)
                end
            end
        end
    )

    --金币
    local gold= display.newSprite("artcontent/lobby(ongame)/currency/chestopen_confirmationpopup/icon_gold.png")
    self.container_:addChild(gold)
    gold:setAnchorPoint(0.5, 0.5)
    gold:setPosition(sprite1:getContentSize().width/2-30, -50)
    display.newTTFLabel({
        text = self.gold,
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, sprite1:getContentSize().width/2+30, -50)
    :addTo(self.container_)

    --获得的塔和数目
    local towerfileneme ="artcontent/lobby(ongame)/currency/chestopen_confirmationpopup/icon_tower/%d.png"
    local towerSprite1= display.newSprite(string.format(towerfileneme, packs[1]:getTowerId()))
    self.container_:addChild(towerSprite1)
    towerSprite1:setScale(0.8)
    towerSprite1:setAnchorPoint(0.5, 0.5)
    towerSprite1:setPosition(sprite1:getContentSize().width/2-180, sprite1:getContentSize().height/2)
    display.newTTFLabel({
        text ="x"..packsnum[1],
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_TOP, towerSprite1:getContentSize().width, towerSprite1:getContentSize().height)
    :addTo(towerSprite1)
    display.newTTFLabel({
        text = "普通",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, towerSprite1:getContentSize().width/2, -30)
    :addTo(towerSprite1)

    local towerSprite2= display.newSprite(string.format(towerfileneme, packs[2]:getTowerId()))
    self.container_:addChild(towerSprite2)
    towerSprite2:setScale(0.8)
    towerSprite2:setAnchorPoint(0.5, 0.5)
    towerSprite2:setPosition(sprite1:getContentSize().width/2-60, sprite1:getContentSize().height/2)
    display.newTTFLabel({
        text ="x"..packsnum[2],
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_TOP, towerSprite1:getContentSize().width, towerSprite1:getContentSize().height)
    :addTo(towerSprite2)
    display.newTTFLabel({
        text = "普通",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, towerSprite1:getContentSize().width/2, -30)
    :addTo(towerSprite2)

    local towerSprite3= display.newSprite(string.format(towerfileneme, packs[3]:getTowerId()))
    self.container_:addChild(towerSprite3)
    towerSprite3:setScale(0.8)
    towerSprite3:setAnchorPoint(0.5, 0.5)
    towerSprite3:setPosition(sprite1:getContentSize().width/2+60, sprite1:getContentSize().height/2)
    display.newTTFLabel({
        text ="x"..packsnum[3],
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_TOP, towerSprite1:getContentSize().width, towerSprite1:getContentSize().height)
    :addTo(towerSprite3)
    tower3=display.newTTFLabel({
        text = "稀有",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, towerSprite1:getContentSize().width/2, -30)
    :addTo(towerSprite3)

    local towerSprite4= display.newSprite(string.format(towerfileneme, packs[4]:getTowerId()))
    self.container_:addChild(towerSprite4)
    towerSprite4:setScale(0.8)
    towerSprite4:setAnchorPoint(0.5, 0.5)
    towerSprite4:setPosition(sprite1:getContentSize().width/2+180, sprite1:getContentSize().height/2)
    display.newTTFLabel({
        text ="x"..packsnum[4],
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_TOP, towerSprite1:getContentSize().width, towerSprite1:getContentSize().height)
    :addTo(towerSprite4)
    tower4=display.newTTFLabel({
        text = "史诗",
        size = 30,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, towerSprite1:getContentSize().width/2, -30)
    :addTo(towerSprite4)

    if #packsnum==8 then
        towerSprite1:setPositionY(sprite1:getContentSize().height/2+50)
        towerSprite2:setPositionY(sprite1:getContentSize().height/2+50)
        towerSprite3:setPositionY(sprite1:getContentSize().height/2+50)
        towerSprite4:setPositionY(sprite1:getContentSize().height/2+50)
        tower3:setString("普通")
        tower4:setString("普通")
        local towerSprite5= display.newSprite(string.format(towerfileneme, packs[5]:getTowerId()))
        self.container_:addChild(towerSprite5)
        towerSprite5:setScale(0.8)
        towerSprite5:setAnchorPoint(0.5, 0.5)
        towerSprite5:setPosition(sprite1:getContentSize().width/2-120, sprite1:getContentSize().height/2-90)
        display.newTTFLabel({
            text ="x"..packsnum[5],
            size = 25,
            color = display.COLOR_WHITE
        })
        :align(display.RIGHT_TOP, towerSprite1:getContentSize().width, towerSprite1:getContentSize().height)
        :addTo(towerSprite5)
        display.newTTFLabel({
            text = "稀有",
            size = 30,
            color = display.COLOR_WHITE
        })
        :align(display.CENTER, towerSprite1:getContentSize().width/2, -30)
        :addTo(towerSprite5)

        local towerSprite6= display.newSprite(string.format(towerfileneme, packs[6]:getTowerId()))
        self.container_:addChild(towerSprite6)
        towerSprite6:setScale(0.8)
        towerSprite6:setAnchorPoint(0.5, 0.5)
        towerSprite6:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height/2-90)
        display.newTTFLabel({
            text ="x"..packsnum[6],
            size = 25,
            color = display.COLOR_WHITE
        })
        :align(display.RIGHT_TOP, towerSprite1:getContentSize().width, towerSprite1:getContentSize().height)
        :addTo(towerSprite6)
        display.newTTFLabel({
            text = "稀有",
            size = 30,
            color = display.COLOR_WHITE
        })
        :align(display.CENTER, towerSprite1:getContentSize().width/2, -30)
        :addTo(towerSprite6)

        local towerSprite7= display.newSprite(string.format(towerfileneme, packs[7]:getTowerId()))
        self.container_:addChild(towerSprite7)
        towerSprite7:setScale(0.8)
        towerSprite7:setAnchorPoint(0.5, 0.5)
        towerSprite7:setPosition(sprite1:getContentSize().width/2+120, sprite1:getContentSize().height/2-90)
        display.newTTFLabel({
            text ="x"..packsnum[7],
            size = 25,
            color = display.COLOR_WHITE
        })
        :align(display.RIGHT_TOP, towerSprite1:getContentSize().width, towerSprite1:getContentSize().height)
        :addTo(towerSprite7)
        display.newTTFLabel({
            text = "史诗",
            size = 30,
            color = display.COLOR_WHITE
        })
        :align(display.CENTER, towerSprite1:getContentSize().width/2, -30)
        :addTo(towerSprite7)
        if packsnum[8]==1 then
            local towerSprite8= display.newSprite(string.format(towerfileneme, packs[8]:getTowerId()))
            self.container_:addChild(towerSprite8)
            towerSprite8:setScale(0.8)
            towerSprite8:setAnchorPoint(0.5, 0.5)
            towerSprite8:setPosition(sprite1:getContentSize().width/2+180, sprite1:getContentSize().height/2-90)
            display.newTTFLabel({
                text ="x"..packsnum[8],
                size = 25,
                color = display.COLOR_WHITE
            })
            :align(display.RIGHT_TOP, towerSprite1:getContentSize().width, towerSprite1:getContentSize().height)
            :addTo(towerSprite8)
            display.newTTFLabel({
                text = "传说",
                size = 30,
                color = display.COLOR_WHITE
            })
            :align(display.CENTER, towerSprite1:getContentSize().width/2, -30)
            :addTo(towerSprite8)

            towerSprite5:setPositionX(sprite1:getContentSize().width/2-180)
            towerSprite6:setPositionX(sprite1:getContentSize().width/2-60)
            towerSprite7:setPositionX(sprite1:getContentSize().width/2+60)
        end
    end
    local pack={}
    local packnum={}
    for i=1,#packs do
        pack[i]=packs[i]
        packnum[i]=packsnum[i]
        if i==8 then
            if packnum[i]==0 then
            else
                OutGameData:choosePacks(pack[i],packnum[i])
            end
        else
            OutGameData:choosePacks(pack[i],packnum[i])
        end
    end
    EventManager:doEvent(EventDef.ID.KNAPSACK_CHANGE)

end
--[[--
    传入数据

    @param data 类型：number,宝箱类型

    @return self.packs，类型：table，塔图片
    @return self.packs，类型：table，塔数

]]
function ConfirmationLayer:SetData(data,gold)
    --OutGameData:initTower()
    self.gold=gold
    if data==1 then
        packs, packsnum=OutGameData:ordinaryChests()
    elseif data==2 then
        packs,packsnum=OutGameData:rarityChests()
    elseif data==3 then
        packs, packsnum=OutGameData:epicChests()
    elseif data==4 then
        packs, packsnum=OutGameData:legendChests()
    elseif data==5 then
        packs, packsnum=OutGameData:epicChests()
    elseif data==6 then
        packs, packsnum=OutGameData:legendChests()
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

