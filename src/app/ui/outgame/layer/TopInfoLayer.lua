--[[--
    信息层
    TopInfoLayer.lua
]]
local TopInfoLayer = class("TopInfoLayer", require("src\\app\\ui\\outgame\\layer\\BaseLayer.lua"))
local OutGameData = require("src\\app\\data\\outgame\\OutGameData.lua")

--[[--
    构造函数

    @param none

    @return none
]]
function TopInfoLayer:ctor()
    TopInfoLayer.super.ctor(self)
    cc.UserDefault:getInstance():setStringForKey("昵称","久妹")
    cc.UserDefault:getInstance():setIntegerForKey("奖杯数",2250)
    cc.UserDefault:getInstance():setIntegerForKey("金币数",10000)
    cc.UserDefault:getInstance():setIntegerForKey("钻石数",10000)
    -- self.lifeLabelBmf_ = nil -- 类型：TextBMFont，生命值
    -- self.scoreLabelBmf_ = nil -- 类型：TextBMFont，分值
    -- 加载音效资源
    audio.loadFile("sounds/ui_btn_click.OGG", function() end)--点击按钮
    audio.loadFile("sounds/ui_btn_close.OGG", function() end)--关闭按钮

    audio.loadFile("sounds/get_free_item.OGG", function() end)--点击免费商品
    audio.loadFile("sounds/get_paid_item.OGG", function() end)--点击付费商品
    audio.loadFile("sounds/buy_paid_item.OGG", function() end)--购买付费商品
    audio.loadFile("sounds/open_box.OGG", function() end)--打开宝箱
    audio.loadFile("sounds/get_item.OGG", function() end)--获得物品

    audio.loadFile("sounds/lobby_bgm_120bpm.OGG", function()--大厅背景音乐
        audio.playBGM("sounds/lobby_bgm_120bpm.OGG", true)
        cc.UserDefault:getInstance():setBoolForKey("游戏外音乐",true)
    end)

    -- if cc.UserDefault:getInstance():getBoolForKey("游戏外音乐") then
    --     audio.playBGM("sounds/lobby_bgm_120bpm.OGG", true)
    -- else
    --     audio.stopBGM("sounds/lobby_bgm_120bpm.OGG")
    -- end
    OutGameData:init()
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function TopInfoLayer:initView()
    local width, height = display.width, 80
    self.container_ = ccui.Layout:create()
    --self.container_:setBackGroundColor(cc.c3b(200, 0, 0))
    --self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(display.width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 1)
    self.container_:setPosition(display.cx, display.height)

    --底图
    local sprite = display.newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\base_topbar.png")
    self.container_:addChild(sprite)
    sprite:setContentSize(width, height)
    sprite:setAnchorPoint(0.5, 1)
    sprite:setPosition(width / 2, 0)

    --昵称底图
    local sprite2 = display.newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\base_nickname.png")
    self.container_:addChild(sprite2)
    sprite2:setContentSize(width / 2, height / 2)
    sprite2:setAnchorPoint(0.5, 1)
    sprite2:setPosition(width / 2 - 50, 0)

    --默认头像
    self.sprite1 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\default_avatar.png")
    self.container_:addChild(self.sprite1)
    --sprite1:setContentSize(width, height)
    self.sprite1:setAnchorPoint(0.5, 1)
    self.sprite1:setPosition(width / 2 - 280, height / 2 + 20)

    -- self.button1 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\default_avatar.png")
    -- self.container_:addChild(self.button1)
    -- --sprite1:setContentSize(width, height)
    -- self.button1:setAnchorPoint(0.5, 1)
    -- self.button1:setPosition(width / 2 - 280, height / 2 + 20)

    self.sprite1:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                require("src\\app\\ui\\outgame\\layer\\PortraitSelectionLayer.lua"):new():addTo(self)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_click.OGG",false)
                end
            end
        end
    )

    --砖石和金币底图
    local sprite6 =
        display.newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\base_Diamonds&goldcoins.png")
    self.container_:addChild(sprite6)
    --sprite6:setScale(0.4)
    sprite6:setAnchorPoint(0.5, 1)
    sprite6:setPosition(width / 2 + 190, 50)

    --金币
    self.sprite3 = display.newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\goldcoin.png")
    self.container_:addChild(self.sprite3)
    --sprite3:setContentSize(width, height)
    self.sprite3:setAnchorPoint(0.5, 1)
    self.sprite3:setPosition(width / 2 + 120, 50)
    self.goldcoinnum=display.newTTFLabel({
		text = "0",
        size = 25,
        color = display.COLOR_WHITE
	})
	:align(display.LEFT_CENTER,sprite6:getContentSize().width/2-50,sprite6:getContentSize().height/2)
	:addTo(sprite6)

    --砖石和金币底图
    local sprite7 =
        display.newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\base_Diamonds&goldcoins.png")
    self.container_:addChild(sprite7)
    --sprite7:setScale(0.4)
    sprite7:setAnchorPoint(0.5, 1)
    sprite7:setPosition(width / 2 + 190, 0)

    --砖石
    self.sprite4 = display.newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\diamonds.png")
    self.container_:addChild(self.sprite4)
    --sprite4:setContentSize(width, height)
    self.sprite4:setAnchorPoint(0.5, 1)
    self.sprite4:setPosition(width / 2 + 120, 0)
    self.diamondsnnum=display.newTTFLabel({
		text = "0",
        size = 25,
        color = display.COLOR_WHITE
	})
	:align(display.LEFT_CENTER,sprite7:getContentSize().width/2-50,sprite7:getContentSize().height/2)
	:addTo(sprite7)

    --菜单按钮
    local sprite5 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\button_menu.png")
    self.container_:addChild(sprite5)
    sprite5:setAnchorPoint(0.5, 1)
    sprite5:setPosition(width / 2 + 310, 40)

    sprite5:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                require("src\\app\\ui\\outgame\\layer\\MenuLayer.lua"):new():addTo(self)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_click.OGG",false)
                end
            end
        end
    )


    self.name=display.newTTFLabel({
		text = "九妹",
        size = 30,
        color = display.COLOR_WHITE
	})
	:align(display.LEFT_CENTER, 20,sprite2:getContentSize().height/2+50)
	:addTo(sprite2)

    --奖杯
    self.sprite8 = display.newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\trophy.png")
    sprite2:addChild(self.sprite8)
    --sprite8:setContentSize(width / 2, height / 2)
    self.sprite8:setAnchorPoint(0.5, 0)
    self.sprite8:setPosition(40,sprite2:getContentSize().height/2-10)
    self.trophynum=display.newTTFLabel({
		text = "0",
        size = 25,
        color = display.COLOR_WHITE
	})
	:align(display.LEFT_CENTER, 70,sprite2:getContentSize().height/2+5)
	:addTo(sprite2)
    self.name:setString(cc.UserDefault:getInstance():getStringForKey("昵称"))
    self.trophynum:setString(tostring(cc.UserDefault:getInstance():getIntegerForKey("奖杯数")))
    self.goldcoinnum:setString(tostring(OutGameData:getGold()))
    self.diamondsnnum:setString(tostring(OutGameData:getDiamond()))
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]

function TopInfoLayer:setSprite1(filename)
    -- body
    self.sprite1:loadTextureNormal(filename)
end

function TopInfoLayer:setData()
    -- body
    self.name:setString(cc.UserDefault:getInstance():getStringForKey("昵称"))
    self.trophynum:setString(tostring(cc.UserDefault:getInstance():getIntegerForKey("奖杯数")))
    self.goldcoinnum:setString(tostring(OutGameData:getGold()))
    self.diamondsnnum:setString(tostring(OutGameData:getDiamond()))
end

function TopInfoLayer:update(dt)
end

return TopInfoLayer
