--[[--
    奖励界面
    RewardView.lua
]]

local RewardView = class("RewardView",function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 200))
end)

local OutGameData = require("app.data.outgame.OutGameData")
local GameData = require("app.data.ingame.GameData")

--角标映射
local angelMark = {
    "artcontent/battle_ongame/battle_interface/angelmark_towertype/towertype_tapping.png",
    "artcontent/battle_ongame/battle_interface/angelmark_towertype/towertype_disturbance.png",
    "artcontent/battle_ongame/battle_interface/angelmark_towertype/towertype_sup.png",
    "artcontent/battle_ongame/battle_interface/angelmark_towertype/towertype_control.png"
}

--[[--
    构造函数

    @param none

    @return none
]]
function RewardView:ctor()
    self.myResult_ = nil -- 我方胜负

    self.myName_ = nil -- 敌方名字
    self.myTrophyNum_ = nil -- 我方奖杯数
    self.myTowers_ = {} -- 我阵容的塔

    self.rewardTrophyNum_ = {} -- 获得的奖杯数
    self.rewardGoldNum_ = {} -- 或得的金币数
    self.rewardDiamondNum_ = {} -- 获得的钻石数


    self:init()
    self:initView()
end
--[[--
    初始化

    @parm none

    @return none
]]

function RewardView:init()
    self.myTowers_ = GameData:getMyTowers()
    self.rewardTrophyNum_ = {"?","?","?","?"}
    self.rewardGoldNum_ = {"?","?","?","?"}
    self.rewardDiamondNum_ = {"?","?"}
end

