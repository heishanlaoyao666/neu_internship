--[[--
    背景层
    InfoLayer.lua
    设计尺寸依赖于FightConstDef
    编写：李昊
]]
local InfoLayer = class("InfoLayer", require("app.ui.layer.BaseLayer"))
local card = require("src.app.data.card.Card1")
local FightConstDef = require("src.app.def.FightConstDef")
local GameData = require("src.app.data.GameData")
local MsgDef = require("src.app.def.MsgDef")

local time1,time2,time3,time4

--[[--
    构造函数

    @param none

    @return none
]]
function InfoLayer:ctor(player)

    self.player_ = player --对应的玩家

    self.bgScaleFactorX_ = 1 -- 类型：number，背景缩放系数
    self.bgScaleFactorY_ = 1 -- 类型：number，背景缩放系数

    self.boss_ = nil --类型number boss编号

    self.enemyCardGroup_ = {} -- 类型 card数组 敌方卡组
    self.enemyName_ = nil --类型 string 敌方名字
    self.enemyPlayerLevel_ = nil --敌方段位

    self.cardGroup_ = {} --自己卡组
    self.name_ = nil --类型 string 己方名字
    self.playerLevel_ = nil --己方段位
 
    --随动参数
    self.life_ = 2 --己方血量
    self.enemyLife_ = 3 --敌方血量
    self.time_ = 20--剩余时间
    self.wifiNum_ = 30 --wifi信号数字
    self.createSp_ = 0 --创造塔所需要的sp值
    self.sp_ = 1000 --sp值
    self.spTime_ = 1 --每过几秒增加sp值

    --精灵
    self.spSprite_ = {} --spSprite[1]为图片 spSprite[2]为文本 随时间增加sp的精灵
    self.bossSprite_ = nil --boss图标
    self.createSprite_ = {} --createSprite[1] createSprite 生成塔的精灵
    self.timeSprite_ = nil --时间文字
    self.giveInSprite_ = nil --投降按钮
    self.enemyCardSprites_ = {} -- 类型：Sprite数组 敌方卡片数组
    self.cardSprites_ = {} -- 类型：Sprite数组 己方卡片数组
    self.enemyLifeSprite_ = {} --敌人血量 
    self.lifeSprite_ = {} --己方血量
    self.enemyLevelSprite_ = nil --对方段位
    self.levelSprite_ = nil --己方段位
    self.enemyNameSprite_ = nil -- 敌方名字精灵
    self.nameSprite_  = nil --名字精灵
    self.wifiSprite_ =  {} --wifi信号
    self.wifiNumSprite_ = nil -- wifi信号数字精灵

    self:init()
    self:initView()
end

--[[
    数据初始化

    @param none

    @return none
]]
function InfoLayer:init()
    self.bgScaleFactorY_ = display.top/1280
    self.bgScaleFactorX_ = display.right/720
    print(self.bgScaleFactorX_)
    local card1 = card.new(0,0)
    self.enemyCardGroup_ = {card1,card1,card1,card1,card1}
    self.cardGroup_ = {card1,card1,card1,card1,card1}
    self.name_ = "me"
    self.enemyName_ = "robot"
    self.boss_ = 1
end

--[[
    时间转化为显示

    @param number

    @return number*4

]]
function InfoLayer:timeToShow(time)
    time1 = math.ceil(time/60/10)
    time2 = math.ceil(time/60%10)
    if time2 > 0  then
        time1 = time1 - 1
        time2 = time2 - 1
    end
    time3 = math.ceil(time%60/10)
    time4 = math.ceil(time%60%10)
    if time4 > 0 then 
        time3 = time3 - 1
        time4 = time4 - 1
    end
    return time1,time2,time3,time4
end

