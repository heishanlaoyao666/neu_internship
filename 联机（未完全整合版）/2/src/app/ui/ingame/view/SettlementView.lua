--[[--
    结算界面
    SettlementView.lua
]]

local SettlementView = class("SettlementView",function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 200))
end)

local GameData = require("app.data.ingame.GameData")
local ConstDef = require("app.def.ingame.ConstDef")

--角标映射
local angelMark = {
    "artcontent/battle(ongame)/battle_interface/angelmark_towertype/towertype_tapping.png",
    "artcontent/battle(ongame)/battle_interface/angelmark_towertype/towertype_disturbance.png",
    "artcontent/battle(ongame)/battle_interface/angelmark_towertype/towertype_sup.png",
    "artcontent/battle(ongame)/battle_interface/angelmark_towertype/towertype_control.png"
}

--[[--
    构造函数

    @param none

    @return none
]]
function SettlementView:ctor()
    self.enemyResult_ = nil -- 敌方胜负
    self.myResult_ = nil -- 我方胜负

    self.enemyName_ = nil -- 敌方名字
    self.myName_ = nil -- 我方名字

    self.enemyTrophyNum_ = nil -- 敌方奖杯数
    self.myTrophyNum_ = nil -- 我方奖杯数

    self.myTowers_ = {} -- 我阵容的塔
    self.enemyTowers_ = {} -- 敌方阵容的塔

    self:init()
    self:initView()
end

