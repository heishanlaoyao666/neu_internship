--[[--
    背景层
    FightingInfoLayer.lua
]]
local FightingInfoLayer = class("FightingInfoLayer", require("app.ui.ingame.layer.BaseLayer"))
local GameData = require("app.data.ingame.GameData")
local ConstDef = require("app.def.ingame.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

local myPoint_ = {} -- 存储我方生命图标
local enemyPoint_ = {} -- 存储敌方生命图标

--角标映射
local angelMark = {
    "artcontent/battle_ongame/battle_interface/angelmark_towertype/towertype_tapping.png",
    "artcontent/battle_ongame/battle_interface/angelmark_towertype/towertype_disturbance.png",
    "artcontent/battle_ongame/battle_interface/angelmark_towertype/towertype_sup.png",
    "artcontent/battle_ongame/battle_interface/angelmark_towertype/towertype_control.png"
}
--boss名称
local bossName = {
    "BOSS-01",
    "BOSS-02",
    "BOSS-03",
    "BOSS-04"
}
--boss介绍
local bossIntroduction = {
    "将所有防御塔变形。星级不变，种类随机变化。",
    "每隔7秒沉默两个防御塔, 使其不能攻击, 直到BOSS被杀死。",
    "出场时使所有防御塔降低一星，一星防御塔直接被摧毁，行进过程中每隔一段时间会向前方高速移动一次。",
    "不受控制效果影响，在血量为75%、50%、25%时会召唤普通怪物三个，召唤期间无敌。"
}

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

    self.enemyLineup_ = {} -- 敌方阵容
    self.introduction_ = {}
    self.isVisible_ = {}

    self.bossBtn_ = nil
    self.nextBossId_ = 0
    self.bossSprite_ = nil
    self.bossImage_ = nil
    self.bossName_ = nil
    self.bossIntroduction_ = nil

    self.bossIntroIsVisable_ = 0

    self.time_ = nil

    self:init()
    self:enemyInitView()
    self:initView()
    self:bossInfo()

    self:registerScriptHandler(function(event)
        if event == "enter" then
            self:onEnter()
        elseif event == "exit" then
            self:onExit()
        end
    end)
end

--[[--
    用于制作测试数据

    @parm none

    @return none
]]
function FightingInfoLayer:init()
    self.enemyLineup_ = GameData:getEnemyTowers()
    self.nextBossId_ = GameData:getNextBossId()
end


--[[--
    敌方阵营

    @parm none

    @return none
]]
function FightingInfoLayer:enemyInitView()
    local index_x = 250
    for i = 1, #self.enemyLineup_ do
        --技能介绍背景
        local spriteRes = "artcontent/battle_ongame/squaretower_informationpopup/basemap_popup.png"
        local introductionSprite = cc.Sprite:create(spriteRes)
        introductionSprite:setVisible(false)
        introductionSprite:setPosition(display.cx - index_x, -300)
        introductionSprite:setScale(1.5)
        table.insert(self.isVisible_, i, 0)
        table.insert(self.introduction_, i, introductionSprite)

        --名字
        local name = self.enemyLineup_[i]:getTowerName()
        local nameText = ccui.Text:create(name, "artcontent/font/fzbiaozjw.ttf", 26)
        nameText:setPosition(270, 220)
        nameText:addTo(introductionSprite)

        --稀有度
        local rarity = self.enemyLineup_[i]:getTowerRarity()
        local rarityText = ccui.Text:create("", "artcontent/font/fzbiaozjw.ttf", 26)
        if rarity == 1 then
            rarityText:setString("普通")
        elseif rarity == 2 then
            rarityText:setString("稀有")
        elseif rarity == 3 then
            rarityText:setString("史诗")
        elseif rarity == 4 then
            rarityText:setString("传奇")
        end
        rarityText:setPosition(470, 220)
        rarityText:addTo(introductionSprite)

        --侧边大图
        spriteRes = "artcontent/lobby_ongame/atlas_interface/tower_detailpopup/static_bigtower/sec_tower_%d.png"
        local sprite = string.format(spriteRes, self.enemyLineup_[i]:getTowerId())
        local bigSprite = cc.Sprite:create(sprite)
        bigSprite:setScale(0.3)
        bigSprite:setPosition(80, 20)
        bigSprite:addTo(introductionSprite)

        --技能介绍
        local introductionText = ccui.Text:create("", "artcontent/font/fzbiaozjw.ttf", 18)
        local skillIntroduction = self.enemyLineup_[i]:getTowerInfo()
        if skillIntroduction then
            if #skillIntroduction > 19 * 3 then
                local stringFront = string.sub(skillIntroduction, 1, 19 * 3)
                local stringBack = string.sub(skillIntroduction, 20 * 3 + 1, #skillIntroduction)
                introductionText:setString(stringFront.."\n"..stringBack)
            else
                introductionText:setString(skillIntroduction)
            end
        end
        introductionText:setPosition(330, 80)
        introductionText:addTo(introductionSprite)

        --头像
        spriteRes = "artcontent/battle_ongame/battle_interface/tower/tower_%d.png"
        sprite =  string.format(spriteRes, self.enemyLineup_[i]:getTowerId())
        local towerBtn = ccui.Button:create(sprite)
        towerBtn:setScale9Enabled(true)
        towerBtn:setScale(0.6)
        towerBtn:setPosition(index_x, 1160)
        towerBtn:addChild(self.introduction_[i])
        towerBtn:addTouchEventListener(function(sender, eventType)
            if eventType == 2  and cc.UserDefault:getInstance():getBoolForKey("介绍") then
                if self.isVisible_[i] == 0 then
                    self.introduction_[i]:setVisible(true)
                    self.isVisible_[i] = 1
                else
                    self.introduction_[i]:setVisible(false)
                    self.isVisible_[i] = 0
                end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_click.OGG")
                end
            end
        end)
        towerBtn:addTo(self)

        --等级
        spriteRes = "artcontent/battle_ongame/battle_interface/grade/LV.%d.png"
        sprite = string.format(spriteRes, self.enemyLineup_[i]:getLevel())
        local levelSprite = cc.Sprite:create(sprite)
        levelSprite:setScale(0.9)
        levelSprite:setPosition(index_x, 1120)
        levelSprite:addTo(self)

        --塔类型角标
        local angleMarkSprite = cc.Sprite:create(angelMark[self.enemyLineup_[i]:getTowerType()])
        angleMarkSprite:setPosition(index_x + 20, 1180)
        angleMarkSprite:setScale(0.6)
        angleMarkSprite:addTo(self)
        index_x = index_x + 75
    end
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

    --认输界面按钮
    local adBtn = ccui.Button:create("artcontent/battle_ongame/battle_interface/button_admitdefeat.png")
    adBtn:addTouchEventListener(function (sender, eventType)
        if eventType == 2 then
            GameData:setGameState(ConstDef.GAME_STATE.ADMIT_DEFEAT)
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_btn_click.OGG")
            end
        end
    end)
    adBtn:setPosition(display.right - 110, display.cy + 60)
    adBtn:addTo(self)

    --网络延迟
    self.latency_ = ccui.ImageView:create("artcontent/battle_ongame/battle_interface/networkdelay/delay_low.png")
    self.latency_:setPosition(50, display.cy + 50)
    self.latency_:addTo(self)

    --延迟
    self.latencyNum_ = ccui.Text:create("17ms", "artcontent/font/fzbiaozjw.ttf", 20)
    self.latencyNum_:setColor(cc.c3b(0, 255, 0))
    self.latencyNum_:setPosition(50, display.cy + 30)
    self.latencyNum_:addTo(self)

    --sp总数底图
    local sumSpSprite = cc.Sprite:create("artcontent/battle_ongame/battle_interface/basemap_sp.png")
    sumSpSprite:setPosition(display.cx - 180, display.cy + 240)
    sumSpSprite:addTo(myContainer)

    --sp总数数值
    self.sumSpNum_ = ccui.Text:create("100", "artcontent/font/fzbiaozjw.ttf", 26)
    self.sumSpNum_:setAnchorPoint(0.1, 0.5)
    self.sumSpNum_:setPosition(display.cx - 180, display.cy + 240)
    self.sumSpNum_:addTo(myContainer)

    --敌方标记
    local enemySprite = cc.Sprite:create("artcontent/battle_ongame/battle_interface/oppositemark.png")
    enemySprite:setPosition(160, display.cy - 120)
    enemySprite:addTo(emenyContainer)

    --敌人昵称
    self.enemyName_ = ccui.Text:create("robot","artcontent/font/fzbiaozjw.ttf", 24)
    self.enemyName_:setPosition(160, display.cy - 160)
    self.enemyName_:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 描边
    self.enemyName_:enableShadow(cc.c3b(0, 0, 0), cc.size(0, 1), 1) -- 加阴影
    self.enemyName_:addTo(emenyContainer)

    --我方标记
    local mySprite = cc.Sprite:create("artcontent/battle_ongame/battle_interface/ourmark.png")
    mySprite:setPosition(display.cx + 180, display.cy + 260)
    mySprite:addTo(myContainer)

    --我方昵称
    local name=cc.UserDefault:getInstance():getStringForKey("昵称")
    self.myName_ = ccui.Text:create(name, "artcontent/font/fzbiaozjw.ttf", 24)
    self.myName_:setPosition(display.cx + 180, display.cy + 220)
    self.myName_:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 描边
    self.myName_:enableShadow(cc.c3b(0, 0, 0), cc.size(0, 1), 1) -- 加阴影
    self.myName_:addTo(myContainer)

    --我方生命
    local index_x = 320
    for i = 1, 3 do
        local pointSprite = ccui.ImageView:create("artcontent/battle_ongame/battle_interface/hp_full.png")
        pointSprite:setPosition(display.cx + index_x, display.top + 10)
        index_x = index_x - 50
        pointSprite:addTo(myContainer)
        table.insert(myPoint_, i, pointSprite)
    end

    --敌方生命
    index_x = 150
    for i = 1, 3 do
        local pointSprite = ccui.ImageView:create("artcontent/battle_ongame/battle_interface/hp_full.png")
        pointSprite:setPosition(index_x, display.bottom + 80)
        index_x = index_x - 50
        pointSprite:addTo(emenyContainer)
        table.insert(enemyPoint_, i, pointSprite)
    end
end

--[[--
    boss出现时间与介绍

    @parm none

    @return none
]]
function FightingInfoLayer:bossInfo()
    --boss 按钮
    local spriteRes = "artcontent/battle_ongame/battle_interface/button_boss/boss_%d.png"
    local sprite = string.format(spriteRes, self.nextBossId_)
    self.bossBtn_ = ccui.Button:create(sprite)
    self.bossBtn_:setPosition(display.cx - 120, display.cy + 70)
    self.bossBtn_:addTouchEventListener(function(sender, eventType)
        if eventType == 2 and cc.UserDefault:getInstance():getBoolForKey("介绍") then
            if self.bossIntroIsVisable_ == 0 then
                self.bossSprite_:setVisible(true)
                self.bossIntroIsVisable_ = 1
            elseif self.bossIntroIsVisable_ == 1 then
                self.bossSprite_:setVisible(false)
                self.bossIntroIsVisable_ = 0
            end
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_btn_click.OGG")
            end
        end
    end)
    self.bossBtn_:addTo(self)

    --剩余时间
    self.time_ = ccui.Text:create("02 : 00", "artcontent/font/fzbiaozjw.ttf", 30)
    self.time_:setPosition(display.cx, display.cy + 70)
    self.time_:addTo(self)

    --boss介绍底图
    self.bossSprite_ = cc.Sprite:create("artcontent/battle_ongame/boss_informationpopup/basemap_popup.png")
    self.bossSprite_:setPosition(display.cx, display.cy - 130)
    self.bossSprite_:addTo(self)
    self.bossSprite_:setVisible(false)

    --boss图片
    spriteRes = "artcontent/battle_ongame/boss_informationpopup/boss_%d.png"
    sprite = string.format(spriteRes, self.nextBossId_)
    self.bossImage_ = ccui.ImageView:create(sprite)
    self.bossImage_:setPosition(display.cx - 240, display.cy - 460)
    self.bossImage_:addTo(self.bossSprite_)

    --boss名字
    self.bossName_ = ccui.Text:create(bossName[self.nextBossId_], "artcontent/font/fzbiaozjw.ttf", 26)
    self.bossName_:setPosition(display.cx - 50, display.cy - 410)
    self.bossName_:addTo(self.bossSprite_)

    --boss介绍
    self.bossIntroduction_ = ccui.Text:create("", "artcontent/font/fzbiaozjw.ttf", 22)
    local skillIntroduction = bossIntroduction[self.nextBossId_]
    local str = ""
    while #skillIntroduction > 11 * 3 do
        local stringFront = string.sub(skillIntroduction, 1, 11 * 3)
        skillIntroduction = string.sub(skillIntroduction, 11 * 3 + 1, #skillIntroduction)
        str = str .. stringFront .. "\n"
    end
    if #skillIntroduction > 0 then
        str = str .. skillIntroduction
    end
    self.bossIntroduction_:setString(str)
    self.bossIntroduction_:setAnchorPoint(0,1)
    self.bossIntroduction_:setPosition(display.cx - 110, display.cy - 480)
    self.bossIntroduction_:addTo(self.bossSprite_)
end

--[[--
    刷新生命

    @param none

    @return none
]]
function FightingInfoLayer:updatePoint()
    local myPoint = GameData:getMyPoint()
    local enemyPoint = GameData:getEnemyPoint()
    if myPoint > 0 and myPoint < 3 then
        for i = 3, myPoint + 1, -1 do
            myPoint_[i]:loadTexture("artcontent/battle_ongame/battle_interface/hp_empty.png")
        end
    elseif myPoint <= 0 then
        myPoint_[1]:loadTexture("artcontent/battle_ongame/battle_interface/hp_empty.png")
        GameData:defeat()
    end
    if enemyPoint > 0 and enemyPoint < 3 then
        for i = 3, enemyPoint + 1, -1 do
            enemyPoint_[i]:loadTexture("artcontent/battle_ongame/battle_interface/hp_empty.png")
        end
    elseif enemyPoint <= 0 then
        enemyPoint_[1]:loadTexture("artcontent/battle_ongame/battle_interface/hp_empty.png")
        GameData:victory()
    end
end

--[[--
    刷新boss介绍

    @parm none

    @return none
]]
function FightingInfoLayer:bossIntroductionUpdate()
    if self.nextBossId_ ~= GameData:getNextBossId() then
        self.nextBossId_ = GameData:getNextBossId()
        --按钮更换
        local spriteRes = "artcontent/battle_ongame/battle_interface/button_boss/boss_%d.png"
        local sprite = string.format(spriteRes, self.nextBossId_)
        self.bossBtn_:loadTextureNormal(sprite)
        --图片更换
        spriteRes = "artcontent/battle_ongame/boss_informationpopup/boss_%d.png"
        sprite = string.format(spriteRes, self.nextBossId_)
        self.bossImage_:loadTexture(sprite)
        --名字更换
        self.bossName_:setString(bossName[self.nextBossId_])
        --介绍更换
        local skillIntroduction = bossIntroduction[self.nextBossId_]
        local str = ""
        while #skillIntroduction > 11 * 3 do
            local stringFront = string.sub(skillIntroduction, 1, 11 * 3)
            skillIntroduction = string.sub(skillIntroduction, 11 * 3 + 1, #skillIntroduction)
            str = str .. stringFront .. "\n"
        end
        if #skillIntroduction > 0 then
            str = str .. skillIntroduction
        end
        self.bossIntroduction_:setString(str)
    end
end

--[[--
    刷新时间

    @pram none

    @return none
]]
function FightingInfoLayer:timeUpdate()
    self.time_:setString(GameData:bossTime())
end

--[[--
    帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function FightingInfoLayer:update(dt)
    self.sumSpNum_:setString(GameData:getSumSp())
    self:bossIntroductionUpdate()
    self:timeUpdate()
end

--[[--
    节点进入

    @param none

    @return none
]]
function FightingInfoLayer:onEnter()
    EventManager:regListener(EventDef.ID.HURT, self, function()
        print("5")
        self:updatePoint()
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function FightingInfoLayer:onExit()
    EventManager:unRegListener(EventDef.ID.HURT, self)
end

return FightingInfoLayer