--[[--
    界面初始化
    
    @param none

    @return none
]]
function InfoLayer:initView()
    --敌方card图片尺寸120*120
    --敌方card设计尺寸 60*60
    --敌方card的level图片尺寸36*20
    --敌方card的level设计尺寸36*20
    --敌方card的角标图片尺寸34*42
    --敌方card的角标设计尺寸17*21
    local cardX = display.cx - self.bgScaleFactorX_*(2*FightConstDef.ENEMY_SIZE.CARD_SIZE_X
                                                + FightConstDef.ENEMY_SIZE.CARD_SIZE_INTERVAL)
    for i =1,#self.enemyCardGroup_ do
        --敌方卡片的图片
        local sprite = display.newSprite(self.enemyCardGroup_[i]:getSmallColorSpriteImg())
        sprite:setScaleX(self.bgScaleFactorX_*FightConstDef.ENEMY_SIZE.CARD_SIZE_X/120)
        sprite:setScaleY(self.bgScaleFactorY_*FightConstDef.ENEMY_SIZE.CARD_SIZE_Y/120)
        sprite:setAnchorPoint(0.0, 1.0)
        sprite:setPosition(cardX, display.top - self.bgScaleFactorY_*FightConstDef.ENEMY_SIZE.CARD_POSITION_Y )
        self:addChild(sprite)
        self.enemyCardSprites_[i] = sprite
        sprite:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
            if event.name == "ended" then
                local msg  = {}
                local data = {}
                data["size"] = ""
                data["data"] = i
                msg["data"] = data
                GameData:send(MsgDef.REQ_TYPE.ENFORCE_TOWER,msg)
            end
        end)
        sprite:setTouchEnabled(true)

        --敌方卡片的等级
        local sprite1 = display.newSprite(self.enemyCardGroup_[i]:getLevelImg())
        sprite1:setScaleX(self.bgScaleFactorX_*FightConstDef.ENEMY_SIZE.CARD_LEVEL_SIZE_X/36)
        sprite1:setScaleY(self.bgScaleFactorY_*FightConstDef.ENEMY_SIZE.CARD_LEVEL_SIZE_Y/20)
        sprite1:setAnchorPoint(0.5, 1.0)
        sprite1:setPosition(cardX + 0.45*self.bgScaleFactorX_*FightConstDef.ENEMY_SIZE.CARD_SIZE_X,
            display.top - self.bgScaleFactorY_*FightConstDef.ENEMY_SIZE.CARD_LEVEL_POSITION_Y  )
        self:addChild(sprite1)
        self.enemyCardSprites_[i+5] = sprite1
        --敌方卡片的攻击类型
        local sprite2 = display.newSprite(self.enemyCardGroup_[i]:getTypeImg())
        sprite2:setScaleX(self.bgScaleFactorX_*FightConstDef.ENEMY_SIZE.CARD_TYPE_SIZE_X/34)
        sprite2:setScaleY(self.bgScaleFactorY_*FightConstDef.ENEMY_SIZE.CARD_TYPE_SIZE_X/42)
        sprite2:setAnchorPoint(1.0, 1.0)
        sprite2:setPosition(cardX + 0.9*self.bgScaleFactorX_*FightConstDef.ENEMY_SIZE.CARD_SIZE_X,
            display.top - self.bgScaleFactorY_*FightConstDef.ENEMY_SIZE.CARD_TYPE_POSITION_Y)
        cardX = cardX + self.bgScaleFactorX_*(FightConstDef.ENEMY_SIZE.CARD_SIZE_X
                                + FightConstDef.ENEMY_SIZE.CARD_SIZE_INTERVAL) 
        self:addChild(sprite2)
        self.enemyCardSprites_[i+10] = sprite2
    end
    --敌方段位的图片原尺寸 60*49
    --敌方段位的设计尺寸 60*49
    local enemyLevel = display.newSprite("image/fight/fight/enemy_mark_icon.png")
    enemyLevel:setScaleX(self.bgScaleFactorX_*FightConstDef.ENEMY_SIZE.INTEGRAL_SIZE_X/60)
    enemyLevel:setScaleY(self.bgScaleFactorY_*FightConstDef.ENEMY_SIZE.INTEGRAL_SIZE_Y/49)
    enemyLevel:setAnchorPoint(0.5, 0.5)
    enemyLevel:setPosition(display.left + self.bgScaleFactorX_*FightConstDef.ENEMY_SIZE.INTEGRAL_POSITION_X,
                display.bottom + self.bgScaleFactorY_*FightConstDef.ENEMY_SIZE.INTEGRAL_POSITION_Y)
    self:addChild(enemyLevel)
    self.enemyLevelSprite_ = enemyLevel

    --敌方名字
    local enemyName = cc.Label:createWithTTF(self.enemyName_,"font/fzbiaozjw.ttf",FightConstDef.ENEMY_SIZE.NAME_SIZE)
    enemyName:setScaleX(self.bgScaleFactorX_)
    enemyName:setScaleY(self.bgScaleFactorY_)
    enemyName:setAnchorPoint(0.5, 0.5)
    enemyName:setPosition(display.left + self.bgScaleFactorX_*FightConstDef.ENEMY_SIZE.NAME_POSITION_X,
                display.bottom + self.bgScaleFactorY_*FightConstDef.ENEMY_SIZE.NAME_POSITION_Y)
    self:addChild(enemyName)
    enemyName:enableOutline(cc.c4b(0, 0, 0, 255),1)
    self.enemyNameSprite_ = enemyName


    --己方card图片尺寸120*120
    --己方card设计尺寸 90*90
    --己方card的level图片尺寸36*20
    --己方card的level设计尺寸54*30
    --己方card的角标图片尺寸34*42
    --己方card的角标设计尺寸25.5*31.5
    --己方card的sp值原图尺寸124*40
    --己方card的sp值原图尺寸80.6*26
    cardX = display.cx - self.bgScaleFactorX_*FightConstDef.ME_SIZE.CARD_SIZE_X*2 - self.bgScaleFactorX_*FightConstDef.ME_SIZE.CARD_SIZE_INTERVAL*2
    for i =1,#self.cardGroup_ do
        --己方卡片的图片
        local sprite = display.newSprite(self.cardGroup_[i]:getSmallColorSpriteImg())
        sprite:setScaleX(self.bgScaleFactorX_*FightConstDef.ME_SIZE.CARD_SIZE_X/120)
        sprite:setScaleY(self.bgScaleFactorY_*FightConstDef.ME_SIZE.CARD_SIZE_Y/120)
        sprite:setAnchorPoint(0.5, 1.0)
        sprite:setPosition(cardX, display.bottom + self.bgScaleFactorY_*FightConstDef.ME_SIZE.CARD_POSITION_Y )
        self:addChild(sprite)
        self.cardSprites_[i] = sprite
        --己方卡片的等级
        local sprite1 = display.newSprite(self.cardGroup_[i]:getLevelImg())
        sprite1:setScaleX(self.bgScaleFactorX_*FightConstDef.ME_SIZE.CARD_LEVEL_SIZE_X/36)
        sprite1:setScaleY(self.bgScaleFactorY_*FightConstDef.ME_SIZE.CARD_LEVEL_SIZE_Y/20)
        sprite1:setAnchorPoint(0.55, 1.0)
        sprite1:setPosition(cardX,display.bottom + self.bgScaleFactorX_*FightConstDef.ME_SIZE.CARD_LEVEL_POSITION_Y  )
        self:addChild(sprite1)
        self.cardSprites_[i+5] = sprite1
        --己方卡片的攻击类型
        local sprite2 = display.newSprite(self.cardGroup_[i]:getTypeImg())
        sprite2:setScaleX(self.bgScaleFactorX_*FightConstDef.ME_SIZE.CARD_TYPE_SIZE_X/34)
        sprite2:setScaleY(self.bgScaleFactorY_*FightConstDef.ME_SIZE.CARD_TYPE_SIZE_X/42)
        sprite2:setAnchorPoint(1.0, 1.0)
        sprite2:setPosition(cardX + 0.4*self.bgScaleFactorX_*FightConstDef.ME_SIZE.CARD_SIZE_X,
            display.bottom + self.bgScaleFactorY_*FightConstDef.ME_SIZE.CARD_TYPE_POSITION_Y)
        self:addChild(sprite2)
        self.cardSprites_[i+10] = sprite2
        --己方sp值图片
        local sp = display.newSprite("image/fight/fight/sp_bg.png")
        sp:setScaleX(self.bgScaleFactorX_*FightConstDef.ME_SIZE.CARD_SP_SIZE_X/124)
        sp:setScaleY(self.bgScaleFactorY_*FightConstDef.ME_SIZE.CARD_SP_SIZE_Y/40)
        sp:setAnchorPoint(0.5, 0.5)
        sp:setPosition(cardX , display.bottom + self.bgScaleFactorY_*FightConstDef.ME_SIZE.CARD_SP_POSITION_Y)
        self:addChild(sp)
        self.cardSprites_[i+15] =  sp
        --己方sp值文本
        local sp2 = cc.Label:createWithTTF("100","font/fzbiaozjw.ttf",FightConstDef.ME_SIZE.CARD_SP_NUM_SIZE)
        sp2:setScaleX(self.bgScaleFactorX_)
        sp2:setScaleY(self.bgScaleFactorY_)
        sp2:setAnchorPoint(0.4, 0.5)
        sp2:setPosition(cardX,display.bottom + self.bgScaleFactorY_*FightConstDef.ME_SIZE.CARD_SP_POSITION_Y)
        self:addChild(sp2)
        self.cardSprites_[i+20] = sp2

        cardX = cardX + self.bgScaleFactorX_*(FightConstDef.ME_SIZE.CARD_SIZE_X
            + FightConstDef.ME_SIZE.CARD_SIZE_INTERVAL) 
    end


    --己方段位设计图原尺寸 60*49
    --段位的设计尺寸 60*39
    local level = display.newSprite("image/fight/fight/my_mark_icon.png")
    level:setScaleX(self.bgScaleFactorX_*FightConstDef.ME_SIZE.INTEGRAL_SIZE_X/60)
    level:setScaleY(self.bgScaleFactorY_*FightConstDef.ME_SIZE.INTEGRAL_SIZE_Y/49)
    level:setAnchorPoint(0.5, 0.5)
    level:setPosition(display.left + self.bgScaleFactorX_*FightConstDef.ME_SIZE.INTEGRAL_POSITION_X,
                display.bottom + self.bgScaleFactorY_*FightConstDef.ME_SIZE.INTEGRAL_POSITION_Y)
    self:addChild(level)
    self.levelSprite_ = level

    --己方名字
    local name = cc.Label:createWithTTF(self.name_,"font/fzbiaozjw.ttf",FightConstDef.ME_SIZE.NAME_SIZE)
    name:setScaleX(self.bgScaleFactorX_)
    name:setScaleY(self.bgScaleFactorY_)
    name:setAnchorPoint(0.5, 0.5)
    name:setPosition(display.left + self.bgScaleFactorX_*FightConstDef.ME_SIZE.NAME_POSITION_X,
                display.bottom + self.bgScaleFactorY_*FightConstDef.ME_SIZE.NAME_POSITION_Y)
    self:addChild(name)
    name:enableOutline(cc.c4b(0, 0, 0, 255),1)
    self.nameSprite_ = name

    --wifi信号之类的原图尺寸38*29
    --wifi的设计尺寸38*29
    --延迟低
    local wifiLow = display.newSprite("image/fight/fight/networkdelay/low.png")
    wifiLow:setScaleX(self.bgScaleFactorX_*FightConstDef.WIFI_SIZE.SIZE_X/38)
    wifiLow:setScaleY(self.bgScaleFactorY_*FightConstDef.WIFI_SIZE.SIZE_Y/29)
    wifiLow:setAnchorPoint(0.5, 0.5)
    wifiLow:setPosition(display.cx - self.bgScaleFactorX_*FightConstDef.WIFI_SIZE.POSITION_X,
                display.cy + self.bgScaleFactorY_*FightConstDef.WIFI_SIZE.POSITION_Y)
    self:addChild(wifiLow)
    self.wifiSprite_[1] = wifiLow

    --延迟中
    local wifiMid = display.newSprite("image/fight/fight/networkdelay/middle.png")
    wifiMid:setScaleX(self.bgScaleFactorX_*FightConstDef.WIFI_SIZE.SIZE_X/38)
    wifiMid:setScaleY(self.bgScaleFactorY_*FightConstDef.WIFI_SIZE.SIZE_Y/29)
    wifiMid:setAnchorPoint(0.5, 0.5)
    wifiMid:setPosition(display.cx - self.bgScaleFactorX_*FightConstDef.WIFI_SIZE.POSITION_X,
                display.cy + self.bgScaleFactorY_*FightConstDef.WIFI_SIZE.POSITION_Y)
    self.wifiSprite_[2] = wifiMid
    self:addChild(wifiMid)

    --延迟高
    local wifiHigh = display.newSprite("image/fight/fight/networkdelay/high.png")
    wifiHigh:setScaleX(self.bgScaleFactorX_*FightConstDef.WIFI_SIZE.SIZE_X/38)
    wifiHigh:setScaleY(self.bgScaleFactorY_*FightConstDef.WIFI_SIZE.SIZE_Y/29)
    wifiHigh:setAnchorPoint(0.5, 0.5)
    wifiHigh:setPosition(display.cx - self.bgScaleFactorX_*FightConstDef.WIFI_SIZE.POSITION_X,
                display.cy + self.bgScaleFactorY_*FightConstDef.WIFI_SIZE.POSITION_Y)
    self.wifiSprite_[3] = wifiHigh
    self:addChild(wifiHigh)

    --网络延迟
    local num = string.format("%dms", self.wifiNum_)
    local wifiNum = cc.Label:createWithTTF(num,"font/fzbiaozjw.ttf",FightConstDef.WIFI_SIZE.NUM_SIZE)
    wifiNum:setScaleX(self.bgScaleFactorX_)
    wifiNum:setScaleY(self.bgScaleFactorY_)
    wifiNum:setAnchorPoint(0.5, 0.5)
    wifiNum:setColor(cc.c3b(0, 255, 0))
    wifiNum:setPosition(display.cx - self.bgScaleFactorX_*FightConstDef.WIFI_SIZE.NUM_POSITION_X,
    display.cy + self.bgScaleFactorY_*FightConstDef.WIFI_SIZE.NUM_POSITION_Y)
    self:addChild(wifiNum)
    wifiNum:enableOutline(cc.c4b(0, 0, 0, 255),1)
    self.wifiNumSprite_ = wifiNum

    --爱心
    --原图尺寸41*40
    --设计尺寸41*40

    --敌方血条
    for i =1,3 do
        local fullHp = display.newSprite("image/fight/fight/life_full.png")
        fullHp:setAnchorPoint(0.5, 0.5)
        fullHp:setScaleX(self.bgScaleFactorX_*FightConstDef.LIFE_SIZE.SIZE_X/41)
        fullHp:setScaleY(self.bgScaleFactorY_*FightConstDef.LIFE_SIZE.SIZE_Y/40)
        fullHp:setPosition(display.cx - self.bgScaleFactorX_*FightConstDef.LIFE_SIZE.ENEMY_POSITION_X + 
                    (i-1)*self.bgScaleFactorX_*(FightConstDef.LIFE_SIZE.SIZE_INTERVAL + FightConstDef.LIFE_SIZE.SIZE_X),
                    display.cy + self.bgScaleFactorY_*FightConstDef.LIFE_SIZE.ENEMY_POSITION_Y)
        self:addChild(fullHp)  
        self.enemyLifeSprite_[i] = fullHp 

        local emptyHp = display.newSprite("image/fight/fight/life_empty.png")
        emptyHp:setAnchorPoint(0.5, 0.5)
        emptyHp:setScaleX(self.bgScaleFactorX_*FightConstDef.LIFE_SIZE.SIZE_X/41)
        emptyHp:setScaleY(self.bgScaleFactorY_*FightConstDef.LIFE_SIZE.SIZE_Y/40)
        emptyHp:setPosition(display.cx - self.bgScaleFactorX_*FightConstDef.LIFE_SIZE.ENEMY_POSITION_X + 
                    (i-1)*self.bgScaleFactorX_*(FightConstDef.LIFE_SIZE.SIZE_INTERVAL + FightConstDef.LIFE_SIZE.SIZE_X),
                    display.cy + self.bgScaleFactorY_*FightConstDef.LIFE_SIZE.ENEMY_POSITION_Y)
        self:addChild(emptyHp)  
        self.enemyLifeSprite_[i+3] = emptyHp       
    end

    --我方血条
    for i =1,3 do
        local fullHp = display.newSprite("image/fight/fight/life_full.png")
        fullHp:setAnchorPoint(0.5, 0.5)
        fullHp:setScaleX(self.bgScaleFactorX_*FightConstDef.LIFE_SIZE.SIZE_X/41)
        fullHp:setScaleY(self.bgScaleFactorY_*FightConstDef.LIFE_SIZE.SIZE_Y/40)
        fullHp:setPosition(display.cx + self.bgScaleFactorX_*FightConstDef.LIFE_SIZE.ME_POSITION_X + 
                    (i-1)*self.bgScaleFactorX_*(FightConstDef.LIFE_SIZE.SIZE_INTERVAL + FightConstDef.LIFE_SIZE.SIZE_X),
                    display.cy + self.bgScaleFactorY_*FightConstDef.LIFE_SIZE.ME_POSITION_Y)
        self:addChild(fullHp)  
        self.lifeSprite_[i] = fullHp 

        local emptyHp = display.newSprite("image/fight/fight/life_empty.png")
        emptyHp:setAnchorPoint(0.5, 0.5)
        emptyHp:setScaleX(self.bgScaleFactorX_*FightConstDef.LIFE_SIZE.SIZE_X/41)
        emptyHp:setScaleY(self.bgScaleFactorY_*FightConstDef.LIFE_SIZE.SIZE_Y/40)
        emptyHp:setPosition(display.cx + self.bgScaleFactorX_*FightConstDef.LIFE_SIZE.ME_POSITION_X + 
                    (i-1)*self.bgScaleFactorX_*(FightConstDef.LIFE_SIZE.SIZE_INTERVAL + FightConstDef.LIFE_SIZE.SIZE_X),
                    display.cy + self.bgScaleFactorY_*FightConstDef.LIFE_SIZE.ME_POSITION_Y)
        self:addChild(emptyHp)  
        self.lifeSprite_[i+3] = emptyHp       
    end

    self:resetLife() --刷新血条

    --投降的原图大小157*102
    --设计大小157*102
    local giveIn = ccui.Button:create("image/fight/fight/givein_btn.png","image/fight/fight/givein_btn.png")
    giveIn:setAnchorPoint(0.5, 0.5)
    giveIn:setScaleX(self.bgScaleFactorX_*FightConstDef.OTHER_SIZE.GIVEIN_SIZE_X/157)
    giveIn:setScaleY(self.bgScaleFactorY_*FightConstDef.OTHER_SIZE.GIVEIN_SIZE_Y/102)
    giveIn:setPosition(display.cx + self.bgScaleFactorX_*FightConstDef.OTHER_SIZE.GIVEIN_POSITION_X ,
                    display.cy + self.bgScaleFactorY_*FightConstDef.OTHER_SIZE.GIVEIN_POSITION_Y)
    self:addChild(giveIn)
    self.giveInSprite_ = giveIn
    giveIn:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
            print("giveIn")
		end
	end)

    --shi时间前面的图标实际大小54*46
    ---设计大小 54*59
    local boss = display.newSprite(FightConstDef.OTHER_SIZE.BOSS_SIZE[self.boss_])
    boss :setAnchorPoint(0.5, 0.5)
    boss :setScaleX(self.bgScaleFactorX_*FightConstDef.OTHER_SIZE.BOSS_SIZE_Y/54)
    boss :setScaleY(self.bgScaleFactorY_*FightConstDef.OTHER_SIZE.BOSS_SIZE_X/46)
    boss :setPosition(display.cx - self.bgScaleFactorX_*FightConstDef.OTHER_SIZE.BOSS_POSITION_X,
                    display.cy + self.bgScaleFactorY_*FightConstDef.OTHER_SIZE.BOSS_POSITION_Y)
    self:addChild(boss)  
    self.bossSprite_ = boss
    
    --时间文本
    local time =  string.format("剩余时间 %d%d:%d%d", self:timeToShow(self.time_))
    local timeSprite = cc.Label:createWithTTF(time,"font/fzbiaozjw.ttf",FightConstDef.OTHER_SIZE.TIME_SIZE)
    timeSprite:setScaleX(self.bgScaleFactorX_)
    timeSprite:setScaleY(self.bgScaleFactorY_)
    timeSprite:setColor(cc.c3b(255, 255, 255))
    timeSprite:setAnchorPoint(0.5, 0.5)
    timeSprite:setPosition(display.cx - self.bgScaleFactorX_*FightConstDef.OTHER_SIZE.TIME_POSITION_X,
    display.cy + self.bgScaleFactorY_*FightConstDef.OTHER_SIZE.TIME_POSITION_Y)
    self:addChild(timeSprite)
    timeSprite:enableOutline(cc.c4b(0, 0, 0, 255),1)
    self.timeSprite_ = timeSprite

    --生成按钮图像大小186*117
    --设计大小 160*105
    local create = ccui.Button:create("image/fight/fight/generate_btn.png","image/fight/fight/generate_btn.png")
    create:setAnchorPoint(0.5, 0.5)
    create:setScaleX(self.bgScaleFactorX_*FightConstDef.SP_SIZE.CREATE_SIZE_X/186)
    create:setScaleY(self.bgScaleFactorY_*FightConstDef.SP_SIZE.CREATE_SIZE_Y/117)
    create:setPosition(display.cx + self.bgScaleFactorX_*FightConstDef.SP_SIZE.CREATE_POSITION_X ,
                    display.cy - self.bgScaleFactorY_*FightConstDef.SP_SIZE.CREATE_POSITION_Y)
    self:addChild(create)  
    self.createSprite_[1] = create   
    create:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
            GameData:createCard()
		end
	end)

    --文字
    local createText = cc.Label:createWithTTF(self.createSp_,"font/fzbiaozjw.ttf",FightConstDef.SP_SIZE.CREATE_NUM_SIZE)
    createText:setScaleX(self.bgScaleFactorX_)
    createText:setScaleY(self.bgScaleFactorY_)
    createText:setColor(cc.c3b(255, 255, 255))
    createText:setAnchorPoint(0.5, 0.5)
    createText:setPosition(display.cx - self.bgScaleFactorX_*FightConstDef.SP_SIZE.CREATE_NUM_POSITION_X,
    display.cy - self.bgScaleFactorY_*FightConstDef.SP_SIZE.CREATE_NUM_POSITION_Y)
    self:addChild(createText)
    createText:enableOutline(cc.c4b(0, 0, 0, 255),1)
    self.createSprite_[2] = createText

    --sp随时间增长的图片124*40
    --设计尺寸
    local sp1 = display.newSprite("image/fight/fight/sp_bg.png")
    sp1 :setAnchorPoint(0.5, 0.5)
    sp1 :setScaleX(self.bgScaleFactorX_*FightConstDef.SP_SIZE.SIZE_X/124)
    sp1 :setScaleY(self.bgScaleFactorY_*FightConstDef.SP_SIZE.SIZE_Y/40)
    sp1:setPosition(display.cx - self.bgScaleFactorX_*FightConstDef.SP_SIZE.SIZE_POSITION_X,
                    display.cy - self.bgScaleFactorY_*FightConstDef.SP_SIZE.SIZE_POSITION_Y)
    self:addChild(sp1)  
    self.spSprite_[1] = sp1

    --sp随时间增长文本
    local spText1 = cc.Label:createWithTTF(self.sp_,"font/fzbiaozjw.ttf",FightConstDef.SP_SIZE.NUM_SIZE)
    spText1 :setScaleX(self.bgScaleFactorX_)
    spText1 :setScaleY(self.bgScaleFactorY_)
    spText1 :setColor(cc.c3b(255, 255, 255))
    spText1 :setAnchorPoint(0.4, 0.5)
    spText1 :setPosition(display.cx - self.bgScaleFactorX_*FightConstDef.SP_SIZE.SIZE_POSITION_X,
    display.cy - self.bgScaleFactorY_*FightConstDef.SP_SIZE.NUM_POSITION_Y)
    self:addChild(spText1)
    spText1 :enableOutline(cc.c4b(0, 0, 0, 255),1)
    self.spSprite_[2] = spText1

