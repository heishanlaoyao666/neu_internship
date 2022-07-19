----内容：游戏外-战斗界面
----编写人员：孙靖博、郑蕾
---修订人员：郑蕾
---最后修改日期：7/15
local Battle = {}
local Ladder = require("app.scenes.HallView.battle.Ladder")
local Towerdata = require("app.data.Towerdata")
local TowerDef = require("app.def.TowerDef")
local GameData = require("app/data/GameData.lua")
local KnapsackData=require("app.data.KnapsackData")
local EventDef = require("app/def/EventDef.lua")
local EventManager = require("app/manager/EventManager.lua")
local Music = require("app.data.Music")
local SettingMusic = require("src.app.scenes.SettingMusic")
function Battle:ctor()
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.update))
    self:performWithDelay(function()
        self:scheduleUpdate()
    end,1)
end

--[[
    函数用途：（游戏外）战斗帧循环
    --]]
function Battle:update(dt)
    --self:teamRefresh(self.tower1,self.quality1,self.levels1)
end

function Battle:battlePanelCreate()
    local battleLayer = ccui.Layout:create()
    battleLayer:setBackGroundColorOpacity(180)--设置为透明
    --battleLayer:setBackGroundColorType(1)
    battleLayer:setAnchorPoint(0, 0)
    battleLayer:setPosition(0, display.top)
    battleLayer:setContentSize(720, 1280)

    --天梯
    Ladder:ladderCreate(battleLayer)

    --开始游戏按钮
    self:playGames(battleLayer)

    --当前队伍展示
    self:teamShow(battleLayer)

    return battleLayer
end

--[[
    函数用途：创建灰色背景
    --]]
function Battle:grayLayer(battleLayer)--参数：层
    local width ,height = display.width,display.height
    local grayLayer = ccui.Layout:create()
    grayLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    grayLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    grayLayer:setBackGroundColorOpacity(128)--设置透明度
    grayLayer:setContentSize(width, height)
    grayLayer:pos(width/2, height/2+140)
    grayLayer:setAnchorPoint(0.5, 0.5)
    grayLayer:addTo(battleLayer)
    grayLayer:setTouchEnabled(true)--屏蔽一级界面
    return grayLayer
end

--[[
    函数用途：新游戏按钮
    --]]
function Battle:playGames(battleLayer)
    local images = {
        normal = "ui/hall/battle/Button-Battle_Mode.png",
        pressed = "",
        disabled = "ui/hall/battle/Button-Battle_Mode.png"
    }
    local NewGameBtn = ccui.Button:create(images["normal"], images["pressed"], images["disabled"])
    NewGameBtn:setScale(0.9)
    NewGameBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    NewGameBtn:setPosition(cc.p(display.cx, display.cy+70))
    NewGameBtn:setEnabled(true)
    NewGameBtn:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            self:matchingPopLayer(battleLayer)
        end
    end)
    NewGameBtn:addTo(battleLayer)
end

--[[
    函数用途：匹配弹窗
    --]]
function Battle:matchingPopLayer(battleLayer)
    GameData:init()
    KnapsackData:gameMatch()
    EventManager:regListener(EventDef.ID.CREATE_GAME, self, function(msg)
        GameData:playerInit(msg)
        local ABtn = import("app.scenes.GameView.GameScene"):new()
        display.replaceScene(ABtn,"turnOffTiles",0.5)
        EventManager:unRegListener(EventDef.ID.CREATE_GAME, self)
    end)
    --灰色背景
    local grayLayer = self:grayLayer(battleLayer)
    --弹窗背景
    local popLayer = ccui.ImageView:create("ui/hall/battle/SecondaryInterface-matching/bg-pop-up.png")
    popLayer:setPosition(display.cx,display.cy)
    popLayer:addTo(grayLayer)
    popLayer:setTouchEnabled(true)
    --匹配动画
    local matchImage = ccui.ImageView:create("ui/hall/battle/SecondaryInterface-matching/group 128.png")
    matchImage:pos(260, 190)
    matchImage:setAnchorPoint(0.5, 0.5)
    matchImage:addTo(popLayer)
    --回调函数，进入游戏内界面
    local function callBack()
        return true
    end
    local rotate  = cc.RotateBy:create(360,360*360);--旋转
    local sequence = cc.Sequence:create(rotate,rotate,rotate,cc.CallFunc:create(callBack))
    matchImage:runAction(sequence)
    -- local MusicOn = SettingMusic:isMusic1()
    -- print(MusicOn)
    -- if MusicOn == true then
    --     local audio = require("framework.audio")
    --     audio.loadFile(Music.BATTLEMATCH[1], function ()
    --         audio.playEffect(Music.BATTLEMATCH[1])
    --     end)
    -- else
    --     local audio = require("framework.audio")
    --     audio.loadFile(Music.BATTLEMATCH[1], function ()
    --         audio.stopEffect()
    --     end)
    -- end

    --取消匹配按钮
    self:cancelButton(grayLayer,popLayer)
    
