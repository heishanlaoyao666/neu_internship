--[[--
    boss选择界面
    BossChooseView.lua
]]

local BossChooseView = class("BossChooseView",function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)

local GameData = require("app.data.ingame.GameData")
local ConstDef = require("app.def.ingame.ConstDef")

--[[--
    构造函数

    @param none

    @return none
]]
function BossChooseView:ctor()
    self.bossId_ = 0
    self.myDt_ = 0 -- 记录时间

    self.boss_ = {}

    self:initView()
end

--[[--
    初始化

    @parm none

    @return none
]]
function BossChooseView:init()
    self.myDt_ = 0 -- 记录时间
    local index_x = 0
    for i = 1, 8 do
        self.boss_[i]:setPosition(index_x, display.cy)
        index_x = index_x + 200
    end
end

--[[--
    视图

    @parm none

    @return none
]]
function BossChooseView:initView()
    --底图
    local popUpSprite = cc.Sprite:create("artcontent/battle_ongame/randomboss_popup/basemap_popup.png")
    popUpSprite:setScale(1.2, 0.8)
    popUpSprite:setPosition(display.cx, display.cy)
    popUpSprite:addTo(self)

    --选框
    local selectSprite = cc.Sprite:create("artcontent/battle_ongame/randomboss_popup/basemap_selectboss.png")
    selectSprite:setScale(0.8)
    selectSprite:setPosition(display.cx, display.cy)
    selectSprite:addTo(self)

    --宝石箭头
    local arrowSprite = cc.Sprite:create("artcontent/battle_ongame/randomboss_popup/arrow_gem.png")
    arrowSprite:setPosition(display.cx, display.cy + 90)
    arrowSprite:setScale(0.8)
    arrowSprite:addTo(self)

    local index_x = 0
    for i = 1, 8 do
        local index = i
        if i > 4 then
            index = index - 4
        end
        local spriteRes = "artcontent/battle_ongame/randomboss_popup/boss_%d.png"
        local sprite = string.format(spriteRes, index)
        self.boss_[i] = cc.Sprite:create(sprite)
        self.boss_[i]:setAnchorPoint(0, 0.5)
        self.boss_[i]:setPosition(index_x, display.cy)
        self.boss_[i]:addTo(self)
        index_x = index_x + 200
    end

    -- 屏蔽点击
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            return true
        end
    end)
    self:setTouchEnabled(true)
end

--[[--
    显示界面

    @param none

    @return none
]]
function BossChooseView:showView()
    self:setVisible(true)
    self:setScale(0)
    self:runAction(cc.ScaleTo:create(0.15, 1))
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function BossChooseView:update(dt)
    self.myDt_ = self.myDt_ + dt
    local speed = 400
    local nextBossId = GameData:getNextBossId()
    if self.myDt_ < 0.75 + nextBossId * 0.5 then
        for i = 1, 8 do
            local x, y= self.boss_[i]:getPositionX(), self.boss_[i]:getPositionY()
            if x < -200 then
                x = 1400
            end
            self.boss_[i]:setPosition(x - dt * speed, y)
        end
    elseif self.myDt_ > 1.75 + nextBossId * 0.5 then
        GameData:setGameState(ConstDef.GAME_STATE.PLAY)
    end
end

return BossChooseView