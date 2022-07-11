--[[--
    顶部信息层
    TopInfoLayer.lua
]]
local TopInfoLayer = class("TopInfoLayer", require("app.ui.outgame.layer.BaseLayer"))
local OutGameData = require("app.data.outgame.OutGameData")
local PortraitSelectionView = require("app.ui.outgame.view.PortraitSelectionView")

--[[--
    构造函数

    @param none

    @return none
]]
function TopInfoLayer:ctor()
    TopInfoLayer.super.ctor(self)
    cc.UserDefault:getInstance():setStringForKey("昵称","久妹")
    cc.UserDefault:getInstance():setIntegerForKey("奖杯数",400)

    self.portraitSelectionView_=nil --头像选择界面
    self.container_ = nil -- 类型：Layout，控件容器
    self.avatarBtn_=nil --类型：Button，头像按钮
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
    local tempfilename
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 1)
    self.container_:setPosition(display.cx, display.height)

    --底图S
    local baseTopTbarSprite = display.newSprite("artcontent/lobby(ongame)/topbar_playerinformation/base_topbar.png")
    self.container_:addChild(baseTopTbarSprite)
    baseTopTbarSprite:setContentSize(width, height)
    baseTopTbarSprite:setAnchorPoint(0.5, 1)
    baseTopTbarSprite:setPosition(width / 2, 0)

    --昵称底图
    local baseNicknameSprite = display.newSprite("artcontent/lobby(ongame)/topbar_playerinformation/base_nickname.png")
    self.container_:addChild(baseNicknameSprite)
    baseNicknameSprite:setContentSize(width / 2, height / 2)
    baseNicknameSprite:setAnchorPoint(0.5, 1)
    baseNicknameSprite:setPosition(width / 2 - 50, 0)

    --默认头像
    self.avatarBtn_ = ccui.Button:create("artcontent/lobby(ongame)/topbar_playerinformation/default_avatar.png")
    self.container_:addChild(self.avatarBtn_)
    self.avatarBtn_:setAnchorPoint(0.5, 1)
    self.avatarBtn_:setPosition(width / 2 - 280, height / 2 + 20)

    self.avatarBtn_:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                self.portraitSelectionView_=PortraitSelectionView:new():addTo(self)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_click.OGG",false)
                end
            end
        end
    )

    --砖石和金币底图
    tempfilename="artcontent/lobby(ongame)/topbar_playerinformation/base_Diamonds&goldcoins.png"
    local baseMoneySprite =display.newSprite(tempfilename)
    self.container_:addChild(baseMoneySprite)
    --baseMoneySprite:setScale(0.4)
    baseMoneySprite:setAnchorPoint(0.5, 1)
    baseMoneySprite:setPosition(width / 2 + 190, 50)
    local baseMoneyContentSize= baseMoneySprite:getContentSize()

    --金币
    self.sprite3 = display.newSprite("artcontent/lobby(ongame)/topbar_playerinformation/goldcoin.png")
    self.container_:addChild(self.sprite3)
    --sprite3:setContentSize(width, height)
    self.sprite3:setAnchorPoint(0.5, 1)
    self.sprite3:setPosition(width / 2 + 120, 50)
    self.goldcoinnum=display.newTTFLabel({
		text = "0",
        size = 25,
        color = display.COLOR_WHITE
	})
	:align(display.LEFT_CENTER,baseMoneyContentSize.width/2-50,baseMoneyContentSize.height/2)
	:addTo(baseMoneySprite)

    --砖石和金币底图
    local baseMoneySprite1 = display.newSprite(tempfilename)
    self.container_:addChild(baseMoneySprite1)
    --baseMoneySprite1:setScale(0.4)
    baseMoneySprite1:setAnchorPoint(0.5, 1)
    baseMoneySprite1:setPosition(width / 2 + 190, 0)

    --砖石
    self.sprite4 = display.newSprite("artcontent/lobby(ongame)/topbar_playerinformation/diamonds.png")
    self.container_:addChild(self.sprite4)
    --sprite4:setContentSize(width, height)
    self.sprite4:setAnchorPoint(0.5, 1)
    self.sprite4:setPosition(width / 2 + 120, 0)
    self.diamondsnnum=display.newTTFLabel({
		text = "0",
        size = 25,
        color = display.COLOR_WHITE
	})
	:align(display.LEFT_CENTER,baseMoneyContentSize.width/2-50,baseMoneyContentSize.height/2)
	:addTo(baseMoneySprite1)

    --菜单按钮
    local menuBtn = ccui.Button:create("artcontent/lobby(ongame)/topbar_playerinformation/button_menu.png")
    self.container_:addChild(menuBtn)
    menuBtn:setAnchorPoint(0.5, 1)
    menuBtn:setPosition(width / 2 + 310, 40)

    menuBtn:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                require("src/app/ui/outgame/layer/MenuLayer.lua"):new():addTo(self)
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
	:align(display.LEFT_CENTER, 20,baseNicknameSprite:getContentSize().height/2+50)
	:addTo(baseNicknameSprite)

    --奖杯
    self.sprite8 = display.newSprite("artcontent/lobby(ongame)/topbar_playerinformation/trophy.png")
    baseNicknameSprite:addChild(self.sprite8)
    --sprite8:setContentSize(width / 2, height / 2)
    self.sprite8:setAnchorPoint(0.5, 0)
    self.sprite8:setPosition(40,baseNicknameSprite:getContentSize().height/2-10)
    self.trophynum=display.newTTFLabel({
		text = "0",
        size = 25,
        color = display.COLOR_WHITE
	})
	:align(display.LEFT_CENTER, 70,baseNicknameSprite:getContentSize().height/2+5)
	:addTo(baseNicknameSprite)
    --数据信息
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

function TopInfoLayer:setavatarBtn_(filename)
    -- body
    self.avatarBtn_:loadTextureNormal(filename)
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
