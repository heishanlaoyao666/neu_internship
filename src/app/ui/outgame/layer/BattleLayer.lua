--[[--
    战斗层
    BattleLayer.lua
]]
local BattleLayer = class("BattleLayer", require("app.ui.outgame.layer.BaseLayer"))
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local CurrentTowerLayer = require("app.ui.outgame.layer.CurrentTowerLayer")
local OutGameData = require("app.data.outgame.OutGameData")
local ObtainItemLayer = require("app.ui.outgame.layer.ObtainItemLayer")
--[[--
    构造函数

    @param none

    @return none
]]
function BattleLayer:ctor()
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
    local sprite = display.newSprite("artcontent/lobby(ongame)/battle_interface/basemap_interfaces.png")
    self.container_:addChild(sprite)
    sprite:setPosition(display.cx,display.cy)

    --对战模式按钮
    local button = ccui.Button:create("artcontent/lobby(ongame)/battle_interface/button_battlemode.png")
    self.container_:addChild(button)
    button:setAnchorPoint(0.5, 0.5)
    button:setPosition(width/2, height/2-30)
    button:addTouchEventListener(function(sender, eventType)
        -- ccui.TouchEventType
        if 2 == eventType then -- touch end
            -- body
            EventManager:doEvent(EventDef.ID.MATCH)
        end
    end)
    --已选队伍底图
    local sprite1 = display.newSprite("artcontent/lobby(ongame)/battle_interface/basemap_selectedteams.png")
    self.container_:addChild(sprite1)
    sprite1:setPosition(display.cx,200)
    CurrentTowerLayer:setContentSize(sprite1:getContentSize().width,sprite1:getContentSize().height)
    CurrentTowerLayer:new():addTo(sprite1)

    --天梯背景和ListView创建
    local sprite2 = display.newSprite("artcontent/lobby(ongame)/battle_interface/rank/basemap_rank.png")
    self.container_:addChild(sprite2)
    sprite2:setPosition(display.cx,display.cy+300)
    self.listcontainer_ =ccui.Layout:create()
    self.listcontainer_:setContentSize(sprite2:getContentSize().width-100, sprite2:getContentSize().height)
    self.listcontainer_:setAnchorPoint(0.5,0.5)
    self.listcontainer_:setPosition(sprite2:getContentSize().width/2,sprite2:getContentSize().height/2)
    self.listcontainer_:addTo(sprite2)

    local listView = ccui.ListView:create()
    local listcontainerSize=self.listcontainer_:getContentSize()
    -- listView:setBackGroundColor(cc.c3b(200, 0, 0))
    -- listView:setBackGroundColorType(1)
    listView:setContentSize(listcontainerSize.width, listcontainerSize.height+100)
    listView:setAnchorPoint(0.5, 0.5)
    listView:setPosition(listcontainerSize.width/2,listcontainerSize.height/2+50)
    listView:setDirection(2)
    listView:addTo(self.listcontainer_)
    listView:setBounceEnabled(true)
    self.imgstatus={}
    self.gold={}
    self.diamond={}
    for i=1,22 do
        self.imgstatus[i]=2
    end
    for i=1,22 do
        self.gold[i]=0
        self.diamond[i]=0
        self.imgcontainer_ =ccui.Layout:create()
        local img = ccui.Button:create("artcontent/lobby(ongame)/battle_interface/rank/locked_blueborder.png")
        img:setAnchorPoint(0,0.5)
        img:setPosition(50,img:getContentSize().height/2)
        -- self.imgcontainer_:setBackGroundColor(cc.c3b(200, 0, 0))
        -- self.imgcontainer_:setBackGroundColorType(1)
        self.imgcontainer_:addChild(img)
        self.imgcontainer_:setContentSize(img:getContentSize().width+50,img:getContentSize().height)
        self.imgcontainer_:setAnchorPoint(0.5,0.5)
        self.imgcontainer_:setPosition(sprite2:getContentSize().width/2,sprite2:getContentSize().height/2+100)
        self.imgcontainer_:addTo(listView)
        --宝箱内容
        if i==1 then
            self.content = display.newSprite("artcontent/lobby(ongame)/store/diamondstore/chest_legend.png")
            img:addChild(self.content)
            self.content:setScale(0.6)
            self.content:setAnchorPoint(0.5, 0.5)
            self.content:setPosition(img:getContentSize().width/2,img:getContentSize().height/2)
        elseif i==2 then
            self.content = display.newSprite("artcontent/lobby(ongame)/battle_interface/rank/gold.png")
            img:addChild(self.content)
            self.content:setAnchorPoint(0.5, 0.5)
            self.content:setPosition(img:getContentSize().width/2,img:getContentSize().height/2+20)
            display.newTTFLabel({
                text = "500",
                size = 25,
                color = display.COLOR_WHITE
            })
            :align(display.CENTER,img:getContentSize().width/2,img:getContentSize().height/2-30)
            :addTo(img)
            self.gold[i]=500
        elseif i<12 then
            self.content = display.newSprite("artcontent/lobby(ongame)/store/diamondstore/chest_epic.png")
            img:addChild(self.content)
            self.content:setScale(0.6)
            self.content:setAnchorPoint(0.5, 0.5)
            self.content:setPosition(img:getContentSize().width/2,img:getContentSize().height/2)
        elseif i==12 then
            self.content = display.newSprite("artcontent/lobby(ongame)/store/goldstore/itemicon_tower/13.png")
            img:addChild(self.content)
            self.content:setScale(0.5)
            --self.content:setContentSize(cc.size(60, 60))
            self.content:setAnchorPoint(0.5, 0.5)
            self.content:setPosition(img:getContentSize().width/2,img:getContentSize().height/2)
        elseif i==22 then
            self.content = display.newSprite("artcontent/lobby(ongame)/battle_interface/rank/group92.png")
            img:addChild(self.content)
            --self.content:setScale(0.5)
            --self.content:setContentSize(cc.size(60, 60))
            self.content:setAnchorPoint(0.5, 0.5)
            self.content:setPosition(img:getContentSize().width/2,img:getContentSize().height/2)
        elseif i%3==1 then
            self.content = display.newSprite("artcontent/lobby(ongame)/store/diamondstore/chest_epic.png")
            img:addChild(self.content)
            self.content:setScale(0.6)
            self.content:setAnchorPoint(0.5, 0.5)
            self.content:setPosition(img:getContentSize().width/2,img:getContentSize().height/2)
        elseif i%3==2 then
            self.content = display.newSprite("artcontent/lobby(ongame)/battle_interface/rank/diamonds.png")
            img:addChild(self.content)
            self.content:setAnchorPoint(0.5, 0.5)
            self.content:setPosition(img:getContentSize().width/2,img:getContentSize().height/2+20)
            display.newTTFLabel({
                text = "100",
                size = 25,
                color = display.COLOR_WHITE
            })
            :align(display.CENTER,img:getContentSize().width/2,img:getContentSize().height/2-30)
            :addTo(img)
            self.diamond[i]=100
        elseif i%3==0 then
            self.content = display.newSprite("artcontent/lobby(ongame)/battle_interface/rank/gold.png")
            img:addChild(self.content)
            self.content:setAnchorPoint(0.5, 0.5)
            self.content:setPosition(img:getContentSize().width/2,img:getContentSize().height/2+20)
            display.newTTFLabel({
                text = "1000",
                size = 25,
                color = display.COLOR_WHITE
            })
            :align(display.CENTER,img:getContentSize().width/2,img:getContentSize().height/2-30)
            :addTo(img)
            self.gold[i]=1000
        end

        self.spritelocked = display.newSprite("artcontent/lobby(ongame)/battle_interface/rank/locked.png")
        img:addChild(self.spritelocked)
        self.spritelocked:setAnchorPoint(0.5, 0)
        self.spritelocked:setPosition(img:getContentSize().width/2,-25)
        self.spritelocked:setVisible(true)
        self.spriteget = display.newSprite("artcontent/lobby(ongame)/battle_interface/rank/group130.png")
        img:addChild(self.spriteget)
        self.spriteget:setAnchorPoint(0.5, 0)
        self.spriteget:setPosition(img:getContentSize().width/2,-25)
        self.spriteget:setVisible(false)

        img:addTouchEventListener(function(sender, eventType)
            if 2 == eventType then -- touch end
                self.MatchLayer_=MatchLayer.new():addTo(self)
            end
        end)
        if self.imgstatus[i]==1 then
            --img:loadTextureNormal
        elseif self.imgstatus[i]==2 then
            local tempfilename="artcontent/lobby(ongame)/battle_interface/rank/unlocked_notclamide_yellowborder.png"
            img:loadTextureNormal(tempfilename)
            self.spritelocked:setVisible(false)
            img:addTouchEventListener(function(sender, eventType)
                if 2 == eventType then -- touch end
                    if i==1 then
                        ObtainItemLayer:SetData(6,3040)
                        EventManager:doEvent(EventDef.ID.OBTAINITEM)
                    elseif i==2 then
                        OutGameData:setGold(self.gold[i])
                        EventManager:doEvent(EventDef.ID.GAMEDATA_CHANGE)
                    elseif i<12 then
                        ObtainItemLayer:SetData(5,1280)
                        EventManager:doEvent(EventDef.ID.OBTAINITEM)
                    elseif i==12 then
                        OutGameData:choosePacks(OutGameData:getTower(13),1)
                        EventManager:doEvent(EventDef.ID.KNAPSACK_CHANGE)
                    elseif i==22 then
                        packs, packsnum=OutGameData:legendChests()
                        OutGameData:choosePacks(packs[8],packsnum[8])
                        EventManager:doEvent(EventDef.ID.KNAPSACK_CHANGE)
                    elseif i%3==1 then
                        ObtainItemLayer:SetData(5,1280)
                        EventManager:doEvent(EventDef.ID.OBTAINITEM)
                    elseif i%3==2 then
                        OutGameData:setDiamond(self.diamond[i])
                        EventManager:doEvent(EventDef.ID.GAMEDATA_CHANGE)
                    elseif i%3==0 then
                        OutGameData:setGold(self.gold[i])
                        EventManager:doEvent(EventDef.ID.GAMEDATA_CHANGE)
                    end
                end
            end)
        else
            img:loadTextureNormal("artcontent/lobby(ongame)/battle_interface/rank/available.png")
            self.spritelocked:setVisible(false)
            self.spriteget:setVisible(true)
            img:addTouchEventListener(function(sender, eventType)
                if 2 == eventType then -- touch end
                    print(3)
                end
            end)
        end

    end
    --进度条背景
    local loadBarProBG = cc.Sprite:create("artcontent/lobby(ongame)/battle_interface/rank/sacle/scale_ruler.png")
    loadBarProBG:setScale(self.imgcontainer_:getContentSize().width*22/loadBarProBG:getContentSize().width,1)
    loadBarProBG:setAnchorPoint(0,0)
    loadBarProBG:pos(0, 50)
    listView:addChild(loadBarProBG)

   --进度条
   local tempfilename="artcontent/lobby(ongame)/battle_interface/rank/sacle/rectangle_1.png"
   self.loadBarPro_ = cc.ProgressTimer:create(cc.Sprite:create(tempfilename))
   self.loadBarPro_:setScale(14.41,1)
   self.loadBarPro_:setAnchorPoint(0, 0.5)
   self.loadBarPro_:setType(cc.PROGRESS_TIMER_TYPE_BAR)--从左到右
   self.loadBarPro_:setMidpoint(cc.p(0, 0))
   self.loadBarPro_:setBarChangeRate(cc.p(1, 0))
   self.loadBarPro_:pos(3, loadBarProBG:getContentSize().height/2+1)
   self.loadBarPro_:setPercentage(0)
   loadBarProBG:addChild(self.loadBarPro_)

   local spritekey = display.newSprite("artcontent/lobby(ongame)/battle_interface/rank/sacle/key.png")
   spritekey:setScale(loadBarProBG:getContentSize().width/self.imgcontainer_:getContentSize().width/22,1)
   loadBarProBG:addChild(spritekey)
   spritekey:setAnchorPoint(0, 0.5)
   spritekey:setPosition(0,loadBarProBG:getContentSize().height/2)

    for i=1,22 do
        local spritescale = display.newSprite("artcontent/lobby(ongame)/battle_interface/rank/sacle/scale.png")
        spritescale:setScale(loadBarProBG:getContentSize().width/self.imgcontainer_:getContentSize().width/22,1)
        loadBarProBG:addChild(spritescale)
        spritescale:setAnchorPoint(0, 0.5)
        spritescale:setPosition(3+(2*i-1)*(self.imgcontainer_:getContentSize().width/15+0.2),
        loadBarProBG:getContentSize().height/2)
        if i<=4 then
            local numtext = 50*i
            display.newTTFLabel({
            text = tostring(numtext),
            size = 25,
            color = display.COLOR_WHITE
            })
            :align(display.CENTER,spritescale:getContentSize().width/2,spritescale:getContentSize().height/2-30)
            :addTo(spritescale)
        else
            local numtext = 100*i-200
            display.newTTFLabel({
            text = tostring(numtext),
            size = 25,
            color = display.COLOR_WHITE
            })
            :align(display.CENTER,spritescale:getContentSize().width/2,spritescale:getContentSize().height/2-30)
            :addTo(spritescale)
        end
    end

    self.progress=cc.UserDefault:getInstance():getIntegerForKey("奖杯数")*1/2200
    for i=1,4 do
        if i*50<=cc.UserDefault:getInstance():getIntegerForKey("奖杯数") and self.imgstatus[i]==1 then
            self.imgstatus[i]=22
        end
    end
    for i=5,22 do
        if (i*100-200)<=cc.UserDefault:getInstance():getIntegerForKey("奖杯数") and self.imgstatus[i]==1 then
            self.imgstatus[i]=2
        end
    end

    if self.progress<=0.993 then
        if cc.UserDefault:getInstance():getIntegerForKey("奖杯数")<=50 then
            self.loadBarPro_:setPercentage(self.progress)
        elseif cc.UserDefault:getInstance():getIntegerForKey("奖杯数")<=200 then
            self.loadBarPro_:setPercentage((self.progress-1/44)*2+1/44)
        else
            self.loadBarPro_:setPercentage(self.progress+3/44)
        end
    else
        self.loadBarPro_:setPercentage(0.993)
    end

end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function BattleLayer:update(dt)
end

return BattleLayer

