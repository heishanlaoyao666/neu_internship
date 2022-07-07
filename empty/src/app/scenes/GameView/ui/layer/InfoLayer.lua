--[[--
    信息层
    InfoLayer.lua
]]
local InfoLayer = class("InfoLayer", require("app/scenes/GameView/ui/layer/BaseLayer.lua"))
local RandomBossView = require("app/scenes/GameView/ui/RandomBossView.lua")
local ConstDef = require("app/def/ConstDef.lua")
local GameData = require("app/data/GameData.lua")
local EventManager = require("app/manager/EventManager.lua")
local EventDef     = require("app/def/EventDef.lua")
local TowerDef     = require("app.def.TowerDef")

local player = nil
--本地函数定义
local timeChange
--[[--
    构造函数

    @param none

    @return none
]]
function InfoLayer:ctor()
    InfoLayer.super.ctor(self)

    self.spLabel_ = nil -- 类型：TTF，sp点数
    self.mynameLabel_ = nil -- 类型：TTF，我方名字
    self.mylife_ = {} -- 类型：table，我方生命
    self.oppositenameLabel_ = nil -- 类型：TTF，敌方名字
    self.oppositelife_ = {} -- 类型：table，敌方生命
    self.timeremainingLaber_ = nil -- 类型：TTF，剩余时间

    self.randomBossView = nil --类型:RandomBossView.lua,随机boss场景

    self:initView()
end

--[[--
    界面初始化
    
    @param none

    @return none
]]
function InfoLayer:initView()
    player= GameData:getPlayer()
    local width, height = display.width, display.height
    self.container_ = ccui.Layout:create()
    --self.container_:setBackGroundColor(cc.c3b(200, 0, 0))
    --self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(display.width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0)
    self.container_:setPosition(display.cx, 0)

    --塔生成按钮
    local createBtn = ccui.Button:create("ui/battle/Battle interface/button-create.png")
    self.container_:addChild(createBtn)
    createBtn:setAnchorPoint(0.5, 0.5)
    createBtn:setPosition(display.width*0.5, 180)
    createBtn:addTouchEventListener(function(sender, eventType)
        if eventType == 2 then
            player:createTower()
        end
    end)
    self.createTTF = cc.Label:createWithTTF(player:getSpCost(),"ui/font/fzbiaozjw.ttf",24)
    self.createTTF:addTo(createBtn)
    self.createTTF:setAnchorPoint(0.5,0)
    self.createTTF:setPosition(createBtn:getContentSize().width*0.5,0)

    --剩余sp点数
    local sp = ccui.ImageView:create("ui/battle/Battle interface/bg-sp.png")
    sp:setAnchorPoint(0.5, 0.5)
    sp:setPosition(180, 180)
    self.container_:addChild(sp)

    self.spLabel_ = cc.Label:createWithTTF(player:setSp(0),"ui/font/fzbiaozjw.ttf",24)
    self.spLabel_:setAnchorPoint(0.5, 0.5)
    self.spLabel_:setPosition(190, 180)
    self.container_:addChild(self.spLabel_)

    --投降按钮
    local surrenderBtn = ccui.Button:create("ui/battle/Battle interface/button-surrender.png")
    self.container_:addChild(surrenderBtn)
    surrenderBtn:setAnchorPoint(1, 0.5)
    surrenderBtn:setPosition(display.width-40, 720)
    surrenderBtn:addTouchEventListener(function(sender, eventType) 
        if eventType == 2 then
            EventManager:doEvent(EventDef.ID.VIEW_OPEN,ConstDef.GAME_VIEW.SURRENDER)
        end
    end)
    --我方昵称
    local myname = ccui.ImageView:create("ui/battle/Battle interface/my-name.png")
    myname:setAnchorPoint(0.5, 0.5)
    myname:setPosition(540, 180)
    self.container_:addChild(myname)
    self.mynameLabel_ = cc.Label:createWithTTF(666,"ui/font/fzbiaozjw.ttf",20)
    self.mynameLabel_:setAnchorPoint(0.5, 0.5)
    self.mynameLabel_:setPosition(540, 150)
    self.mynameLabel_:enableOutline(cc.c4b(0,0,0,255), 2)
    self.container_:addChild(self.mynameLabel_)

    --敌方昵称
    local oppositename = ccui.ImageView:create("ui/battle/Battle interface/my-name.png")
    oppositename:setAnchorPoint(0.5, 0.5)
    oppositename:setPosition(180, 1220)
    self.container_:addChild(oppositename)
    self.oppositenameLabel_ = cc.Label:createWithTTF(666,"ui/font/fzbiaozjw.ttf",20)
    self.oppositenameLabel_:setAnchorPoint(0.5, 0.5)
    self.oppositenameLabel_:setPosition(180, 1190)
    self.oppositenameLabel_:enableOutline(cc.c4b(0,0,0,255), 2)
    self.container_:addChild(self.oppositenameLabel_)
    --我方塔阵容
    for i = 1, 5 do
        local towerBtn = self:towerInfo(i)
        towerBtn:setPosition(180,100)
        self.container_:addChild(towerBtn)
    end
    --剩余时间
    --BOSS初始化
    if GameData:getGameState() == ConstDef.GAME_STATE.INIT then
        EventManager:doEvent(EventDef.ID.VIEW_OPEN,ConstDef.GAME_VIEW.RANDOMBOSS)
        self.randomBossView=RandomBossView.new()
        self:addChild(self.randomBossView)
    end
    --开始初始化
    self:Initdate("111","222",10,3,120)
