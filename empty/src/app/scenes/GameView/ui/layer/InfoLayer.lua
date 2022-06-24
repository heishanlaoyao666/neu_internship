--[[--
    信息层
    InfoLayer.lua
]]
local InfoLayer = class("InfoLayer", require("app/scenes/GameView/ui/layer/BaseLayer.lua"))
local ConstDef = require("app/def/ConstDef.lua")
local GameData = require("app/data/GameData.lua")
local EventManager = require("app/manager/EventManager.lua")
local EventDef     = require("app/def/EventDef.lua")
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
    self:initView()
end

--[[--
    界面初始化
    
    @param none

    @return none
]]
function InfoLayer:initView()
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
            print("塔生成")
        end
    end)
    local createTTF = cc.Label:createWithTTF(20,"ui/font/fzbiaozjw.ttf",24)
    createTTF:addTo(createBtn)
    createTTF:setAnchorPoint(0.5,0)
    createTTF:setPosition(createBtn:getContentSize().width*0.5,0)

    --剩余sp点数
    local sp = ccui.ImageView:create("ui/battle/Battle interface/bg-sp.png")
    sp:setAnchorPoint(0.5, 0.5)
    sp:setPosition(180, 180)
    self.container_:addChild(sp)

    self.spLabel_ = cc.Label:createWithTTF(200,"ui/font/fzbiaozjw.ttf",24)
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
    

    self:Initdate("111","222",10,3,120)
    --剩余时间
    
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
    --boss按钮创建
    local opposite_type =GameData:getGameOpposite()
    if opposite_type~=ConstDef.GAME_TYPE.NET then
        local bossBtn = ccui.Button:create("ui/battle/Battle interface/Button-Boss/boss-"..tonumber(opposite_type)..".png")
        bossBtn:setAnchorPoint(0.5, 0.5)
        bossBtn:setPosition(220, 720)
        self.container_:addChild(bossBtn)
        bossBtn:addTouchEventListener(function(sender, eventType) 
            if eventType == 2 then
                EventManager:doEvent(EventDef.ID.VIEW_OPEN,ConstDef.GAME_VIEW.OPPOSITEBOSS)
            end
        end)
    end
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
    界面刷新
    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function InfoLayer:update(dt)
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