--[[--
    奖励视图

    @parm none

    @return none
]]
function RewardView:initView()
    --底图
    local spriteRes = "artcontent/lobby_ongame/currency/chestopen_ obtainitemspopup/basemap_popup.png"
    local mySprite = cc.Sprite:create(spriteRes)
    mySprite:setPosition(display.cx, display.cy + 200)
    mySprite:setScale(1, 0.8)
    mySprite:addTo(self)

    --我方成败
    self.myResult_ = ccui.Text:create("???","artcontent/font/fzhzgbjw.ttf",60)
    self.myResult_:setPosition(display.cx - 50, display.cy - 310)
    self.myResult_:setScale(0.8, 1)
    self.myResult_:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 描边
    self.myResult_:enableShadow(cc.c3b(0, 0, 0), cc.size(0, 1), 1) -- 加阴影
    self.myResult_:addTo(mySprite)

    --我方标志
    local myMatk = cc.Sprite:create("artcontent/battle_ongame/battle_interface/ourmark.png")
    myMatk:setPosition(100, display.cy - 400)
    myMatk:setScale(0.8 * 1.2, 1 * 1.2)
    myMatk:addTo(mySprite)

    --我方名字底图
    local myNameSprite = cc.Sprite:create("artcontent/battle_ongame/settlement_interface/basemap_text.png")
    myNameSprite:setPosition(180, display.cy - 400)
    myNameSprite:setScale(0.8 * 1.2, 1 * 1.2)
    myNameSprite:addTo(mySprite)

    --我方名字
    self.myName_ = ccui.Text:create("???","artcontent/font/fzhzgbjw.ttf",20)
    self.myName_:setScale(0.8 * 1.2, 1 * 1.2)
    self.myName_:setPosition(180, display.cy - 400)
    self.myName_:addTo(mySprite)

    --我方奖杯
    local myTrophySprite = cc.Sprite:create("artcontent/battle_ongame/settlement_interface/icon_trophy.png")
    myTrophySprite:setPosition(400, display.cy - 400)
    myTrophySprite:setScale(0.8 * 1.2, 1 * 1.2)
    myTrophySprite:addTo(mySprite)

    --我方奖杯数底图
    local myTrophyNumSprite = cc.Sprite:create("artcontent/battle_ongame/settlement_interface/basemap_text.png")
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
        local res = "artcontent/battle_ongame/battle_interface/tower/tower_%d.png"
        local sprite =  string.format(res, self.myTowers_[i]:getTowerId())
        local towerSprite = cc.Sprite:create(sprite)
        towerSprite:setScale(0.8 * 0.8, 1 * 0.8)
        towerSprite:setPosition(index_x, 120)
        towerSprite:addTo(mySprite)

        --等级
        res = "artcontent/battle_ongame/battle_interface/grade/LV.%d.png"
        sprite = string.format(res, self.myTowers_[i]:getLevel())
        local levelSprite = cc.Sprite:create(sprite)
        levelSprite:setScale(0.8 * 1.2, 1 * 1.2)
        levelSprite:setPosition(index_x, 50)
        levelSprite:addTo(mySprite)

        --塔类型角标
        local angleMarkSprite = cc.Sprite:create(angelMark[self.myTowers_[i]:getTowerType()])
        angleMarkSprite:setScale(0.8 * 0.8, 1 * 0.8)
        angleMarkSprite:setPosition(index_x + 33, 150)
        angleMarkSprite:addTo(mySprite)
        index_x = index_x + 100
    end

    --基础奖励图标
    local basicRewardSprite = cc.Sprite:create("artcontent/battle_ongame/settlement_interface/icon_basicreward.png")
    basicRewardSprite:setPosition(display.cx - 200, display.cy - 50)
    basicRewardSprite:addTo(self)

    --连胜奖励图标
    spriteRes = "artcontent/battle_ongame/settlement_interface/icon_winningstreakaward.png"
    local winningRewardSprite = cc.Sprite:create(spriteRes)
    winningRewardSprite:setPosition(display.cx - 200, display.cy - 120)
    winningRewardSprite:addTo(self)

    --buff奖励
    local buffReward = cc.Sprite:create("artcontent/battle_ongame/settlement_interface/icon_buffreward.png")
    buffReward:setPosition(display.cx - 200, display.cy - 190)
    buffReward:addTo(self)

    local index_y = display.cy - 50
    for i = 1, 3 do
        --奖励底图
        local rewardSprite = cc.Sprite:create("artcontent/battle_ongame/settlement_interface/basemap_reward.png")
        rewardSprite:setPosition(display.cx + 50, index_y)
        rewardSprite:addTo(self)

        --奖杯
        local trophySprite = cc.Sprite:create("artcontent/battle_ongame/settlement_interface/icon_trophy.png")
        trophySprite:setPosition(display.cx - 100, index_y)
        trophySprite:setScale(0.9)
        trophySprite:addTo(self)

        --奖杯数
        self.rewardTrophyNum_[i] = ccui.Text:create("+0", "artcontent/font/fzhzgbjw.ttf", 20)
        self.rewardTrophyNum_[i]:setPosition(display.cx - 50, index_y)
        self.rewardTrophyNum_[i]:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 描边
        self.rewardTrophyNum_[i]:enableShadow(cc.c3b(0, 0, 0), cc.size(0, 1), 1) -- 加阴影
        self.rewardTrophyNum_[i]:addTo(self)

        --金币
        local goldSprite = cc.Sprite:create("artcontent/battle_ongame/settlement_interface/icon_gold.png")
        goldSprite:setPosition(display.cx + 20, index_y)
        goldSprite:addTo(self)

        --金币数
        self.rewardGoldNum_[i] = ccui.Text:create("+0", "artcontent/font/fzhzgbjw.ttf", 20)
        self.rewardGoldNum_[i]:setPosition(display.cx + 70, index_y)
        self.rewardGoldNum_[i]:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 描边
        self.rewardGoldNum_[i]:enableShadow(cc.c3b(0, 0, 0), cc.size(0, 1), 1) -- 加阴影
        self.rewardGoldNum_[i]:addTo(self)

        index_y = index_y - 70
    end

    --钻石
    local diamondSprite = cc.Sprite:create("artcontent/battle_ongame/settlement_interface/icon_diamond.png")
    diamondSprite:setPosition(display.cx + 150, display.cy - 190)
    diamondSprite:addTo(self)

    --钻石数
    self.rewardDiamondNum_[1] = ccui.Text:create("+0", "artcontent/font/fzhzgbjw.ttf", 20)
    self.rewardDiamondNum_[1]:setPosition(display.cx + 200, display.cy - 190)
    self.rewardDiamondNum_[1]:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 描边
    self.rewardDiamondNum_[1]:enableShadow(cc.c3b(0, 0, 0), cc.size(0, 1), 1) -- 加阴影
    self.rewardDiamondNum_[1]:addTo(self)

    --总计底图
    local totalSprite = cc.Sprite:create("artcontent/battle_ongame/settlement_interface/basemap_tatalawards.png")
    totalSprite:setPosition(display.cx, display.cy - 300)
    totalSprite:addTo(self)

    --总计文字
    local totalText = ccui.Text:create("总计","artcontent/font/fzhzgbjw.ttf", 26)
    totalText:setPosition(display.cx - 250, display.cy - 300)
    totalText:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 描边
    totalText:enableShadow(cc.c3b(0, 0, 0), cc.size(0, 1), 1) -- 加阴影
    totalText:addTo(self)

    --奖杯
    trophySprite = cc.Sprite:create("artcontent/battle_ongame/settlement_interface/icon_trophy.png")
    trophySprite:setPosition(display.cx - 100, display.cy - 300)
    trophySprite:setScale(0.9)
    trophySprite:addTo(self)

    --总计奖杯
    self.rewardTrophyNum_[4] = ccui.Text:create("+0", "artcontent/font/fzhzgbjw.ttf", 20)
    self.rewardTrophyNum_[4]:setPosition(display.cx - 50, display.cy - 300)
    self.rewardTrophyNum_[4]:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 描边
    self.rewardTrophyNum_[4]:enableShadow(cc.c3b(0, 0, 0), cc.size(0, 1), 1) -- 加阴影
    self.rewardTrophyNum_[4]:addTo(self)

    --金币
    goldSprite = cc.Sprite:create("artcontent/battle_ongame/settlement_interface/icon_gold.png")
    goldSprite:setPosition(display.cx + 50, display.cy - 300)
    goldSprite:addTo(self)

    --总计金币
    self.rewardGoldNum_[4] = ccui.Text:create("+0", "artcontent/font/fzhzgbjw.ttf", 20)
    self.rewardGoldNum_[4]:setPosition(display.cx + 100, display.cy - 300)
    self.rewardGoldNum_[4]:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 描边
    self.rewardGoldNum_[4]:enableShadow(cc.c3b(0, 0, 0), cc.size(0, 1), 1) -- 加阴影
    self.rewardGoldNum_[4]:addTo(self)

    --钻石
    diamondSprite = cc.Sprite:create("artcontent/battle_ongame/settlement_interface/icon_diamond.png")
    diamondSprite:setPosition(display.cx + 200, display.cy - 300)
    diamondSprite:addTo(self)

    --总计钻石
    self.rewardDiamondNum_[2] = ccui.Text:create("+0", "artcontent/font/fzhzgbjw.ttf", 20)
    self.rewardDiamondNum_[2]:setPosition(display.cx + 250, display.cy - 300)
    self.rewardDiamondNum_[2]:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 描边
    self.rewardDiamondNum_[2]:enableShadow(cc.c3b(0, 0, 0), cc.size(0, 1), 1) -- 加阴影
    self.rewardDiamondNum_[2]:addTo(self)

    --确认按钮
    local confirmBtn = ccui.Button:create("artcontent/battle_ongame/settlement_interface/button_ok.png")
    confirmBtn:setPosition(display.cx, display.cy - 450)
    confirmBtn:addTouchEventListener(function(sender, eventType)
        if eventType == 2 then
            print("游戏结束")
            GameData:exit()
            cc.UserDefault:getInstance():setIntegerForKey("play",2)
            local AnotherScene=require("app.scenes.outgame.MainScene"):new()
            display.replaceScene(AnotherScene, "fade", 0.5)
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_btn_click.OGG")
            end
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

    @param myResult 类型：string
    @param myName 类型：string
    @param myTrophyNum 类型：string
    @parm trophy 类型：table
    @parm gold 类型：table
    @parm dimond  类型：number

    @return none
]]
function RewardView:showView(myResult, myName, myTrophyNum, trophy, gold, diamond)
    self.myResult_:setString(myResult)
    self.myName_:setString(myName)
    local totalTrophy, totalGold = 0, 0
    for i = 1, 3 do
        totalTrophy = totalTrophy + trophy[i]
        totalGold = totalGold + gold[i]
        local str1
        if trophy[i] >= 0 then
            str1 = "+"..tostring(trophy[i])
        else
            str1 = tostring(trophy[i])
        end
        self.rewardTrophyNum_[i]:setString(str1)
        local str2
        if gold[i] >= 0 then
            str2 = "+"..tostring(gold[i])
        else
            str2 = tostring(gold[i])
        end
        self.rewardGoldNum_[i]:setString(str2)
    end
    local str3
    if diamond >= 0 then
        str3 = "+"..tostring(diamond)
    else
        str3 = tostring(diamond)
    end
    self.rewardDiamondNum_[1]:setString(str3)
    local str4
    if totalTrophy >= 0 then
        str4 = "+"..tostring(totalTrophy)
    else
        str4 = tostring(totalTrophy)
    end
    self.rewardTrophyNum_[4]:setString(str4)
    local str5
    if totalGold >= 0 then
        str5 = "+"..tostring(totalGold)
    else
        str5 = tostring(totalGold)
    end
    OutGameData:setTrophy(totalTrophy)
    self.myTrophyNum_:setString(myTrophyNum + totalTrophy)
    OutGameData:setGold(totalGold)
    OutGameData:setDiamond(diamond)
    self.rewardGoldNum_[4]:setString(str5)
    self.rewardDiamondNum_[2]:setString(str3)
    self:setVisible(true)
    self:setScale(0)
    self:runAction(cc.ScaleTo:create(0.15, 1))
end

--[[--
    隐藏界面

    @param callback 类型：function，动画完成回调

    @return none
]]
function RewardView:hideView(callback)
    self:runAction(cc.Sequence:create(
        cc.ScaleTo:create(0.15, 0), cc.CallFunc:create(function()
            self:setVisible(false)
            if callback then
                callback()
            end
        end)
    ))
end

return RewardView