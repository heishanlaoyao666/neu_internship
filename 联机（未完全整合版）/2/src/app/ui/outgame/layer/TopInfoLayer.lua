--[[--
    顶部信息层
    TopInfoLayer.lua
]]
local TopInfoLayer = class("TopInfoLayer", require("app.ui.outgame.layer.BaseLayer"))
local OutGameData = require("app.data.outgame.OutGameData")
local PortraitSelectionView = require("app.ui.outgame.view.PortraitSelectionView")
local OutgameMsg = require("app.msg.OutgameMsg")
local MsgController= require("app.msg.MsgController")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
--[[--
    构造函数

    @param none

    @return none
]]
function TopInfoLayer:ctor()
    TopInfoLayer.super.ctor(self)
    cc.UserDefault:getInstance():setStringForKey("昵称","久妹")
    --cc.UserDefault:getInstance():setIntegerForKey("奖杯数",200)

    self.portraitSelectionView_=nil --头像选择界面
    self.container_ = nil -- 类型：Layout，控件容器
    self.avatarBtn_=nil --类型：Button，头像按钮
    self.name=nil  --类型：TTF，玩家昵称文本
    self.trophynum=nil --类型：TTF，奖杯数文本
    self.goldcoinnum=nil --类型：TTF，金币数文本
    self.diamondsnnum=nil --类型：TTF，钻石数文本
    self.account=cc.UserDefault:getInstance():getStringForKey("account")
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function TopInfoLayer:initView()
    local width, height = display.width, 80
    local tempfilename
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 1)
    self.container_:setPosition(display.cx, display.height)

    --底图S
    local baseTopTbarSprite = display.newSprite("artcontent/lobby_ongame/topbar_playerinformation/base_topbar.png")
    self.container_:addChild(baseTopTbarSprite)
    baseTopTbarSprite:setContentSize(width, height)
    baseTopTbarSprite:setAnchorPoint(0.5, 1)
    baseTopTbarSprite:setPosition(width / 2, 0)

    --昵称底图
    local baseNicknameSprite = display.newSprite("artcontent/lobby_ongame/topbar_playerinformation/base_nickname.png")
    self.container_:addChild(baseNicknameSprite)
    baseNicknameSprite:setContentSize(width / 2, height / 2)
    baseNicknameSprite:setAnchorPoint(0.5, 1)
    baseNicknameSprite:setPosition(width / 2 - 50, 0)

    --默认头像
    self.avatarBtn_ = ccui.Button:create("artcontent/lobby_ongame/topbar_playerinformation/default_avatar.png")
    self.container_:addChild(self.avatarBtn_)
    self.avatarBtn_:setAnchorPoint(0.5, 1)
    self.avatarBtn_:setPosition(width / 2 - 280, height / 2 + 20)

    self.avatarBtn_:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                self.portraitSelectionView_=PortraitSelectionView:new():addTo(self)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_click.OGG",false)
                end
            end
        end
    )

    --砖石和金币底图
    tempfilename="artcontent/lobby_ongame/topbar_playerinformation/base_Diamonds&goldcoins.png"
    local baseMoneySprite =display.newSprite(tempfilename)
    self.container_:addChild(baseMoneySprite)
    --baseMoneySprite:setScale(0.4)
    baseMoneySprite:setAnchorPoint(0.5, 1)
    baseMoneySprite:setPosition(width / 2 + 190, 50)
    local baseMoneyContentSize= baseMoneySprite:getContentSize()

    --金币
    local goldSprite = display.newSprite("artcontent/lobby_ongame/topbar_playerinformation/goldcoin.png")
    self.container_:addChild(goldSprite)
    --sprite3:setContentSize(width, height)
    goldSprite:setAnchorPoint(0.5, 1)
    goldSprite:setPosition(width / 2 + 120, 50)
    self.goldcoinnum=display.newTTFLabel({
		text = "0",
        size = 25,
        color = display.COLOR_WHITE
	})
	:align(display.LEFT_CENTER,baseMoneyContentSize.width/2-50,baseMoneyContentSize.height/2)
	:addTo(baseMoneySprite)

    --砖石和金币底图
    local baseMoneySprite1 = display.newSprite(tempfilename)
    self.container_:addChild(baseMoneySprite1)
    baseMoneySprite1:setAnchorPoint(0.5, 1)
    baseMoneySprite1:setPosition(width / 2 + 190, 0)

    --砖石
    local diamondsSprite = display.newSprite("artcontent/lobby_ongame/topbar_playerinformation/diamonds.png")
    self.container_:addChild(diamondsSprite)
    diamondsSprite:setAnchorPoint(0.5, 1)
    diamondsSprite:setPosition(width / 2 + 120, 0)
    self.diamondsnnum=display.newTTFLabel({
		text = "0",
        size = 25,
        color = display.COLOR_WHITE
	})
	:align(display.LEFT_CENTER,baseMoneyContentSize.width/2-50,baseMoneyContentSize.height/2)
	:addTo(baseMoneySprite1)

    --菜单按钮
    local menuBtn = ccui.Button:create("artcontent/lobby_ongame/topbar_playerinformation/button_menu.png")
    self.container_:addChild(menuBtn)
    menuBtn:setAnchorPoint(0.5, 1)
    menuBtn:setPosition(width / 2 + 310, 40)

    menuBtn:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                require("src/app/ui/outgame/layer/MenuLayer.lua"):new():addTo(self)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_click.OGG",false)
                end
            end
        end
    )


    self.name=display.newTTFLabel({
		text = "九妹",
        size = 30,
        color = display.COLOR_WHITE
	})
	:align(display.LEFT_CENTER, 20,baseNicknameSprite:getContentSize().height/2+50)
	:addTo(baseNicknameSprite)

    --奖杯
    local trophySprite = display.newSprite("artcontent/lobby_ongame/topbar_playerinformation/trophy.png")
    baseNicknameSprite:addChild(trophySprite)
    --sprite8:setContentSize(width / 2, height / 2)
    trophySprite:setAnchorPoint(0.5, 0)
    trophySprite:setPosition(40,baseNicknameSprite:getContentSize().height/2-10)
    self.trophynum=display.newTTFLabel({
		text = "0",
        size = 25,
        color = cc.c3b(255, 215, 0)
	})
	:align(display.LEFT_CENTER, 70,baseNicknameSprite:getContentSize().height/2+5)
    :addTo(baseNicknameSprite)
    --数据信息
    self.name:setString(cc.UserDefault:getInstance():getStringForKey("昵称"))
    --self.trophynum:setString(tostring(OutGameData:getTrophy()))
    --self.goldcoinnum:setString(tostring(OutGameData:getGold()))
    --self.diamondsnnum:setString(tostring(OutGameData:getDiamond()))
    OutgameMsg:getData(self.account,"financeData")
    OutgameMsg:getData(self.account,"achieveData")
    OutgameMsg:getData(self.account,"towerData")
    OutgameMsg:getData(self.account,"lineupData")