end

--[[
    函数用途：取消按钮
    --]]
function Battle:cancelButton(grayLayer,popLayer)
    --按钮：确认按钮
    local cancelButton = ccui.Button:create(
            "ui/hall/battle/SecondaryInterface-matching/Button-cancel.png",
            "ui/hall/battle/SecondaryInterface-matching/Button-cancel.png",
            "ui/hall/battle/SecondaryInterface-matching/Button-cancel.png")
    cancelButton:setPosition(260, 80)
    cancelButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            self:setButtonScale(1,0.9,sender)

        elseif eventType == ccui.TouchEventType.ended then
            self:setButtonScale(1,1,sender)
            grayLayer:setVisible(false)
            KnapsackData:cancelMatch()
        elseif eventType == ccui.TouchEventType.canceled then
            self:setButtonScale(1,1,sender)

        end
    end)
    cancelButton:addTo(popLayer)
end

--[[
    函数用途:当前队伍展示
    --]]
function Battle:teamShow(layer)
    local showLayer = ccui.Layout:create()
    showLayer:setBackGroundColorOpacity(180)--设置为透明
    --showLayer:setBackGroundColorType(1)
    showLayer:setContentSize(662,140)
    showLayer:setAnchorPoint(0, 0)
    showLayer:setPosition(30, 310)
    showLayer:addTo(layer)
    self:createTroopItem(showLayer,KnapsackData:getTowerArray(1)[1].tower_id_,0)
    self:createTroopItem(showLayer,KnapsackData:getTowerArray(1)[2].tower_id_,130*1)
    self:createTroopItem(showLayer,KnapsackData:getTowerArray(1)[3].tower_id_,130*2)
    self:createTroopItem(showLayer,KnapsackData:getTowerArray(1)[4].tower_id_,130*3)
    self:createTroopItem(showLayer,KnapsackData:getTowerArray(1)[5].tower_id_,130*4)
end

function Battle:teamRefresh(tower,quality,levels)
    tower:loadTexture(Towerdata.OBTAINED[KnapsackData:getTowerArray(1)[1].tower_id_])
    quality:loadTexture("ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_"..TowerDef.TABLE[Towerdata.OBTAINED[KnapsackData:getTowerArray(1)[1].tower_id_]].TYPE..".png")
    levels:loadTexture("ui/hall/Atlas/Subinterface_currentsquad/rank/lv."..KnapsackData:getTowerGrade(tonumber(string.sub(Towerdata.OBTAINED[KnapsackData:getTowerArray(1)[1].tower_id_],27,-5)))..".png")
end


--[[
    函数用途：创建阵容内的塔
    参数：i--塔总列表中的顺序
          troop--第几个阵容
          location--在阵容中的位置
    --]]
function Battle:createTroopItem(layer,i,offsetX)
    --图片路径
    local path = Towerdata.OBTAINED[i]
    --塔类型
    local towerType = "ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_"..TowerDef.TABLE[i].TYPE..".png"
    --塔ID
    local id = tonumber(string.sub(path,27,-5))
    --塔等级
    local level = "ui/hall/Atlas/Subinterface_currentsquad/rank/lv."..KnapsackData:getTowerGrade(id)..".png"

    --按钮
    local ItemButton = ccui.ImageView:create(path)
    ItemButton:setPosition(cc.p(75+offsetX, 100))
    ItemButton:setTouchEnabled(true)
    ItemButton:addTo(layer)

    --攻击 辅助 控制 干扰 召唤
    local quality =ccui.ImageView:create(towerType)
    quality:setPosition(cc.p(90, 100))
    quality:addTo(ItemButton)

    --等级
    local levels =ccui.ImageView:create(level)
    levels:setPosition(cc.p(60, -20))
    levels:addTo(ItemButton)

    return
end



--[[
    函数用途：按钮放缩特效
    --]]
function Battle:setButtonScale(X,Y,sender)
    local scale = cc.ScaleTo:create(X,Y)
    local ease_elastic = cc.EaseElasticOut:create(scale)
    sender:runAction(ease_elastic)
end

return Battle