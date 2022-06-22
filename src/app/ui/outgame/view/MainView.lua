--[[--
    游戏主界面
    PlayView.lua
]]
local MainView = class("MainView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)
-- local BGLayer = require("app.mainui.layer.BGLayer")
local TopInfoLayer = require("src\\app\\ui\\outgame\\layer\\TopInfoLayer.lua")
local BottomInfoLayer = require("src\\app\\ui\\outgame\\layer\\BottomInfoLayer.lua")
local BattleLayer = require("src\\app\\ui\\outgame\\layer\\BattleLayer.lua")
local ShopLayer = require("src\\app\\ui\\outgame\\layer\\ShopLayer.lua")
--local BattleView = require("src\\app\\ui\\outgame\\view\\BattleView.lua")
-- local RegisterView = require("app.mainui.RegisterView")
-- local RankView = require("app.mainui.RankView")
-- local SettingView = require("app.mainui.SettingView")
-- local ConstDef = require("app.def.ConstDef")
-- local EventDef = require("app.def.EventDef")
-- local EventManager = require("app.manager.EventManager")

--[[--
    构造函数

    @param none

    @return none
]]
function MainView:ctor()
    self.TopInfoLayer_ = nil -- 类型：TopInfoLayer，顶部信息层
    self.BottomInfoLayer_ = nil -- 类型：BottomInfoLayer，底部信息层
    self:initView()

    self:registerScriptHandler(function(event)
        if event == "enter" then
            self:onEnter()
        elseif event == "exit" then
            self:onExit()
        end
    end)
end

--[[--
    界面初始化

    @param none

    @return none
]]
function MainView:initView()

    local page = ccui.PageView:create()
    local width, height = display.width, 1120

    do
        --战斗界面（游戏外）
        self.container_ = ccui.Layout:create()
        self.container_:setContentSize(display.width, height)
        self.container_:setPosition(0, 0)

        --底图
        local sprite = display.newSprite("res\\artcontent\\lobby(ongame)\\battle_interface\\basemap_interfaces.png")
        self.container_:addChild(sprite)
        sprite:setPosition(display.cx,display.cy)

        --对战模式按钮
        local button = ccui.Button:create("res\\artcontent\\lobby(ongame)\\battle_interface\\button_battlemode.png")
        self.container_:addChild(button)
        button:setAnchorPoint(0.5, 0.5)
        button:setPosition(width/2, height/2-30)
        button:addTouchEventListener(function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                -- body
                -- local AnotherScene=require("src\\app\\ui\\outgame\\layer\\ShopLayer.lua"):new()
                -- display.replaceScene(AnotherScene, "moveInL", 0.5)
                print("进入战斗")
            end
        end)
        --已选队伍底图
        local sprite1 = display.newSprite("res\\artcontent\\lobby(ongame)\\battle_interface\\basemap_selectedteams.png")
        self.container_:addChild(sprite1)
        sprite1:setPosition(display.cx,200)

        --天梯背景和ListView创建
        local sprite2 = display.newSprite("res\\artcontent\\lobby(ongame)\\battle_interface\\rank\\basemap_rank.png")
        self.container_:addChild(sprite2)
        sprite2:setPosition(display.cx,display.cy+300)
        local listView = ccui.ListView:create()
        listView:setContentSize(sprite2:getContentSize().width, sprite2:getContentSize().height)
        listView:setAnchorPoint(0.5, 0.5)
        listView:setPosition(display.cx,display.cy+300)
        listView:setDirection(2)
        listView:addTo(self.container_)
        for i=1,8 do
            local img = ccui.ImageView:
            create("res\\artcontent\\lobby(ongame)\\battle_interface\\rank\\locked_blueborder.png")
            listView:pushBackCustomItem(img)
        end

    end
    do
        --商店界面
        self.container_1 = ccui.Layout:create()
        self.container_1:setContentSize(display.width, height)
        self.container_1:setPosition(0, 0)

        local spriteB = display.newSprite("res\\artcontent\\lobby(ongame)\\store\\basemap_store.png")
        self.container_1:addChild(spriteB)
        spriteB:setPosition(display.cx,display.cy)

        local listViewB = ccui.ListView:create()
        listViewB:setContentSize(display.width, height)
        listViewB:setAnchorPoint(0.5, 0.5)
        listViewB:setPosition(display.cx,display.cy)
        listViewB:setDirection(1)
        listViewB:addTo(self.container_1)

        self.container_B1 = ccui.Layout:create()
        self.container_B1:setContentSize(display.width, height+70)
        self.container_B1:setAnchorPoint(0,0)
        self.container_B1:setPosition(0, 1)
        self.container_B1:addTo(listViewB)

        self.container_B2 = ccui.Layout:create()
        self.container_B2:setContentSize(display.width, height/2-300)
        self.container_B2:setAnchorPoint(0,0)
        self.container_B2:setPosition(0, 0)
        self.container_B2:addTo(listViewB)

        --金币商城
        local spriteB1 = display.newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\basemap_title.png")
        self.container_B1:addChild(spriteB1)
        spriteB1:setAnchorPoint(0.5, 1)
        spriteB1:setPosition(width/2,height-70)

        local spriteB2 = display.newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\title_goldstore.png")
        self.container_B1:addChild(spriteB2)
        spriteB2:setAnchorPoint(0.5, 1)
        spriteB2:setPosition(width/2,height-80)

        --金币商品
        local spriteB3 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\basemap_remainingrefreshtime.png")
        self.container_B1:addChild(spriteB3)
        spriteB3:setAnchorPoint(0.5, 1)
        spriteB3:setPosition(width/2,height-150)

        local spriteB4 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\goldstore\\basemap_freeitems.png")
        self.container_B1:addChild(spriteB4)
        spriteB4:setAnchorPoint(0.5, 1)
        spriteB4:setPosition(120,height-230)

        local spriteB5 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\goldstore\\basemap_freeitems.png")
        self.container_B1:addChild(spriteB5)
        spriteB5:setAnchorPoint(0.5, 1)
        spriteB5:setPosition(width/3+120,height-230)

        local spriteB6 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\goldstore\\basemap_freeitems.png")
        self.container_B1:addChild(spriteB6)
        spriteB6:setAnchorPoint(0.5, 1)
        spriteB6:setPosition(width*2/3+120,height-230)

        local spriteB7 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\goldstore\\basemap_freeitems.png")
        self.container_B1:addChild(spriteB7)
        spriteB7:setAnchorPoint(0.5, 1)
        spriteB7:setPosition(120,height-450)

        local spriteB8 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\goldstore\\basemap_freeitems.png")
        self.container_B1:addChild(spriteB8)
        spriteB8:setAnchorPoint(0.5, 1)
        spriteB8:setPosition(width/3+120,height-450)

        local spriteB9 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\goldstore\\basemap_freeitems.png")
        self.container_B1:addChild(spriteB9)
        spriteB9:setAnchorPoint(0.5, 1)
        spriteB9:setPosition(width*2/3+120,height-450)

        --砖石商城
        local spriteB10 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\basemap_diamondstore.png")
        self.container_B2:addChild(spriteB10)
        spriteB10:setAnchorPoint(0.5, 0)
        spriteB10:setPosition(width/2,650)

        local spriteB11 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\title_diamondstore.png")
        self.container_B2:addChild(spriteB11)
        spriteB11:setAnchorPoint(0.5, 0)
        spriteB11:setPosition(width/2,660)

        --普通宝箱
        local spriteB12 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\basemap_normal.png")
        self.container_B2:addChild(spriteB12)
        spriteB12:setAnchorPoint(0.5, 0)
        spriteB12:setPosition(120,350)

        local spriteB13 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\chest_normal.png")
        self.container_B2:addChild(spriteB13)
        spriteB13:setAnchorPoint(0.5, 0)
        spriteB13:setPosition(120,420)

        local spriteB14 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\titile_diamond.png")
        self.container_B2:addChild(spriteB14)
        spriteB14:setAnchorPoint(0.5, 0)
        spriteB14:setPosition(120,380)

        --稀有宝箱
        local spriteB15 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\basemap_rare.png")
        self.container_B2:addChild(spriteB15)
        spriteB15:setAnchorPoint(0.5, 0)
        spriteB15:setPosition(width/3+120,350)

        local spriteB16 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\chest_rare.png")
        self.container_B2:addChild(spriteB16)
        spriteB16:setAnchorPoint(0.5, 0)
        spriteB16:setPosition(width/3+120,420)

        local spriteB17 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\titile_diamond.png")
        self.container_B2:addChild(spriteB17)
        spriteB17:setAnchorPoint(0.5, 0)
        spriteB17:setPosition(width/3+90,380)

        --史诗宝箱
        local spriteB18 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\basemap_epic.png")
        self.container_B2:addChild(spriteB18)
        spriteB18:setAnchorPoint(0.5, 0)
        spriteB18:setPosition(width*2/3+120,350)

        local spriteB19 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\chest_epic.png")
        self.container_B2:addChild(spriteB19)
        spriteB19:setAnchorPoint(0.5, 0)
        spriteB19:setPosition(width*2/3+120,420)

        local spriteB20 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\titile_diamond.png")
        self.container_B2:addChild(spriteB20)
        spriteB20:setAnchorPoint(0.5, 0)
        spriteB20:setPosition(width*2/3+90,380)

        --传说宝箱
        local spriteB21 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\basemap_legend.png")
        self.container_B2:addChild(spriteB21)
        spriteB21:setAnchorPoint(0.5, 0)
        spriteB21:setPosition(width/3+120,30)

        local spriteB22 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\chest_legend.png")
        self.container_B2:addChild(spriteB22)
        spriteB22:setAnchorPoint(0.5, 0)
        spriteB22:setPosition(width/3+120,100)

        local spriteB23 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\titile_diamond.png")
        self.container_B2:addChild(spriteB23)
        spriteB23:setAnchorPoint(0.5, 0)
        spriteB23:setPosition(width/3+90,60)
    end

    do
        --图鉴界面
        self.container_2 = ccui.Layout:create()
        self.container_2:setContentSize(display.width, height)
        --page:addPage(self.container_2)
        self.container_2:setPosition(0, 0)

        --底图
        local spriteC = display.newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\basemap_guide.png")
        self.container_2:addChild(spriteC)
        spriteC:setAnchorPoint(0.5, 0.5)
        spriteC:setPosition(display.cx,display.cy)

        --当前阵容
        local spriteC7 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\basemap_area.png")
        self.container_2:addChild(spriteC7)
        spriteC7:setAnchorPoint(0.5, 1)
        spriteC7:setPosition(display.cx,height-150)

        local spriteC1 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\basemap_title.png")
        self.container_2:addChild(spriteC1)
        spriteC1:setAnchorPoint(0.5, 1)
        spriteC1:setPosition(display.cx,height-80)

        local spriteC2 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\text_currentlineup.png")
        self.container_2:addChild(spriteC2)
        spriteC2:setAnchorPoint(0.5, 1)
        spriteC2:setPosition(display.cx-110,height-100)

        local spriteC3 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\basemap_lineupconnection.png")
        self.container_2:addChild(spriteC3)
        spriteC3:setAnchorPoint(0.5, 1)
        spriteC3:setPosition(display.cx+80,height-110)

        local landscapeCheckBox1 = ccui.CheckBox:
        create("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\icon_unchecked.png",
        nil, "res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\icon_checked.png", nil, nil)
	    :align(display.LEFT_CENTER, -20, spriteC3:getContentSize().height/2)
	    :addTo(spriteC3)

        local landscapeCheckBox2 = ccui.CheckBox:
        create("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\icon_unchecked.png",
        nil, "res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\icon_checked.png", nil, nil)
	    :align(display.LEFT_CENTER, spriteC3:getContentSize().width/2-20, spriteC3:getContentSize().height/2)
	    :addTo(spriteC3)

        local landscapeCheckBox3 = ccui.CheckBox:
        create("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\icon_unchecked.png",
        nil, "res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\icon_checked.png", nil, nil)
	    :align(display.LEFT_CENTER, spriteC3:getContentSize().width-20, spriteC3:getContentSize().height/2)
	    :addTo(spriteC3)

        local spriteC4 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\number_1.png")
        landscapeCheckBox1:addChild(spriteC4)
        spriteC4:setAnchorPoint(0.5, 0.5)
        spriteC4:setPosition(landscapeCheckBox1:getContentSize().width/2,landscapeCheckBox1:getContentSize().height/2)

        local spriteC5 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\number_2.png")
        landscapeCheckBox2:addChild(spriteC5)
        spriteC5:setAnchorPoint(0.5, 0.5)
        spriteC5:setPosition(landscapeCheckBox2:getContentSize().width/2,landscapeCheckBox2:getContentSize().height/2)

        local spriteC6 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\number_3.png")
        landscapeCheckBox3:addChild(spriteC6)
        spriteC6:setAnchorPoint(0.5, 0.5)
        spriteC6:setPosition(landscapeCheckBox3:getContentSize().width/2,landscapeCheckBox3:getContentSize().height/2)

        -- self.container_C1 = ccui.Layout:create()
        -- self.container_C1:setContentSize(spriteC7:getContentSize().width, spriteC7:getContentSize().height)
        -- self.container_C1:setAnchorPoint(0.5,0.5)
        -- self.container_C1:setPosition(spriteC7:getContentSize().width/2, spriteC7:getContentSize().height/2)
        -- self.container_C1:addTo(self.container_2)

        -- local spriteC8 = display.
        -- newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\number_3.png")
        -- self.container_C1:addChild(spriteC8)
        -- spriteC8:setAnchorPoint(0.5, 0.5)
        -- spriteC8:setPosition(landscapeCheckBox3:getContentSize().width/2,landscapeCheckBox3:getContentSize().height/2)

        --已收集
        self.container_C1 = ccui.Layout:create()
        self.container_C1:setContentSize(spriteC7:getContentSize().width, spriteC7:getContentSize().height)
        self.container_C1:setAnchorPoint(0.5,0.5)
        self.container_C1:setPosition(spriteC7:getContentSize().width/2, spriteC7:getContentSize().height/2)
        self.container_C1:addTo(self.container_2)

        local spriteC8 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\number_3.png")
        self.container_C1:addChild(spriteC8)
        spriteC8:setAnchorPoint(0.5, 0.5)
        spriteC8:setPosition(landscapeCheckBox3:getContentSize().width/2,landscapeCheckBox3:getContentSize().height/2)

    end

    page:addPage(self.container_1)
    page:addPage(self.container_)
    page:addPage(self.container_2)
    self:addChild(page)
    page:setContentSize(720,1200)
    page:setTouchEnabled(true)
    page:setAnchorPoint(cc.p(0.5,0.5))
    page:setPosition(display.cx,display.cy)
    page:scrollToPage(1)

    cc.UserDefault:getInstance():setIntegerForKey("bottom",1)
    self.BottomInfoLayer_1 = BottomInfoLayer.new()
    self:addChild(self.BottomInfoLayer_1)
    self.BottomInfoLayer_1:setVisible(false)
    cc.UserDefault:getInstance():setIntegerForKey("bottom",2)
    self.BottomInfoLayer_2 = BottomInfoLayer.new()
    self:addChild(self.BottomInfoLayer_2)
    self.BottomInfoLayer_2:setVisible(false)
    cc.UserDefault:getInstance():setIntegerForKey("bottom",3)
    self.BottomInfoLayer_3 = BottomInfoLayer.new()
    self:addChild(self.BottomInfoLayer_3)
    self.BottomInfoLayer_3:setVisible(false)

    page:addEventListener(function(sender,event)
        if event==ccui.PageViewEventType.turning then
            self:setName(page:getCurPageIndex())
            print("当前页码是"..page:getCurPageIndex())
            if page:getCurPageIndex()==0 then
                self.BottomInfoLayer_1:setVisible(true)
                self.BottomInfoLayer_2:setVisible(false)
                self.BottomInfoLayer_3:setVisible(false)
            elseif page:getCurPageIndex()==1 then
                self.BottomInfoLayer_1:setVisible(false)
                self.BottomInfoLayer_2:setVisible(true)
                self.BottomInfoLayer_3:setVisible(false)
            elseif page:getCurPageIndex()==2 then
                self.BottomInfoLayer_1:setVisible(false)
                self.BottomInfoLayer_2:setVisible(false)
                self.BottomInfoLayer_3:setVisible(true)
            end

        end
    end)

    self.TopInfoLayer_ = TopInfoLayer.new()
    self:addChild(self.TopInfoLayer_)

end

--[[--
    节点进入

    @param none

    @return none
]]
function MainView:onEnter()
    -- EventManager:regListener(EventDef.ID.GAMESTATE_CHANGE, self, function(state)
    --     if state == ConstDef.GAME_STATE.PAUSE then
    --         self.pauseView_:showView()
    --     elseif state == ConstDef.GAME_STATE.RESULT then
    --         self.resultView_:showView()
    --     end
    -- end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function MainView:onExit()
    -- EventManager:unRegListener(EventDef.ID.GAMESTATE_CHANGE, self)
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function MainView:update(dt)
    -- self.bgLayer_:update(dt)
    -- self.fightLayer_:update(dt)
    -- self.TopInfoLayer_:update(dt)
end

return MainView