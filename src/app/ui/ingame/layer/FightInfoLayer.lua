--[[--
    背景层
    FightingInfoLayer.lua
]]
local FightingInfoLayer = class("FightingInfoLayer", require("app.ui.ingame.layer.BaseLayer"))
local GameData = require("app.data.ingame.GameData")

local myPoint_ = {} -- 存储我方生命图标
local enemyPoint_ = {} -- 存储敌方生命图标

--[[--
    构造函数

    @param none

    @return none
]]
function FightingInfoLayer:ctor()
    FightingInfoLayer.super.ctor(self)

    self.latency_ = nil -- 网络延迟
    self.latencyNum_ = nil -- 延迟
    self.enemyName_ = nil -- 敌人名称
    self.myName_ = nil -- 我方昵称
    self.sumSpNum_ = nil --sp总数

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function FightingInfoLayer:initView()
    local width, height = display.width, display.height

    local myContainer = ccui.Layout:create()
    myContainer:setContentSize(width, height)
    myContainer:setAnchorPoint(0.5, 1)
    myContainer:setPosition(display.cx, height / 2)
    myContainer:addTo(self)

    local emenyContainer = ccui.Layout:create()
    emenyContainer:setContentSize(width, height)
    emenyContainer:setAnchorPoint(0.5, 0)
    emenyContainer:setPosition(display.cx, height / 2)
    emenyContainer:addTo(self)

    --网络延迟
    self.latency_ = ccui.ImageView:create("artcontent/battle(ongame)/battle_interface/networkdelay/delay_low.png")
    --self.latency_:loadTexture("battle(ongame)/battle_interface/networkdelay/delay_high.png") -- 改变图片
    self.latency_:setPosition(50, display.cy + 50)
    self.latency_:addTo(self)

    --延迟
    self.latencyNum_ = ccui.Text:create("17ms", "artcontent/font/fzbiaozjw.ttf", 20)
    self.latencyNum_:setColor(cc.c3b(0, 255, 0))
    self.latencyNum_:setPosition(50, display.cy + 30)
    self.latencyNum_:addTo(self)

    --认输
    local adBtn = ccui.Button:create("artcontent/battle(ongame)/battle_interface/button_admitdefeat.png")
    adBtn:addTouchEventListener(function (sender, eventType)
        if eventType == 2 then
            print("认输")
        end
    end)
    adBtn:setPosition(display.right - 110, display.cy + 60)
    adBtn:addTo(self)

    --sp总数底图
    local sumSpSprite = cc.Sprite:create("artcontent/battle(ongame)/battle_interface/basemap_sp.png")
    sumSpSprite:setPosition(display.cx - 180, display.cy + 240)
    sumSpSprite:addTo(myContainer)

    --sp总数数值
    self.sumSpNum_ = ccui.Text:create("100", "artcontent/font/fzbiaozjw.ttf", 26)
    self.sumSpNum_:setAnchorPoint(0.1, 0.5)
    self.sumSpNum_:setPosition(display.cx - 180, display.cy + 240)
    self.sumSpNum_:addTo(myContainer)

    --敌方标记
    local enemySprite = cc.Sprite:create("artcontent/battle(ongame)/battle_interface/oppositemark.png")
    enemySprite:setPosition(160, display.cy - 120)
    enemySprite:addTo(emenyContainer)

    --敌人昵称
    self.enemyName_ = ccui.Text:create("robot","artcontent/font/fzbiaozjw.ttf", 24)
    self.enemyName_:setPosition(160, display.cy - 160)
    self.enemyName_:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 描边
    self.enemyName_:enableShadow(cc.c3b(0, 0, 0), cc.size(0, 1), 1) -- 加阴影
    self.enemyName_:addTo(emenyContainer)

    --我方标记
    local mySprite = cc.Sprite:create("artcontent/battle(ongame)/battle_interface/ourmark.png")
    mySprite:setPosition(display.cx + 180, display.cy + 260)
    mySprite:addTo(myContainer)

    --我方昵称
    self.myName_ = ccui.Text:create("刘少无敌", "artcontent/font/fzbiaozjw.ttf", 24)
    self.myName_:setPosition(display.cx + 180, display.cy + 220)
    self.myName_:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 描边
    self.myName_:enableShadow(cc.c3b(0, 0, 0), cc.size(0, 1), 1) -- 加阴影
    self.myName_:addTo(myContainer)

    --我方生命
    local index_x = 320
    for i = 1, 3 do
        local pointSprite = ccui.ImageView:create("artcontent/battle(ongame)/battle_interface/hp_full.png")
        pointSprite:setPosition(display.cx + index_x, display.top + 10)
        index_x = index_x - 50
        pointSprite:addTo(myContainer)
        table.insert(myPoint_, i, pointSprite)
    end

    --敌方生命
    index_x = 150
    for i = 1, 3 do
        local pointSprite = ccui.ImageView:create("artcontent/battle(ongame)/battle_interface/hp_full.png")
        pointSprite:setPosition(index_x, display.bottom + 80)
        index_x = index_x - 50
        pointSprite:addTo(emenyContainer)
        table.insert(enemyPoint_, i, pointSprite)
    end
end

--[[--
    刷新生命

    @param none

    @return none
]]
function FightingInfoLayer:updatePoint()
    local myPoint = GameData:getMyPoint()
    local enemyPoint = GameData:getEnemyPoint()
    if myPoint < 3 then
        myPoint_[myPoint + 1]:loadTexture("artcontent/battle(ongame)/battle_interface/hp_empty.png")
    end
    if enemyPoint < 3 then
        enemyPoint_[enemyPoint + 1]:loadTexture("artcontent/battle(ongame)/battle_interface/hp_empty.png")
    end
end

--[[--
    帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function FightingInfoLayer:update(dt)
    self.sumSpNum_:setString(GameData:getSumSp())
    self:updatePoint()
end

return FightingInfoLayer