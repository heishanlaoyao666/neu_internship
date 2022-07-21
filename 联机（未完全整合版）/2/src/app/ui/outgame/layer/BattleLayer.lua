--[[--
    战斗层
    BattleLayer.lua
]]
local BattleLayer = class("BattleLayer",require("app.ui.outgame.layer.BaseLayer"))
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local CurrentTowerLayer = require("app.ui.outgame.layer.CurrentTowerLayer")
local OutGameData = require("app.data.outgame.OutGameData")
local ObtainItemLayer = require("app.ui.outgame.layer.ObtainItemLayer")
local OutgameMsg = require("app.msg.OutgameMsg")
--local MsgController= require("app.msg.MsgController")
--[[--
    构造函数

    @param none

    @return none
]]
function BattleLayer:ctor()
    BattleLayer.super.ctor(self)
    self.account=cc.UserDefault:getInstance():getStringForKey("account")
    self.container_ = nil -- 类型：Layout，控件容器
    self.imgStatus={}

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function BattleLayer:initView()
    local width, height = display.width, 1120
    --战斗界面（游戏外）
    self.container_ = ccui.Layout:create()
    self.container_:addTo(self)
    self.container_:setContentSize(display.width, height)
    self.container_:setPosition(0, 0)

    --底图
    local basemapSprite = display.newSprite("artcontent/lobby_ongame/battle_interface/basemap_interfaces.png")
    self.container_:addChild(basemapSprite)
    basemapSprite:setPosition(display.cx,display.cy)

    --对战模式按钮
    local battlemodeBtn = ccui.Button:create("artcontent/lobby_ongame/battle_interface/button_battlemode.png")
    self.container_:addChild(battlemodeBtn)
    battlemodeBtn:setAnchorPoint(0.5, 0.5)
    battlemodeBtn:setPosition(width/2, height/2-30)
    battlemodeBtn:addTouchEventListener(function(sender, eventType)
        -- ccui.TouchEventType
        if 2 == eventType then -- touch end
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/player_match.OGG",false)
            end
            EventManager:doEvent(EventDef.ID.MATCH)
            cc.UserDefault:getInstance():setBoolForKey("fight",true)
            EventManager:doEvent(EventDef.ID.FIGHT)
        end
    end)
    --已选队伍底图
    local teamsSprite = display.newSprite("artcontent/lobby_ongame/battle_interface/basemap_selectedteams.png")
    self.container_:addChild(teamsSprite)
    teamsSprite:setPosition(display.cx,200)
    --cc.UserDefault:getInstance():setIntegerForKey("currentlineup",1)
    CurrentTowerLayer:setContentSize(teamsSprite:getContentSize().width,teamsSprite:getContentSize().height)
    CurrentTowerLayer:new():addTo(teamsSprite)

    --天梯背景和ListView创建
    local rankSprite = display.newSprite("artcontent/lobby_ongame/battle_interface/rank/basemap_rank.png")
    self.container_:addChild(rankSprite)
    rankSprite:setPosition(display.cx,display.cy+300)
    self.listcontainer_ =ccui.Layout:create()
    self.listcontainer_:setContentSize(rankSprite:getContentSize().width-100, rankSprite:getContentSize().height)
    self.listcontainer_:setAnchorPoint(0.5,0.5)
    self.listcontainer_:setPosition(rankSprite:getContentSize().width/2,rankSprite:getContentSize().height/2)
    self.listcontainer_:addTo(rankSprite)

    local listView = ccui.ListView:create()
    local listcontainerSize=self.listcontainer_:getContentSize()
    listView:setContentSize(listcontainerSize.width, listcontainerSize.height+100)
    listView:setAnchorPoint(0.5, 0.5)
    listView:setPosition(listcontainerSize.width/2,listcontainerSize.height/2+50)
    listView:setDirection(2)
    listView:addTo(self.listcontainer_)
    listView:setBounceEnabled(true)

    local slideSprite = display.newSprite("artcontent/lobby_ongame/battle_interface/rank/icon_slide.png")
    slideSprite:addTo(rankSprite)
    slideSprite:setAnchorPoint(0,0.5)
    slideSprite:setPosition(15,rankSprite:getContentSize().height/2+50)

    local slidesignSprite = display.newSprite("artcontent/lobby_ongame/battle_interface/rank/icon_slidesign.png")
    slidesignSprite:addTo(rankSprite)
    slidesignSprite:setAnchorPoint(1,0.5)
    slidesignSprite:setPosition(rankSprite:getContentSize().width-15,rankSprite:getContentSize().height/2+50)
    local gold={}
    local diamond={}
    self.progress=OutGameData:getTrophy()*1/2200
    for i=1,22 do
        if cc.UserDefault:getInstance():getIntegerForKey("imgstatus"..i) then
            self.imgStatus[i]=cc.UserDefault:getInstance():getIntegerForKey("imgstatus"..i)
        else
            self.imgStatus[i]=1
        end
    end
    for i=1,22 do
        if i<=4 then
            if i*50<=OutGameData:getTrophy() and self.imgStatus[i]==1 then
                self.imgStatus[i]=2
            end
        end
        if i>=5 then
            if (i*100-200)<=OutGameData:getTrophy() and self.imgStatus[i]==1 then
                self.imgStatus[i]=2
            end
        end
        gold[i]=0
        diamond[i]=0
        self.imgContainer_ =ccui.Layout:create()
        local img = ccui.Button:create("artcontent/lobby_ongame/battle_interface/rank/locked_blueborder.png")
        img:setAnchorPoint(0,0.5)
        img:setPosition(50,img:getContentSize().height/2)
        self.imgContainer_:addChild(img)
        self.imgContainer_:setContentSize(img:getContentSize().width+50,img:getContentSize().height)
        self.imgContainer_:setAnchorPoint(0.5,0.5)
        self.imgContainer_:setPosition(rankSprite:getContentSize().width/2,rankSprite:getContentSize().height/2+100)
        self.imgContainer_:addTo(listView)
        --宝箱内容
        if i==1 then
            local content = display.newSprite("artcontent/lobby_ongame/store/diamondstore/chest_legend.png")
            img:addChild(content)
            content:setScale(0.6)
            content:setAnchorPoint(0.5, 0.5)
            content:setPosition(img:getContentSize().width/2,img:getContentSize().height/2)
        elseif i==2 then
            content = display.newSprite("artcontent/lobby_ongame/battle_interface/rank/gold.png")
            img:addChild(content)
            content:setAnchorPoint(0.5, 0.5)
            content:setPosition(img:getContentSize().width/2,img:getContentSize().height/2+20)
            display.newTTFLabel({
                text = "500",
                size = 25,
                color = display.COLOR_WHITE
            })
            :align(display.CENTER,img:getContentSize().width/2,img:getContentSize().height/2-30)
            :addTo(img)
            gold[i]=500
        elseif i<12 then
            content = display.newSprite("artcontent/lobby_ongame/store/diamondstore/chest_epic.png")
            img:addChild(content)
            content:setScale(0.6)
            content:setAnchorPoint(0.5, 0.5)
            content:setPosition(img:getContentSize().width/2,img:getContentSize().height/2)
        elseif i==12 then
            content = display.newSprite("artcontent/lobby_ongame/store/goldstore/itemicon_tower/13.png")
            img:addChild(content)
            content:setScale(0.5)
            content:setAnchorPoint(0.5, 0.5)
            content:setPosition(img:getContentSize().width/2,img:getContentSize().height/2)
        elseif i==22 then
            content = display.newSprite("artcontent/lobby_ongame/battle_interface/rank/group92.png")
            img:addChild(content)
            content:setAnchorPoint(0.5, 0.5)
            content:setPosition(img:getContentSize().width/2,img:getContentSize().height/2)
        elseif i%3==1 then
            content = display.newSprite("artcontent/lobby_ongame/store/diamondstore/chest_epic.png")
            img:addChild(content)
            content:setScale(0.6)
            content:setAnchorPoint(0.5, 0.5)
            content:setPosition(img:getContentSize().width/2,img:getContentSize().height/2)
        elseif i%3==2 then
            content = display.newSprite("artcontent/lobby_ongame/battle_interface/rank/diamonds.png")
            img:addChild(content)
            content:setAnchorPoint(0.5, 0.5)
            content:setPosition(img:getContentSize().width/2,img:getContentSize().height/2+20)
            display.newTTFLabel({
                text = "100",
                size = 25,
                color = display.COLOR_WHITE
            })
            :align(display.CENTER,img:getContentSize().width/2,img:getContentSize().height/2-30)
            :addTo(img)
            diamond[i]=100
        elseif i%3==0 then
            content = display.newSprite("artcontent/lobby_ongame/battle_interface/rank/gold.png")
            img:addChild(content)
            content:setAnchorPoint(0.5, 0.5)
            content:setPosition(img:getContentSize().width/2,img:getContentSize().height/2+20)
            display.newTTFLabel({
                text = "1000",
                size = 25,
                color = display.COLOR_WHITE
            })
            :align(display.CENTER,img:getContentSize().width/2,img:getContentSize().height/2-30)
            :addTo(img)
            gold[i]=1000
        end

        local lockedSprite = display.newSprite("artcontent/lobby_ongame/battle_interface/rank/locked.png")
        img:addChild(lockedSprite)
        lockedSprite:setAnchorPoint(0.5, 0)
        lockedSprite:setPosition(img:getContentSize().width/2,-25)
        lockedSprite:setVisible(true)
        local getSprite = display.newSprite("artcontent/lobby_ongame/battle_interface/rank/group130.png")
        img:addChild(getSprite)
        getSprite:setAnchorPoint(0.5, 0)
        getSprite:setPosition(img:getContentSize().width/2,-25)
        getSprite:setVisible(false)

        img:addTouchEventListener(function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_click.OGG",false)
                end
                EventManager:doEvent(EventDef.ID.POPUPWINDOW,1)
            end
        end)
        if self.imgStatus[i]==1 then
        elseif self.imgStatus[i]==2 then
            local tempfilename="artcontent/lobby_ongame/battle_interface/rank/unlocked_notclamide_yellowborder.png"
            img:loadTextureNormal(tempfilename)
            lockedSprite:setVisible(false)
            img:addTouchEventListener(function(sender, eventType)
                if 2 == eventType then -- touch end
                    cc.UserDefault:getInstance():setIntegerForKey("imgstatus",2)
                    if cc.UserDefault:getInstance():getBoolForKey("音效") then
                        audio.playEffect("sounds/ui_btn_click.OGG",false)
                    end
                    if i==1 then
                        ObtainItemLayer:SetData(6,3040)
                        ObtainItemLayer:setIndex(i)
                        EventManager:doEvent(EventDef.ID.OBTAINITEM)
                    elseif i==2 then
                        OutGameData:setGold(gold[i])
                        cc.UserDefault:getInstance():setIntegerForKey("imgstatus"..i,3)
                        EventManager:doEvent(EventDef.ID.BATTLE)
                        EventManager:doEvent(EventDef.ID.GAMEDATA_CHANGE)
                    elseif i<12 then
                        ObtainItemLayer:SetData(5,1280)
                        ObtainItemLayer:setIndex(i)
                        EventManager:doEvent(EventDef.ID.OBTAINITEM)
                    elseif i==12 then
                        OutGameData:choosePacks(OutGameData:getTower(13),1)
                        cc.UserDefault:getInstance():setIntegerForKey("imgstatus"..i,3)
                        EventManager:doEvent(EventDef.ID.BATTLE)
                        EventManager:doEvent(EventDef.ID.KNAPSACK_CHANGE)
                    elseif i==22 then
                        packs, packsnum=OutGameData:legendChests()
                        OutGameData:choosePacks(packs[8],packsnum[8])
                        cc.UserDefault:getInstance():setIntegerForKey("imgstatus"..i,3)
                        EventManager:doEvent(EventDef.ID.BATTLE)
                        EventManager:doEvent(EventDef.ID.KNAPSACK_CHANGE)
                    elseif i%3==1 then
                        ObtainItemLayer:SetData(5,1280)
                        ObtainItemLayer:setIndex(i)
                        EventManager:doEvent(EventDef.ID.OBTAINITEM)
                    elseif i%3==2 then
                        OutGameData:setDiamond(diamond[i])
                        cc.UserDefault:getInstance():setIntegerForKey("imgstatus"..i,3)
                        EventManager:doEvent(EventDef.ID.BATTLE)
                        EventManager:doEvent(EventDef.ID.GAMEDATA_CHANGE)
                    elseif i%3==0 then
                        OutGameData:setGold(gold[i])
                        cc.UserDefault:getInstance():setIntegerForKey("imgstatus"..i,3)
                        EventManager:doEvent(EventDef.ID.BATTLE)
                        EventManager:doEvent(EventDef.ID.GAMEDATA_CHANGE)
                    end
                end
            end)
        else
            img:loadTextureNormal("artcontent/lobby_ongame/battle_interface/rank/available.png")
            lockedSprite:setVisible(false)
            getSprite:setVisible(true)
            img:addTouchEventListener(function(sender, eventType)
                if 2 == eventType then -- touch end
                    if cc.UserDefault:getInstance():getBoolForKey("音效") then
                        audio.playEffect("sounds/ui_btn_click.OGG",false)
                    end
                    print(3)
                end
            end)
        end

    end
    --进度条背景
    local loadBarProBG = cc.Sprite:create("artcontent/lobby_ongame/battle_interface/rank/sacle/scale_ruler.png")
    loadBarProBG:setScale(self.imgContainer_:getContentSize().width*22/loadBarProBG:getContentSize().width,1)
    loadBarProBG:setAnchorPoint(0,0)
    loadBarProBG:pos(0, 50)
    listView:addChild(loadBarProBG)

   --进度条
   local tempfilename="artcontent/lobby_ongame/battle_interface/rank/sacle/rectangle_1.png"
   self.loadBarPro_ = cc.ProgressTimer:create(cc.Sprite:create(tempfilename))
   self.loadBarPro_:setScale(14.41,1)
   self.loadBarPro_:setAnchorPoint(0, 0.5)
   self.loadBarPro_:setType(cc.PROGRESS_TIMER_TYPE_BAR)--从左到右
   self.loadBarPro_:setMidpoint(cc.p(0, 0))
   self.loadBarPro_:setBarChangeRate(cc.p(1, 0))
   self.loadBarPro_:pos(3, loadBarProBG:getContentSize().height/2+1)
   self.loadBarPro_:setPercentage(0)
   loadBarProBG:addChild(self.loadBarPro_)

   local Spritekey = display.newSprite("artcontent/lobby_ongame/battle_interface/rank/sacle/key.png")
   Spritekey:setScale(loadBarProBG:getContentSize().width/self.imgContainer_:getContentSize().width/22,1)
   loadBarProBG:addChild(Spritekey)
   Spritekey:setAnchorPoint(0, 0.5)
   Spritekey:setPosition(0,loadBarProBG:getContentSize().height/2)

    for i=1,22 do
        local Spritescale = display.newSprite("artcontent/lobby_ongame/battle_interface/rank/sacle/scale.png")
        Spritescale:setScale(loadBarProBG:getContentSize().width/self.imgContainer_:getContentSize().width/22,1)
        loadBarProBG:addChild(Spritescale)
        Spritescale:setAnchorPoint(0, 0.5)
        Spritescale:setPosition(3+(2*i-1)*(self.imgContainer_:getContentSize().width/15+0.2),
        loadBarProBG:getContentSize().height/2)
        if i<=4 then
            local numtext = 50*i
            display.newTTFLabel({
            text = tostring(numtext),
            size = 25,
            color = display.COLOR_WHITE
            })
            :align(display.CENTER,Spritescale:getContentSize().width/2,Spritescale:getContentSize().height/2-30)
            :addTo(Spritescale)
        else
            local numtext = 100*i-200
            display.newTTFLabel({
            text = tostring(numtext),
            size = 25,
            color = display.COLOR_WHITE
            })
            :align(display.CENTER,Spritescale:getContentSize().width/2,Spritescale:getContentSize().height/2-30)
            :addTo(Spritescale)
        end
    end

    if self.progress<=0.993 then
        if OutGameData:getTrophy()<=50 then
            self.loadBarPro_:setPercentage(self.progress)
        elseif OutGameData:getTrophy()<=200 then
            self.loadBarPro_:setPercentage((self.progress-1/44)*2+1/44)
        else
            self.loadBarPro_:setPercentage(self.progress+3/44)
        end
    else
        self.loadBarPro_:setPercentage(0.993)
    end
end

-- function BattleLayer:setImgStatus(status,index)
--     print(status)
--     self.imgStatus[index]=status
--     print(self.imgStatus[index])
-- end

return BattleLayer

