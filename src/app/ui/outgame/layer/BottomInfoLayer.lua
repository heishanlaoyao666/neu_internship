--[[--
    信息层
    BottomInfoLayer.lua
]]
local BottomInfoLayer = class("BottomInfoLayer", require("src\\app\\ui\\outgame\\layer\\BaseLayer.lua"))
-- local ConstDef = require("app.def.ConstDef")
-- local GameData = require("app.data.GameData")
--local BattleView = require("src\\app\\ui\\outgame\\view\\BattleView.lua")
--[[--
    构造函数

    @param none

    @return none
]]
function BottomInfoLayer:ctor()
    BottomInfoLayer.super.ctor(self)

    -- self.lifeLabelBmf_ = nil -- 类型：TextBMFont，生命值
    -- self.scoreLabelBmf_ = nil -- 类型：TextBMFont，分值
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function BottomInfoLayer:initView()
    --cc.UserDefault:getInstance():setIntegerForKey("bottom",2)
    local width, height = display.width, 80
    self.container_ = ccui.Layout:create()
    --self.container_:setBackGroundColor(cc.c3b(200, 0, 0))
    --self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(display.width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0)
    self.container_:setPosition(display.cx, 0)

    local sprite = ccui.ImageView:create("res\\artcontent\\lobby(ongame)\\bottombar_tabbutton\\tab_unchecked_left.png")
    self.container_:addChild(sprite)
    sprite:setScale9Enabled(true)
    sprite:setContentSize(cc.size(width/3, 120))
    sprite:setAnchorPoint(0, 0)
    sprite:setScale(1)
    sprite:setPosition(0, 0)

    local sprite1 = ccui.ImageView:
    create("res\\artcontent\\lobby(ongame)\\bottombar_tabbutton\\tab_unchecked_medium.png")
    self.container_:addChild(sprite1)
    sprite1:setScale9Enabled(true)
    sprite1:setContentSize(cc.size(width/3, 120))
    sprite1:setAnchorPoint(0, 0)
    sprite1:setScale(1)
    sprite1:setPosition(width/3, 0)

    local sprite2 = ccui.ImageView:
    create("res\\artcontent\\lobby(ongame)\\bottombar_tabbutton\\tab_unchecked_right.png")
    self.container_:addChild(sprite2)
    sprite2:setScale9Enabled(true)
    sprite2:setContentSize(cc.size(width/3, 120))
    sprite2:setAnchorPoint(0, 0)
    sprite2:setScale(1)
    sprite2:setPosition(width*2/3, 0)

    local sprite3 = ccui.ImageView:
    create("res\\artcontent\\lobby(ongame)\\bottombar_tabbutton\\tab_currently_selected.png")
    self.container_:addChild(sprite3)
    sprite3:setScale9Enabled(true)
    sprite3:setContentSize(cc.size(width/3, 140))
    sprite3:setAnchorPoint(0, 0)
    sprite3:setScale(1)
    sprite3:setPosition(width/3, 0)
    -- local landscapeCheckBox1 = ccui.CheckBox:create("res\\美术资源\\大厅（游戏外）\\底部栏-tab按钮\\tab-未选中-左.png",
    -- nil, "res\\美术资源\\大厅（游戏外）\\底部栏-tab按钮\\tab-当前选中.png", nil, nil)
    -- --:setAnchorPoint(0.5, 0)
	-- :align(display.LEFT_CENTER, 0,60)
	-- :addTo(self.container_,1)
    -- landscapeCheckBox1:setSelected(false)

    -- local landscapeCheckBox2 = ccui.CheckBox:create("res\\美术资源\\大厅（游戏外）\\底部栏-tab按钮\\tab-未选中-中.png",
    -- nil, "res\\美术资源\\大厅（游戏外）\\底部栏-tab按钮\\tab-当前选中.png", nil, nil)
    -- --:setAnchorPoint(0.5, 0)
	-- :align(display.LEFT_CENTER,width/3,60)
	-- :addTo(self.container_,2)
    -- landscapeCheckBox2:setSelected(true)

    -- local landscapeCheckBox3 = ccui.CheckBox:create("res\\美术资源\\大厅（游戏外）\\底部栏-tab按钮\\tab-未选中-右.png",
    -- nil, "res\\美术资源\\大厅（游戏外）\\底部栏-tab按钮\\tab-当前选中.png", nil, nil)
    -- --:setAnchorPoint(0.5, 0)
	-- :align(display.LEFT_CENTER,width*2/3,60)
	-- :addTo(self.container_,1)
    -- landscapeCheckBox3:setSelected(false)

    local sprite4 = display.newSprite("res\\artcontent\\lobby(ongame)\\bottombar_tabbutton\\icon_atlas.png")
    self.container_:addChild(sprite4)
    sprite4:setAnchorPoint(0.5, 0)
    sprite4:setScale(1)
    sprite4:setPosition(120, 0)

    local sprite5 = display.newSprite("res\\artcontent\\lobby(ongame)\\bottombar_tabbutton\\title_atlas.png")
    self.container_:addChild(sprite5)
    sprite5:setAnchorPoint(0.5, 0)
    sprite5:setPosition(120, 0)
    sprite5:setVisible(false)

    local sprite6 = display.newSprite("res\\artcontent\\lobby(ongame)\\bottombar_tabbutton\\icon_battle.png")
    self.container_:addChild(sprite6)
    sprite6:setAnchorPoint(0.5, 0)
    sprite6:setScale(1)
    sprite6:setPosition(width/3+120, 0)

    local sprite7 = display.newSprite("res\\artcontent\\lobby(ongame)\\bottombar_tabbutton\\title_battle.png")
    self.container_:addChild(sprite7)
    sprite7:setAnchorPoint(0.5, 0)
    sprite7:setPosition(width/3+120, 0)
    sprite7:setVisible(true)

    local sprite8 = display.newSprite("res\\artcontent\\lobby(ongame)\\bottombar_tabbutton\\icon_store.png")
    self.container_:addChild(sprite8)
    sprite8:setAnchorPoint(0.5, 0)
    sprite8:setScale(1)
    sprite8:setPosition(width*2/3+120, 0)

    local sprite9 = display.newSprite("res\\artcontent\\lobby(ongame)\\bottombar_tabbutton\\title_store.png")
    self.container_:addChild(sprite9)
    sprite9:setAnchorPoint(0.5, 0)
    sprite9:setPosition(width*2/3+120, 0)
    sprite9:setVisible(false)

    if cc.UserDefault:getInstance():getIntegerForKey("bottom")==1 then
        sprite3:setPosition(0, 0)
        sprite4:setPositionY(20)
        sprite5:setVisible(true)
        sprite6:setPositionY(0)
        sprite7:setVisible(false)
        sprite8:setPositionY(0)
        sprite9:setVisible(false)
    elseif cc.UserDefault:getInstance():getIntegerForKey("bottom")==2 then
        sprite3:setPosition(width/3, 0)
        sprite4:setPositionY(0)
        sprite5:setVisible(false)
        sprite6:setPositionY(20)
        sprite7:setVisible(true)
        sprite8:setPositionY(0)
        sprite9:setVisible(false)
    elseif cc.UserDefault:getInstance():getIntegerForKey("bottom")==3 then
        sprite3:setPosition(width*2/3, 0)
        sprite4:setPositionY(0)
        sprite5:setVisible(false)
        sprite6:setPositionY(0)
        sprite7:setVisible(false)
        sprite8:setPositionY(20)
        sprite9:setVisible(true)
        -- local AnotherScene=BattleView.new()
        -- --self:addChild(AnotherScene)
        -- display.replaceScene(AnotherScene, "fade", 0.5)
    end
    -- landscapeCheckBox2:addEventListener(function(sender, eventType)
	-- 	-- body
	-- 	if 1==eventType then--1是没选上0是选上
    --         sprite2:setPosition(120, 0)
    --         sprite2:setScale(1)
    --         sprite3:setVisible(false)
	--     else
    --         --landscapeCheckBox2:addTo(self.container_,2)
    --         sprite2:setPosition(120, 20)
    --         sprite2:setScale(1.1)
    --         sprite3:setVisible(true)
	--     end
	-- end)

end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function BottomInfoLayer:update(dt)

end

return BottomInfoLayer

