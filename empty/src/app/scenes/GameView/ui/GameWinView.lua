local EventDef = require("app.def.EventDef.lua")
local EventManager = require("app/manager/EventManager.lua")
--[[--
    结算界面
    ResultView.lua
]]
local GameWinView = class("GameWinView", function()
    return display.newColorLayer(cc.c4b(100, 100, 100, 100))
end)
local ConstDef = require("app/def/ConstDef.lua")
local GameData = require("app/data/GameData.lua")
local TowerDef     = require("app.def.TowerDef")
local width, height = 720, 1280
--[[--
    构造函数

    @param none

    @return none
]]
function GameWinView:ctor()
    self.container_ = nil -- 类型：Layout，控件容器

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function GameWinView:initView()

    self.container_ = ccui.Layout:create()
    self.container_:setBackGroundColor(cc.c3b(0, 0, 0))
    self.container_:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    self.container_:setBackGroundColorOpacity(128)--设置透明度
    self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, display.cy)

    self.winLayout = ccui.Layout:create()
    self.winLayout:setBackGroundColor(cc.c3b(255, 255, 255))
    self.winLayout:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    self.winLayout:setBackGroundColorOpacity(128)--设置透明度
    self.winLayout:setBackGroundColorType(1)
    self.winLayout:setContentSize(width, height*0.25)
    self.winLayout:addTo(self.container_)
    self.winLayout:setAnchorPoint(0.5, 0.5)
    self.winLayout:setPosition(display.cx, display.cy+height*0.2)

    --确认按钮
    local surrenderBtn = ccui.Button:create("ui/battle/Settlement interface/button-true.png")
    surrenderBtn:addTo(self.container_)
    surrenderBtn:setAnchorPoint(0.5, 0.5)
    surrenderBtn:setPosition(display.cx, height*0.1)
    surrenderBtn:addTouchEventListener(function(sender, eventType)
        if eventType == 2 then
            local Main = import("app.scenes.MainScene"):new()
            display.replaceScene(Main,"turnOffTiles",0.5)
        end
    end)
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
function GameWinView:showView(msg)
    --我方layout
    local player=GameData:getPlayer()

    self.player_name_ = cc.Label:createWithTTF(player:getName(),"ui/font/fzbiaozjw.ttf",30)
    self.player_name_:setPosition(width*0.2,height*0.2)
    self.player_name_:setAnchorPoint(0,0.5)
    self.player_name_:addTo(self.winLayout)
    --我方塔阵容
    local move_x=width*0.1
    for i = 1, 5 do
        --类型:table 塔信息 .id_(塔id) .level_(塔等级) .grade_(塔强化等级)
        local tower=player:getTowerArray()[i]
        local towerBtn=display.newSprite(string.format("ui/battle/Battle interface/Tower/tower_%u.png",tower.id_))
        --角标
        local res = "ui/battle/Battle interface/Angle sign-Tower_type/TowerType-"
        local as_tt= display.newSprite(string.format(res..TowerDef.TABLE[tower.id_].TYPE..".png"))
        as_tt:setAnchorPoint(0.5,0.5)
        as_tt:setPosition(75,80)
        towerBtn:addChild(as_tt)
        towerBtn:setScale(0.8)
        towerBtn:setPosition(width*0.05+move_x,height*0.12)
        move_x=move_x+width*0.18
        towerBtn:addTo(self.winLayout)
    end
    --我方
    local up_cup=display.newSprite("ui/battle/Settlement interface/icon-cup.png")
    up_cup:setPosition(width*0.6,height*0.2)
    up_cup:addTo(self.winLayout)
    local up_cup_bg=display.newSprite("ui/battle/Settlement interface/bg-text.png")
    up_cup_bg:setAnchorPoint(0,0.5)
    up_cup_bg:setPosition(40,20)
    up_cup_bg:addTo(up_cup)
    local up_cup_text = cc.Label:createWithTTF(msg["selfcup"],"ui/font/fzbiaozjw.ttf",20)
    up_cup_text:setAnchorPoint(0.5,0.5)
    up_cup_text:setPosition(40,15)
    up_cup_text:addTo(up_cup_bg)
    --基础奖励
    local get1_bg=display.newSprite("ui/battle/Settlement interface/bg-get.png")
    get1_bg:setAnchorPoint(0,0)
    get1_bg:setPosition(width*0.2,-height*0.1)
    get1_bg:addTo(self.winLayout)
    local get1_icon=display.newSprite("ui/battle/Settlement interface/icon-get1.png")
    get1_icon:setAnchorPoint(1,0)
    get1_icon:addTo(get1_bg)
    local get1_cup=display.newSprite("ui/battle/Settlement interface/icon-cup.png")
    get1_cup:setAnchorPoint(0.5,0.5)
    get1_cup:setPosition(40,20)
    get1_cup:addTo(get1_bg)
    local get1_cup_text=cc.Label:createWithTTF(string.format("+"..msg["cup1"]),"ui/font/fzbiaozjw.ttf",25)
    get1_cup_text:setAnchorPoint(0,0)
    get1_cup_text:setPosition(50,7)
    get1_cup_text:addTo(get1_cup)
    local get1_gold=display.newSprite("ui/battle/Settlement interface/icon-gold.png")
    get1_gold:setAnchorPoint(0.5,0.5)
    get1_gold:setPosition(180,20)
    get1_gold:addTo(get1_bg)
    local get1_gold_text=cc.Label:createWithTTF(string.format("+"..msg["gold1"]),"ui/font/fzbiaozjw.ttf",25)
    get1_gold_text:setAnchorPoint(0,0)
    get1_gold_text:setPosition(50,7)
    get1_gold_text:addTo(get1_gold)
    --连胜奖励
    local get2_bg=display.newSprite("ui/battle/Settlement interface/bg-get.png")
    get2_bg:setAnchorPoint(0,0)
    get2_bg:setPosition(width*0.2,-height*0.15)
    get2_bg:addTo(self.winLayout)
    local get2_icon=display.newSprite("ui/battle/Settlement interface/icon-get2.png")
    get2_icon:setAnchorPoint(1,0)
    get2_icon:addTo(get2_bg)
    local get2_cup=display.newSprite("ui/battle/Settlement interface/icon-cup.png")
    get2_cup:setAnchorPoint(0.5,0.5)
    get2_cup:setPosition(40,20)
    get2_cup:addTo(get2_bg)
    local get2_cup_text=cc.Label:createWithTTF(string.format("+"..msg["cup2"]),"ui/font/fzbiaozjw.ttf",25)
    get2_cup_text:setAnchorPoint(0,0)
    get2_cup_text:setPosition(50,7)
    get2_cup_text:addTo(get2_cup)
    local get2_gold=display.newSprite("ui/battle/Settlement interface/icon-gold.png")
    get2_gold:setAnchorPoint(0.5,0.5)
    get2_gold:setPosition(180,20)
    get2_gold:addTo(get2_bg)
    local get2_gold_text=cc.Label:createWithTTF(string.format("+"..msg["gold2"]),"ui/font/fzbiaozjw.ttf",25)
    get2_gold_text:setAnchorPoint(0,0)
    get2_gold_text:setPosition(50,7)
    get2_gold_text:addTo(get2_gold)
    --特殊奖励
    local get3_bg=display.newSprite("ui/battle/Settlement interface/bg-get.png")
    get3_bg:setAnchorPoint(0,0)
    get3_bg:setPosition(width*0.2,-height*0.2)
    get3_bg:addTo(self.winLayout)
    local get3_icon=display.newSprite("ui/battle/Settlement interface/icon-get3.png")
    get3_icon:setAnchorPoint(1,0)
    get3_icon:addTo(get3_bg)
    local get3_cup=display.newSprite("ui/battle/Settlement interface/icon-cup.png")
    get3_cup:setAnchorPoint(0.5,0.5)
    get3_cup:setPosition(40,20)
    get3_cup:addTo(get3_bg)
    local get3_cup_text=cc.Label:createWithTTF(string.format("+"..msg["cup3"]),"ui/font/fzbiaozjw.ttf",25)
    get3_cup_text:setAnchorPoint(0,0)
    get3_cup_text:setPosition(50,7)
    get3_cup_text:addTo(get3_cup)
    local get3_gold=display.newSprite("ui/battle/Settlement interface/icon-gold.png")
    get3_gold:setAnchorPoint(0.5,0.5)
    get3_gold:setPosition(180,20)
    get3_gold:addTo(get3_bg)
    local get3_gold_text=cc.Label:createWithTTF(string.format("+"..msg["gold3"]),"ui/font/fzbiaozjw.ttf",25)
    get3_gold_text:setAnchorPoint(0,0)
    get3_gold_text:setPosition(50,7)
    get3_gold_text:addTo(get3_gold)
    local get3_dim=display.newSprite("ui/battle/Settlement interface/icon-dim.png")
    get3_dim:setAnchorPoint(0.5,0.5)
    get3_dim:setPosition(320,20)
    get3_dim:addTo(get3_bg)
    local get3_dim_text=cc.Label:createWithTTF(string.format("+"..msg["dim3"]),"ui/font/fzbiaozjw.ttf",25)
    get3_dim_text:setAnchorPoint(0,0)
    get3_dim_text:setPosition(50,7)
    get3_dim_text:addTo(get3_dim)
    --总奖励
    local all_bg=display.newSprite("ui/battle/Settlement interface/bg-getall.png")
    all_bg:setAnchorPoint(0.5,0)
    all_bg:setPosition(display.cx,-height*0.3)
    all_bg:addTo(self.winLayout)
    local all_text=cc.Label:createWithTTF("总计","ui/font/fzbiaozjw.ttf",30)
    all_text:setAnchorPoint(0,0.5)
    all_text:setPosition(80,36)
    all_text:addTo(all_bg)
    local all_cup=display.newSprite("ui/battle/Settlement interface/icon-cup.png")
    all_cup:setAnchorPoint(0.5,0.5)
    all_cup:setPosition(200,36)
    all_cup:addTo(all_bg)
    local all_cup_text=cc.Label:createWithTTF(string.format("+"..msg["cup3"]+msg["cup1"]+msg["cup2"]),"ui/font/fzbiaozjw.ttf",25)
    all_cup_text:setAnchorPoint(0,0)
    all_cup_text:setPosition(50,7)
    all_cup_text:addTo(all_cup)
    local all_gold=display.newSprite("ui/battle/Settlement interface/icon-gold.png")
    all_gold:setAnchorPoint(0.5,0.5)
    all_gold:setPosition(340,36)
    all_gold:addTo(all_bg)
    local all_gold_text=cc.Label:createWithTTF(string.format("+"..msg["gold1"]+msg["gold2"]+msg["gold3"]),"ui/font/fzbiaozjw.ttf",25)
    all_gold_text:setAnchorPoint(0,0)
    all_gold_text:setPosition(50,7)
    all_gold_text:addTo(all_gold)
    local all_dim=display.newSprite("ui/battle/Settlement interface/icon-dim.png")
    all_dim:setAnchorPoint(0.5,0.5)
    all_dim:setPosition(480,36)
    all_dim:addTo(all_bg)
    local all_dim_text=cc.Label:createWithTTF(string.format("+"..msg["dim3"]),"ui/font/fzbiaozjw.ttf",25)
    all_dim_text:setAnchorPoint(0,0)
    all_dim_text:setPosition(50,7)
    all_dim_text:addTo(all_dim)
    EventManager:doEvent(EventDef.ID.SCORE_SHOW_1)
    self:setVisible(true)
    -- self.container_:setScale(0)
    -- self.container_:runAction(cc.ScaleTo:create(0.15, 1))
    -- self.scoreLabel_:setString("分数 : ".. GameData:getScore())

    -- self.historyLabel_:setString("历史最佳 : ".. GameData:getHistory())

    -- cc.UserDefault:getInstance():setIntegerForKey("history", GameData:getHistory())
end

--[[--
    隐藏界面

    @param callback 类型：function，动画完成回调

    @return none
]]
function GameWinView:hideView(callback)
    self.container_:runAction(cc.Sequence:create(
        cc.ScaleTo:create(0.15, 0), cc.CallFunc:create(function() 
            self:setVisible(false)
            if callback then
                callback()
            end
        end)
    ))
end

return GameWinView