end

function TopInfoLayer:onEnter()
    MsgController:registerListener(self, handler(self, self.handleMsg))
end

function TopInfoLayer:onExit()
    MsgController:unregisterListener(self)
end
function TopInfoLayer:handleMsg(msg)
    print("self.account=")
    print("self.account="..self.account)
    if msg.financeData~=nil then
        print("financeData")
        if OutGameData:getState()==2 then
            self.goldcoinnum:setString(tostring(OutGameData:getGold()))
            self.diamondsnnum:setString(tostring(OutGameData:getDiamond()))
            self.trophynum:setString(tostring(OutGameData:getTrophy()))
            local data1={gold=OutGameData:getGold(),
            diamond=OutGameData:getDiamond(),
            trophyAmount=OutGameData:getTrophy()}
            OutgameMsg:sendData(self.account,"financeData",data1)
        else
            self.goldcoinnum:setString(tostring(msg.financeData.gold))
            self.diamondsnnum:setString(tostring(msg.financeData.diamond))
            self.trophynum:setString(tostring(msg.financeData.trophyAmount))
            OutGameData:setGold(msg.financeData.gold)
            OutGameData:setDiamond(msg.financeData.diamond)
            OutGameData:setTrophy(msg.financeData.trophyAmount)
            OutGameData:setState()
            EventManager:doEvent(EventDef.ID.BATTLE)
        end
    end
    if msg.achieveData~=nil then
        print("achieveData")
        if cc.UserDefault:getInstance():getIntegerForKey("imgstatus")==2 then
            local data2={rankObjectAmount={}}
            for i=1,22 do
                data2.rankObjectAmount[i]= cc.UserDefault:getInstance():getIntegerForKey("imgstatus"..i)
            end
            OutgameMsg:sendData(self.account,"achieveData",data2)
            cc.UserDefault:getInstance():setIntegerForKey("imgstatus",1)
        else
            for i=1,22 do
                cc.UserDefault:getInstance():setIntegerForKey("imgstatus"..i,msg.achieveData.rankObjectAmount[i])
            end
            --cc.UserDefault:getInstance():setIntegerForKey("imgstatus",1)
            EventManager:doEvent(EventDef.ID.BATTLE)
        end
    end
    if msg.towerData~=nil then
        for i=1,#msg.towerData.id do
            OutGameData:choosePacks(OutGameData:getTower(msg.towerData.id[i]),msg.towerData.num[i])
            OutGameData:getTower(msg.towerData.id[i]):setLevel(msg.towerData.level[i])
            OutGameData:initTowerByLevel(msg.towerData.id[i],msg.towerData.level[i])
        end
        cc.UserDefault:getInstance():setIntegerForKey("towerData",2)
        EventManager:doEvent(EventDef.ID.BATTLE)
        EventManager:doEvent(EventDef.ID.KNAPSACK_CHANGE)
    end
    if msg.lineupData~=nil then
        for i=1,3 do
            for j=1,5 do
                cc.UserDefault:getInstance():setIntegerForKey("current" .. j .. i,msg.lineupData.lineup[i*5-5+j])
            end
        end
        --EventManager:doEvent(EventDef.ID.BATTLE)
    end
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]

function TopInfoLayer:setSprite1(filename)
    -- body
    self.avatarBtn_:loadTextureNormal(filename)
end

function TopInfoLayer:setData()
    -- body
    self.name:setString(cc.UserDefault:getInstance():getStringForKey("昵称"))
    OutgameMsg:getData(self.account,"financeData")
    OutgameMsg:getData(self.account,"achieveData")
end

function TopInfoLayer:update(dt)
end

return TopInfoLayer
