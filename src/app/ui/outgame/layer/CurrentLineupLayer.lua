--[[--
    当前阵容层
    CurrentLineupLayer.lua
]]
local CurrentLineupLayer = class("CurrentLineupLayer", require("app.ui.outgame.layer.BaseLayer"))
local OutGameData = require("app.data.outgame.OutGameData")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local CurrentTowerLayer = require("app.ui.outgame.layer.CurrentTowerLayer")
--[[--
    构造函数

    @param none

    @return none
]]
function CurrentLineupLayer:ctor()
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function CurrentLineupLayer:initView()
    local tempfilename
    local width, height = display.width, 1120
    self.container_2 = ccui.Layout:create()
    self.container_2:setContentSize(display.width, display.height)
    self:addChild(self.container_2)
    self.container_2:setPosition(0, 0)
    --当前阵容区域底图
    local spriteC7 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/current_lineup/basemap_area.png")
    self.container_2:addChild(spriteC7)
    spriteC7:setAnchorPoint(0.5, 1)
    spriteC7:setPosition(display.cx,height-140)

    --当前阵容
    -- self.container_lineups = ccui.Layout:create()
    -- self.container_lineups:setContentSize(spriteC7:getContentSize().width, spriteC7:getContentSize().height)
    -- spriteC7:addChild(self.container_lineups)
    -- self.container_lineups:setAnchorPoint(0.5, 0.5)
    -- self.container_lineups:setPosition(spriteC7:getContentSize().width/2, spriteC7:getContentSize().height/2)

    id=self.id
    CurrentTowerLayer:setContentSize(spriteC7:getContentSize().width,spriteC7:getContentSize().height)
    CurrentTowerLayer:setId(id)
    CurrentTowerLayer:new():addTo(spriteC7)
    -- self.typefilename={"artcontent/lobby(ongame)/atlas_interface/current_lineup/towertype_tapping.png",
    -- "artcontent/lobby(ongame)/atlas_interface/current_lineup/towertype_disturbance.png",
    -- "artcontent/lobby(ongame)/atlas_interface/current_lineup/towertype_sup.png",
    -- "artcontent/lobby(ongame)/atlas_interface/current_lineup/towertype_control.png"}
    -- --塔
    -- for i=1,5 do
    --     tempfilename=string.format("artcontent/lobby(ongame)/currency/icon_tower/%02d.png", table[i])
    --     local towerbtn = ccui.Button:create(tempfilename)
    --     self.container_lineups:addChild(towerbtn)
    --     towerbtn:setScale(0.9)
    --     towerbtn:setAnchorPoint(0.5, 0)
    --     towerbtn:setPosition(spriteC7:getContentSize().width/2+(120*i-360),spriteC7:getContentSize().height/2-40)
    --     towerbtn:addTouchEventListener(
    --         function(sender, eventType)
    --             -- ccui.TouchEventType
    --             if 2 == eventType then -- touch end
    --                 if cc.UserDefault:getInstance():getBoolForKey("音效") then
    --                     audio.playEffect("sounds/ui_btn_click.OGG",false)
    --                 end
    --                 cc.UserDefault:getInstance():setIntegerForKey("current2",self.id)
    --                 print(cc.UserDefault:getInstance():getIntegerForKey("current2"))
    --                 EventManager:doEvent(EventDef.ID.KNAPSACK_CHANGE)
    --                 self:removeFromParent(true)
    --             end
    --         end
    --     )
    --     --等级底图
    --     local spriteD7 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/current_lineup/basemap_grade.png")
    --     towerbtn:addChild(spriteD7)
    --     spriteD7:setAnchorPoint(0.5, 0)
    --     spriteD7:setPosition(towerbtn:getContentSize().width/2,-30)

    --     tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_list/grade/Lv.%d.png"
    --     local spriteD9 = display.newSprite(string.format(tempfilename,OutGameData:getTower(table[i]):getLevel()))
    --     spriteD7:addChild(spriteD9)
    --     spriteD9:setAnchorPoint(0.5, 0.5)
    --     spriteD9:setPosition(spriteD7:getContentSize().width/2,spriteD7:getContentSize().height/2)

    --     local spriteD10 = display.newSprite(self.typefilename[OutGameData:getTower(table[i]):getTowerType()])
    --     towerbtn:addChild(spriteD10)
    --     spriteD10:setAnchorPoint(1, 1)
    --     spriteD10:setPosition(towerbtn:getContentSize().width-20,towerbtn:getContentSize().height)
    -- end

    --当前阵容标题底图
    local spriteC1 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/current_lineup/basemap_title.png")
    self.container_2:addChild(spriteC1)
    spriteC1:setAnchorPoint(0.5, 1)
    spriteC1:setPosition(display.cx,height-70)

    --当前阵容标题文本
    local spriteC2 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/current_lineup/text_currentlineup.png")
    self.container_2:addChild(spriteC2)
    spriteC2:setAnchorPoint(0.5, 1)
    spriteC2:setPosition(display.cx-110,height-100)

    --阵容连线
    tempfilename="artcontent/lobby(ongame)/atlas_interface/current_lineup/basemap_lineupconnection.png"
    local spriteC3 = display.newSprite(tempfilename)
    self.container_2:addChild(spriteC3)
    spriteC3:setAnchorPoint(0.5, 1)
    spriteC3:setPosition(display.cx+80,height-110)

    --三个阵容按钮
    local landscapeCheckBox1 = ccui.CheckBox:
    create("artcontent/lobby(ongame)/atlas_interface/current_lineup/icon_unchecked.png",
    nil, "artcontent/lobby(ongame)/atlas_interface/current_lineup/icon_checked.png", nil, nil)
    :align(display.LEFT_CENTER, -20, spriteC3:getContentSize().height/2)
    :addTo(spriteC3)
    landscapeCheckBox1:setSelected(true)

    local landscapeCheckBox2 = ccui.CheckBox:
    create("artcontent/lobby(ongame)/atlas_interface/current_lineup/icon_unchecked.png",
    nil, "artcontent/lobby(ongame)/atlas_interface/current_lineup/icon_checked.png", nil, nil)
    :align(display.LEFT_CENTER, spriteC3:getContentSize().width/2-20, spriteC3:getContentSize().height/2)
    :addTo(spriteC3)

    local landscapeCheckBox3 = ccui.CheckBox:
    create("artcontent/lobby(ongame)/atlas_interface/current_lineup/icon_unchecked.png",
    nil, "artcontent/lobby(ongame)/atlas_interface/current_lineup/icon_checked.png", nil, nil)
    :align(display.LEFT_CENTER, spriteC3:getContentSize().width-20, spriteC3:getContentSize().height/2)
    :addTo(spriteC3)

    local spriteC4 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/current_lineup/number_1.png")
    landscapeCheckBox1:addChild(spriteC4)
    spriteC4:setAnchorPoint(0.5, 0.5)
    spriteC4:setPosition(landscapeCheckBox1:getContentSize().width/2,landscapeCheckBox1:getContentSize().height/2)

    local spriteC5 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/current_lineup/number_2.png")
    landscapeCheckBox2:addChild(spriteC5)
    spriteC5:setAnchorPoint(0.5, 0.5)
    spriteC5:setPosition(landscapeCheckBox2:getContentSize().width/2,landscapeCheckBox2:getContentSize().height/2)

    local spriteC6 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/current_lineup/number_3.png")
    landscapeCheckBox3:addChild(spriteC6)
    spriteC6:setAnchorPoint(0.5, 0.5)
    spriteC6:setPosition(landscapeCheckBox3:getContentSize().width/2,landscapeCheckBox3:getContentSize().height/2)

    landscapeCheckBox1:addEventListener(function(sender, eventType)
		-- body
		if 1==eventType then--1是没选上0是选上
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_towerbtn_click.OGG",false)
            end
	    else
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_towerbtn_click.OGG",false)
            end
            landscapeCheckBox2:setSelected(false)
            landscapeCheckBox3:setSelected(false)
	    end
	end)
    landscapeCheckBox2:addEventListener(function(sender, eventType)
		-- body
		if 1==eventType then--1是没选上0是选上
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_towerbtn_click.OGG",false)
            end
	    else
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_towerbtn_click.OGG",false)
            end
            landscapeCheckBox1:setSelected(false)
            landscapeCheckBox3:setSelected(false)
	    end
	end)
    landscapeCheckBox3:addEventListener(function(sender, eventType)
		-- body
		if 1==eventType then--1是没选上0是选上
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_towerbtn_click.OGG",false)
            end
	    else
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_towerbtn_click.OGG",false)
            end
            landscapeCheckBox1:setSelected(false)
            landscapeCheckBox2:setSelected(false)
	    end
	end)

end

--[[--
    传入塔id

    @param id 类型：number，塔id

    @return none
]]
function CurrentLineupLayer:setId(id)
    self.id=id
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function CurrentLineupLayer:update(dt)
end

return CurrentLineupLayer