end

--[[

]]
function InfoLayer:resetLife()
    for i = 1,3 do
        if i <= self.enemyLife_ then
            self.enemyLifeSprite_[i]:setVisible(true)
            self.enemyLifeSprite_[i+3]:setVisible(false)
        else
            self.enemyLifeSprite_[i]:setVisible(false)
            self.enemyLifeSprite_[i+3]:setVisible(true)
        end

        if i <= self.life_ then
            self.lifeSprite_[i]:setVisible(true)
            self.lifeSprite_[i+3]:setVisible(false)
        else
            self.lifeSprite_[i]:setVisible(false)
            self.lifeSprite_[i+3]:setVisible(true)
        end
    end
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔

    @return none
]]
function InfoLayer:update()
    --wife信号动态刷新
    if self.wifiNum_ < 99 then
        self.wifiSprite_[1]:setVisible(true)
        self.wifiSprite_[2]:setVisible(false)
        self.wifiSprite_[3]:setVisible(false)
    elseif self.wifiNum_ < 199 then
        self.wifiSprite_[1]:setVisible(false)
        self.wifiSprite_[2]:setVisible(true)
        self.wifiSprite_[3]:setVisible(false)
    else
        self.wifiSprite_[1]:setVisible(false)
        self.wifiSprite_[2]:setVisible(false)
        self.wifiSprite_[3]:setVisible(true)
    end
    --刷新wifi信号数字
    self.wifiNumSprite_:setString(string.format("%dms", self.wifiNum_))


    --时间变化
    self.time_ = GameData:getBossTime()
    
    --刷新时间数字
    self.timeSprite_:setString(string.format("剩余时间 %d%d:%d%d", self:timeToShow(self.time_)))

    self.enemyLife_ = GameData:getEnemyPlayer():getHp()

    self.life_ = GameData:getMePlayer():getHp()
    self:resetLife()

    self.sp_ =  GameData:getMePlayer():getSp()
    self.createSp_ =  GameData:getMePlayer():getCreateSp()
    self.createSprite_[2]:setString(string.format("%d", self.createSp_))
    self.spSprite_[2]:setString(string.format("%d", self.sp_))
    
end

return InfoLayer