--[[--
    初始化

    @parm none

    @return none
]]
function SettlementView:init()
    self.myTowers_ = GameData:getMyTowers()
    self.enemyTowers_ = GameData:getEnemyTowers()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function SettlementView:initView()
    --敌方
    local spriteRes = "artcontent/lobby_ongame/currency/chestopen_ obtainitemspopup/basemap_popup.png"
    local enemySprite = cc.Sprite:create(spriteRes)
    enemySprite:setPosition(display.cx, display.cy + 300)
    enemySprite:setScale(1, 0.8)
    enemySprite:addTo(self)

    --敌方成败
    self.enemyResult_ = ccui.Text:create("???","artcontent/font/fzhzgbjw.ttf",60)
    self.enemyResult_:setPosition(display.cx - 50, display.cy - 310)
    self.enemyResult_:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 描边
    self.enemyResult_:enableShadow(cc.c3b(0, 0, 0), cc.size(0, 1), 1) -- 加阴影
    self.enemyResult_:setScale(0.8, 1)
    self.enemyResult_:addTo(enemySprite)

    --敌方标志
    local enemyMatk = cc.Sprite:create("artcontent/battle(ongame)/battle_interface/oppositemark.png")
    enemyMatk:setPosition(100, display.cy - 400)
    enemyMatk:setScale(0.8 * 1.2, 1 * 1.2)
    enemyMatk:addTo(enemySprite)

    --敌方名字底图
    local enemyNameSprite = cc.Sprite:create("artcontent/battle(ongame)/settlement_interface/basemap_text.png")
    enemyNameSprite:setPosition(180, display.cy - 400)
    enemyNameSprite:setScale(0.8 * 1.2, 1 * 1.2)
    enemyNameSprite:addTo(enemySprite)

    --敌方名字
    self.enemyName_ = ccui.Text:create("???","artcontent/font/fzhzgbjw.ttf",20)
    self.enemyName_:setScale(0.8 * 1.2, 1 * 1.2)
    self.enemyName_:setPosition(180, display.cy - 400)
    self.enemyName_:addTo(enemySprite)

    --敌方奖杯
    local enemyTrophySprite = cc.Sprite:create("artcontent/battle(ongame)/settlement_interface/icon_trophy.png")
    enemyTrophySprite:setPosition(400, display.cy - 400)
    enemyTrophySprite:setScale(0.8 * 1.2, 1 * 1.2)
    enemyTrophySprite:addTo(enemySprite)

    --敌方奖杯数底图
    local enemyTrophyNumSprite = cc.Sprite:create("artcontent/battle(ongame)/settlement_interface/basemap_text.png")
    enemyTrophyNumSprite:setScale(0.8 * 1.2, 1 * 1.2)
    enemyTrophyNumSprite:setPosition(480, display.cy - 400)
    enemyTrophyNumSprite:addTo(enemySprite)

    --敌方奖杯数
    self.enemyTrophyNum_ = ccui.Text:create("???","artcontent/font/fzhzgbjw.ttf",20)
    self.enemyTrophyNum_:setScale(0.8 * 1.2, 1 * 1.2)
    self.enemyTrophyNum_:setPosition(480, display.cy - 400)
    self.enemyTrophyNum_:addTo(enemySprite)

    local index_x = 100

    for i = 1, #self.enemyTowers_ do
        --头像
        local res = "artcontent/battle(ongame)/battle_interface/tower/tower_%d.png"
        local sprite =  string.format(res, self.enemyTowers_[i]:getTowerId())
        local towerSprite = cc.Sprite:create(sprite)
        towerSprite:setScale(0.8 * 0.8, 1 * 0.8)
        towerSprite:setPosition(index_x, 120)
        towerSprite:addTo(enemySprite)

        --等级
        res = "artcontent/battle(ongame)/battle_interface/grade/LV.%d.png"
        sprite = string.format(res, self.enemyTowers_[i]:getLevel())
        local levelSprite = cc.Sprite:create(sprite)
        levelSprite:setScale(0.8 * 0.8, 1 * 0.8)
        levelSprite:setPosition(index_x, 50)
        levelSprite:addTo(enemySprite)

        --塔类型角标
        local angleMarkSprite = cc.Sprite:create(angelMark[self.enemyTowers_[i]:getTowerType()])
        angleMarkSprite:setScale(0.8 * 0.8, 1 * 0.8)
        angleMarkSprite:setPosition(index_x + 33, 150)
        angleMarkSprite:addTo(enemySprite)
        index_x = index_x + 100
    end

    --我方
    local mySprite = cc.Sprite:create(spriteRes)
    mySprite:setPosition(display.cx, display.cy - 100)
    mySprite:setScale(1, 0.8)
    mySprite:addTo(self)

    --我方成败
    self.myResult_ = ccui.Text:create("???","artcontent/font/fzhzgbjw.ttf",60)
    self.myResult_:setPosition(display.cx - 50, display.cy - 310)
    self.myResult_:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 描边
    self.myResult_:enableShadow(cc.c3b(0, 0, 0), cc.size(0, 1), 1) -- 加阴影
    self.myResult_:setScale(0.8, 1)
    self.myResult_:addTo(mySprite)

    --我方标志
    local myMatk = cc.Sprite:create("artcontent/battle(ongame)/battle_interface/ourmark.png")
    myMatk:setPosition(100, display.cy - 400)
    myMatk:setScale(0.8 * 1.2, 1 * 1.2)
    myMatk:addTo(mySprite)

    --我方名字底图
    local myNameSprite = cc.Sprite:create("artcontent/battle(ongame)/settlement_interface/basemap_text.png")
    myNameSprite:setPosition(180, display.cy - 400)
    myNameSprite:setScale(0.8 * 1.2, 1 * 1.2)
    myNameSprite:addTo(mySprite)

    --我方名字
    self.myName_ = ccui.Text:create("???","artcontent/font/fzhzgbjw.ttf",20)
    self.myName_:setScale(0.8 * 1.2, 1 * 1.2)
    self.myName_:setPosition(180, display.cy - 400)
    self.myName_:addTo(mySprite)

    --我方奖杯
    local myTrophySprite = cc.Sprite:create("artcontent/battle(ongame)/settlement_interface/icon_trophy.png")
    myTrophySprite:setPosition(400, display.cy - 400)
    myTrophySprite:setScale(0.8 * 1.2, 1 * 1.2)
    myTrophySprite:addTo(mySprite)

    --我方奖杯数底图
    local myTrophyNumSprite = cc.Sprite:create("artcontent/battle(ongame)/settlement_interface/basemap_text.png")
    myTrophyNumSprite:setScale(0.8 * 1.2, 1 * 1.2)
    myTrophyNumSprite:setPosition(480, display.cy - 400)
    myTrophyNumSprite:addTo(mySprite)

    --我方奖杯数
    self.myTrophyNum_ = ccui.Text:create("???","artcontent/font/fzhzgbjw.ttf",20)
    self.myTrophyNum_:setScale(0.8 * 1.2, 1 * 1.2)
    self.myTrophyNum_:setPosition(480, display.cy - 400)
    self.myTrophyNum_:addTo(mySprite)

    index_x = 100

    for i = 1, #self.myTowers_ do
        --头像
        local res = "artcontent/battle(ongame)/battle_interface/tower/tower_%d.png"
        local sprite =  string.format(res, self.myTowers_[i]:getTowerId())
        local towerSprite = cc.Sprite:create(sprite)
        towerSprite:setScale(0.8 * 0.8, 1 * 0.8)
        towerSprite:setPosition(index_x, 120)
        towerSprite:addTo(mySprite)

        --等级
        res = "artcontent/battle(ongame)/battle_interface/grade/LV.%d.png"
        sprite = string.format(res, self.myTowers_[i]:getLevel())
        local levelSprite = cc.Sprite:create(sprite)
        levelSprite:setScale(0.8 * 0.8, 1 * 0.8)
        levelSprite:setPosition(index_x, 50)
        levelSprite:addTo(mySprite)

        --塔类型角标
        local angleMarkSprite = cc.Sprite:create(angelMark[self.myTowers_[i]:getTowerType()])
        angleMarkSprite:setScale(0.8 * 0.8, 1 * 0.8)
        angleMarkSprite:setPosition(index_x + 33, 150)
        angleMarkSprite:addTo(mySprite)
        index_x = index_x + 100
    end

    --确认按钮
    local confirmBtn = ccui.Button:create("artcontent/battle(ongame)/settlement_interface/button_ok.png")
    confirmBtn:setPosition(display.cx, display.cy - 380)
    confirmBtn:addTouchEventListener(function(sender, eventType)
        if eventType == 2 then
            self:setVisible(false)
            if GameData:isVictory() then
                GameData:setGameState(ConstDef.GAME_STATE.REWARD_VICTORY)
            else
                GameData:setGameState(ConstDef.GAME_STATE.REWARD_DEFREAT)
            end
            audio.playEffect("sounds/ui_btn_click.OGG")
        end
    end)
    confirmBtn:addTo(self)

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

    @param enemyResult 类型：string
    @param enemyName 类型：string
    @param enemyTrophyNum 类型：string
    @param myResult 类型：string
    @param myName 类型：string
    @param myTrophyNum 类型：string

    @return none
]]
function SettlementView:showView(enemyResult, enemyName, enemyTrophyNum, myResult, myName, myTrophyNum)
    
    self.enemyResult_:setString(enemyResult)
    self.enemyName_:setString(enemyName)
    self.enemyTrophyNum_:setString(enemyTrophyNum)
    self.myResult_:setString(myResult)
    self.myName_:setString(myName)
    self.myTrophyNum_:setString(myTrophyNum)
    self:setVisible(true)
    self:setScale(0)
    self:runAction(cc.ScaleTo:create(0.15, 1))
end

--[[--
    隐藏界面

    @param callback 类型：function，动画完成回调

    @return none
]]
function SettlementView:hideView(callback)
    self:runAction(cc.Sequence:create(
        cc.ScaleTo:create(0.15, 0), cc.CallFunc:create(function()
            self:setVisible(false)
            if callback then
                callback()
            end
        end)
    ))
end

return SettlementView