--[[--
    结算界面
]]
local GameLoseView = class("GameLoseView", function()
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
function GameLoseView:ctor()
    self.container_ = nil -- 类型：Layout，控件容器

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function GameLoseView:initView()

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

    self.loseLayout = ccui.Layout:create()
    self.loseLayout:setBackGroundColor(cc.c3b(255, 255, 255))
    self.loseLayout:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    self.loseLayout:setBackGroundColorOpacity(128)--设置透明度
    self.loseLayout:setBackGroundColorType(1)
    self.loseLayout:setContentSize(width, height*0.25)
    self.loseLayout:addTo(self.container_)
    self.loseLayout:setAnchorPoint(0.5, 0.5)
    self.loseLayout:setPosition(display.cx, display.cy-height*0.2)
    --确认按钮
    local surrenderBtn = ccui.Button:create("ui/battle/Settlement interface/button-true.png")
    surrenderBtn:addTo(self.container_)
    surrenderBtn:setAnchorPoint(0.5, 0.5)
    surrenderBtn:setPosition(display.cx, height*0.1)
    surrenderBtn:addTouchEventListener(function(sender, eventType)
        if eventType == 2 then
            --返回大厅
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
function GameLoseView:showView(msg)
    
    local opposite=GameData:getGameOpposite()


    self.opposite_name_ = cc.Label:createWithTTF(opposite:getName(),"ui/font/fzbiaozjw.ttf",30)
    self.opposite_name_:setPosition(width*0.2,height*0.2)
    self.opposite_name_:setAnchorPoint(0,0.5)
    self.opposite_name_:addTo(self.winLayout)
    --敌方塔阵容
    local move_x=width*0.1
    for i = 1, 5 do
        --类型:table 塔信息 .id_(塔id) .level_(塔等级) .grade_(塔强化等级)
        local tower=opposite:getTowerArray()[i]
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
    --敌方奖杯
    local up_cup=display.newSprite("ui/battle/Settlement interface/icon-cup.png")
    up_cup:setPosition(width*0.6,height*0.2)
    up_cup:addTo(self.winLayout)
    local up_cup_bg=display.newSprite("ui/battle/Settlement interface/bg-text.png")
    up_cup_bg:setAnchorPoint(0,0.5)
    up_cup_bg:setPosition(40,20)
    up_cup_bg:addTo(up_cup)
    local up_cup_text = cc.Label:createWithTTF(msg["othercup"],"ui/font/fzbiaozjw.ttf",20)
    up_cup_text:setAnchorPoint(0.5,0.5)
    up_cup_text:setPosition(40,15)
    up_cup_text:addTo(up_cup_bg)
    --我方layout
    local player=GameData:getPlayer()

    self.player_name_ = cc.Label:createWithTTF(player:getName(),"ui/font/fzbiaozjw.ttf",30)
    self.player_name_:setPosition(width*0.2,height*0.2)
    self.player_name_:setAnchorPoint(0,0.5)
    self.player_name_:addTo(self.loseLayout)
    --敌方塔阵容
    move_x=width*0.1
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
        towerBtn:addTo(self.loseLayout)
    end
    --我方
    local down_cup=display.newSprite("ui/battle/Settlement interface/icon-cup.png")
    down_cup:setPosition(width*0.6,height*0.2)
    down_cup:addTo(self.loseLayout)
    local down_cup_bg=display.newSprite("ui/battle/Settlement interface/bg-text.png")
    down_cup_bg:setAnchorPoint(0,0.5)
    down_cup_bg:setPosition(40,20)
    down_cup_bg:addTo(down_cup)
    local down_cup_text = cc.Label:createWithTTF(msg["selfcup"],"ui/font/fzbiaozjw.ttf",20)
    down_cup_text:setAnchorPoint(0.5,0.5)
    down_cup_text:setPosition(40,15)
    down_cup_text:addTo(down_cup_bg)

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
function GameLoseView:hideView(callback)
    self.container_:runAction(cc.Sequence:create(
        cc.ScaleTo:create(0.15, 0), cc.CallFunc:create(function() 
            self:setVisible(false)
            if callback then
                callback()
            end
        end)
    ))
end

return GameLoseView