end
--[[--
    BOSS按钮创建
    @param  none

    @return none
]]
function InfoLayer:BossBtnCreate()
    --boss按钮创建
    
    local opposite_type =GameData:getGameOpposite()
    if opposite_type~=ConstDef.GAME_TYPE.NET then
        local bossBtn = ccui.Button:create("ui/battle/Battle interface/Button-Boss/boss-"..tonumber(opposite_type)..".png")
        bossBtn:setAnchorPoint(0.5, 0.5)
        bossBtn:setPosition(220, 720)
        bossBtn:addTo(self)
        bossBtn:addTouchEventListener(function(sender, eventType) 
            if eventType == 2 then
                EventManager:doEvent(EventDef.ID.VIEW_OPEN,ConstDef.GAME_VIEW.OPPOSITEBOSS)
            end
        end)
    end
    GameData:setGameState(ConstDef.GAME_STATE.PLAY)
    self:removeChild(self.randomBossView)
    self.randomBossView=nil
end
--[[--
    界面数据初始化

    @param myname 类型：string，我方名字
    @param oppositename 类型：string，敌方名字
    @param mylife 类型：number，我方生命
    @param oppositelife 类型：number，敌方生命
    @param time 类型：number，游戏时间

    @return none
]]
function InfoLayer:Initdate(myname,oppositename,mylife,oppositelife,time)
    self.mynameLabel_:setString(tostring(myname))
    self.oppositenameLabel_:setString(tostring(oppositename))
    --我方生命值
    for i = 1, mylife do
        local img=display.newSprite("ui/battle/Battle interface/life-true.png")
        img:setAnchorPoint(0.5,0.5)
        img:setPosition(i*42-10,760)
        self.mylife_[#self.mylife_+1] = img
        self.container_:addChild(img)
    end
    --敌方生命值
    for i = 1, oppositelife do
        local img=display.newSprite("ui/battle/Battle interface/life-true.png")
        img:setAnchorPoint(0.5,0.5)
        img:setPosition(720-i*42,660)
        self.mylife_[#self.mylife_+1] = img
        self.container_:addChild(img)
    end
    --游戏时间
    self.timeremainingLaber_ = cc.Label:createWithTTF(timeChange(time),"ui/font/fzbiaozjw.ttf",30)
    self.container_:addChild(self.timeremainingLaber_)
    self.timeremainingLaber_:setAnchorPoint(0.5,0)
    self.timeremainingLaber_:setPosition(display.cx,700)
    self.timeremainingLaber_:enableOutline(cc.c4b(0,0,0,255), 2)
end
--[[--
    时间转换
    @param time 类型：number，时间

    @return timeStr 类型：string，时间文本
]]
function timeChange(time)
    local timeStr ="剩余时间:"
    timeStr=string.format("剩余时间:%02d:%02d",time/60,time%60)
    return timeStr
end
--[[--
    创建一个towerInfo
    @param id 类型:number 塔id

    @return btn
]]
function InfoLayer:towerInfo(id)
    --类型:table 塔信息 .id_(塔id) .level_(塔等级) .grade_(塔强化等级)
    local tower=player:getTowerArray()[id]

    local towerBtn=ccui.Button:create(string.format("ui/battle/Battle interface/Tower/tower_%u.png",tower.id_))
    towerBtn:setAnchorPoint(0.5, 0)
    towerBtn:addTouchEventListener(function(sender, eventType)
        if eventType == 2 then
            print("执行升级")
            player:upTowerGrade(tower.id_)
            print("升级结束")
            updateUI()
        end
    end)
    --强化等级信息
    local img=display.newSprite(string.format("ui/battle/Battle interface/Grade/LV.%u.png",tower.grade_))
    img:setAnchorPoint(0.5,1)
    img:setPosition(50,0)
    img:setScale(1.5)
    towerBtn:addChild(img)
    --强化等级所需费用
    local sp = ccui.ImageView:create("ui/battle/Battle interface/bg-sp.png")
    sp:setAnchorPoint(0.5, 0.5)
    sp:setPosition(180, 180)
    self.container_:addChild(sp)

    self.spLabel_ = cc.Label:createWithTTF(player:setSp(0),"ui/font/fzbiaozjw.ttf",24)
    self.spLabel_:setAnchorPoint(0.5, 0.5)
    self.spLabel_:setPosition(190, 180)
    self.container_:addChild(self.spLabel_)
    --角标
    local res = "ui/battle/Battle interface/Angle sign-Tower_type/TowerType-"
    local as_tt= display.newSprite(string.format(res..TowerDef.TABLE[tower.id_].TYPE..".png"))

    as_tt:setAnchorPoint(0.5,0.5)
    as_tt:setPosition(80,85)
    towerBtn:addChild(as_tt)

    function updateUI()
        print("更新执行")
        local newtower=player:getTowerArray()[id]
        print(newtower.grade_)
        img:setTexture(string.format(string.format("ui/battle/Battle interface/Grade/LV.%u.png",newtower.grade_)))

    end
    return towerBtn
end
--[[--
    界面刷新
    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function InfoLayer:update(dt)
    if self.randomBossView then
        self.randomBossView:update(dt)
    end
    self.spLabel_:setString(player:setSp(0))
    self.createTTF:setString(player:getSpCost())
    -- self.lifeLabelBmf_:setString(tostring(GameData:getLife()))
    -- self.scoreLabelBmf_:setString(tostring(GameData:getScore()))

end

--[[--
    节点进入

    @param none

    @return none
]]
function InfoLayer:onEnter()
    
end

--[[--
    节点退出

    @param none

    @return none
]]
function InfoLayer:onExit()
end
return InfoLayer

