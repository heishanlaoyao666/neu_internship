--[[--
    信息层
    TopInfoLayer.lua
]]
--local PortraitSelectionLayer = class("PortraitSelectionLayer", require("src\\app\\ui\\outgame\\layer\\BaseLayer.lua"))
local PortraitSelectionLayer = class("PortraitSelectionLayer", function()
    return display.newScene("ShopLaPortraitSelectionLayeryer")
end)
local MainView = require("src\\app\\ui\\outgame\\view\\MainView.lua")
local TopInfoLayer = require("src\\app\\ui\\outgame\\layer\\TopInfoLayer.lua")
local ConstDef = require("src\\app\\def\\outgame\\ConstDef.lua")
local EventDef = require("src\\app\\def\\outgame\\EventDef.lua")
local EventManager = require("app.manager.EventManager")

--[[--
    构造函数

    @param none

    @return none
]]
function PortraitSelectionLayer:ctor()
    --PortraitSelectionLayer.super.ctor(self)
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function PortraitSelectionLayer:initView()

    local num1 = 5--以获得头像数量
    local num2 = 5--未获得头像数量

    portraitfilename = {}
    for i=1,20 do
        portraitfilename[i]=string.format("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\%02d.png",i)
    end
    --cc.UserDefault:getInstance():setIntegerForKey("头像",1)

    -- function save()
    --     -- body
    --     local save = {}
    --     table.insert(save,{playerPlane:getPosition()})
    --     for i,v in pairs(enemies) do
    --     -- body
    --     table.insert(save,{v:getPosition()})
    -- end
    --     table.insert(save,{cc.UserDefault:getInstance():getStringForKey("life")})
    --     table.insert(save,{cc.UserDefault:getInstance():getStringForKey("grade")})
    --     str = json.encode(save)
    --     print(str)
    --     file = io.open("C:\\workspace\\hello\\src\\save.txt", "w")
    -- -- 设置默认输出文件为save.txt
    --     io.output(file)
    --     io.write(str)
    --     io.close(file)
    -- end
    --遮罩
    local sprite0 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\mask_popup.png")
    self:addChild(sprite0)
    sprite0:setAnchorPoint(0.5, 0.5)
    sprite0:setPosition(display.cx,display.cy)

    local width, height = display.width, 1120
    self.container_ = ccui.Layout:create()
    -- self.container_:setBackGroundColor(cc.c3b(200, 0, 0))
    -- self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(display.width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, display.cy)
    print(display.height)

    --背景
    local sprite = display.
    newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\avatar_selection\\base_Popup.png")
    self.container_:addChild(sprite)
    sprite:setAnchorPoint(0.5, 0.5)
    sprite:setPosition(width/2,height/2)

    --X按钮
    local sprite1 = ccui.Button:
    create("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\avatar_selection\\button_off.png")
    sprite:addChild(sprite1)
    sprite1:setAnchorPoint(1, 1)
    sprite1:setPosition(sprite:getContentSize().width-30,sprite:getContentSize().height-20)

    sprite1:addTouchEventListener(function(sender, eventType)
        -- ccui.TouchEventType
        if 2 == eventType then -- touch end
            self:removeFromParent(true)
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_btn_close.OGG",false)
            end
        end
    end)

    --确认按钮
    local sprite4 = ccui.Button:
    create("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\avatar_selection\\button_confirm.png")
    sprite:addChild(sprite4)
    sprite4:setAnchorPoint(0.5, 0)
    sprite4:setPosition(sprite:getContentSize().width/2,50)

    sprite4:addTouchEventListener(function(sender, eventType)
        -- ccui.TouchEventType
        if 2 == eventType then -- touch end
            self:removeFromParent(true)
        end
    end)

    --解锁信息
    local sprite5 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\avatar_selection\\prompt_text.png")
    sprite:addChild(sprite5)
    sprite5:setAnchorPoint(0.5, 1)
    sprite5:setPosition(sprite:getContentSize().width/2+70,sprite:getContentSize().height-130)

    --选中的头像和名字
    local sprite6 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\01.png")
    sprite:addChild(sprite6)
    sprite6:setAnchorPoint(0.5, 1)
    sprite6:setPosition(sprite:getContentSize().width/2-150,sprite:getContentSize().height-90)

    display.newTTFLabel({
		text = "坤坤",
        size = 25,
        color = display.COLOR_WHITE
	})
	:align(display.LEFT_CENTER, sprite:getContentSize().width/2-80,sprite:getContentSize().height-110)
	:addTo(sprite)

    --选择列表底图
    local sprite2 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\avatar_selection\\base_slidingarea.png")
    self.container_:addChild(sprite2)
    sprite2:setAnchorPoint(0.5, 0.5)
    sprite2:setPosition(width/2,height/2)

    --创建选择列表
    local listView = ccui.ListView:create()
    -- listView:setBackGroundColor(cc.c3b(200, 0, 0))
    -- listView:setBackGroundColorType(1)
    listView:setContentSize(sprite2:getContentSize().width, sprite2:getContentSize().height)
    listView:setAnchorPoint(0.5, 0.5)
    listView:setPosition(sprite2:getContentSize().width/2, sprite2:getContentSize().height/2)
    listView:setDirection(1)
    listView:addTo(sprite2)

    self.container_2 = ccui.Layout:create()
    -- self.container_2:setBackGroundColor(cc.c3b(200, 0, 0))
    -- self.container_2:setBackGroundColorType(1)
    self.container_2:setContentSize(width, 70+math.ceil(num1/4)*130)
    self.container_2:setAnchorPoint(0.5,0.5)
    self.container_2:setPosition(display.cx, display.cy)
    self.container_2:addTo(listView)

    self.container_3 = ccui.Layout:create()
    self.container_3:setContentSize(width,70+math.ceil(num2/4)*130)
    self.container_3:setAnchorPoint(0.5,0.5)
    self.container_3:setPosition(display.cx, display.cy)
    self.container_3:addTo(listView)

    --以获得
    local sprite3 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\avatar_selection\\splitline_acquired.png")
    self.container_2:addChild(sprite3)
    sprite3:setAnchorPoint(0.5, 0)
    sprite3:setPosition(sprite2:getContentSize().width/2,20+math.ceil(num1/4)*130)

    local sprite7 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\02.png")
    self.container_2:addChild(sprite7)
    sprite7:setAnchorPoint(0.5, 0)
    sprite7:setPosition(75,130)

    sprite7:addTouchEventListener(function(sender, eventType)
        -- ccui.TouchEventType
        if 2 == eventType then -- touch end
            sprite6:setTexture("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\02.png")
            --EventManager:doEvent(EventDef.ID.PORTRAIT_CHANGE,"res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\02.png")
            PortraitSelectionLayer:setportrait(portraitfilename[2])
        end
    end)

    local sprite8 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\03.png")
    self.container_2:addChild(sprite8)
    sprite8:setAnchorPoint(0.5, 0)
    sprite8:setPosition(sprite2:getContentSize().width/4+75,130)
    sprite8:addTouchEventListener(function(sender, eventType)
        -- ccui.TouchEventType
        if 2 == eventType then -- touch end
            --TopInfoLayer.container_.sprite1:setTexture("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\02.png")
            PortraitSelectionLayer:setportrait(portraitfilename[3])

        end
    end)

    local sprite9 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\01.png")
    self.container_2:addChild(sprite9)
    sprite9:setAnchorPoint(0.5, 0)
    sprite9:setPosition(75,0)

    local sprite11 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\01.png")
    self.container_2:addChild(sprite11)
    sprite11:setAnchorPoint(0.5, 0)
    sprite11:setPosition(sprite2:getContentSize().width*2/4+75,130)

    local sprite12 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\01.png")
    self.container_2:addChild(sprite12)
    sprite12:setAnchorPoint(0.5, 0)
    sprite12:setPosition(sprite2:getContentSize().width*3/4+75,130)
    -- 未获得
    local sprite10 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\topbar_playerinformation\\avatar_selection\\splitline_notacquired.png")
    self.container_3:addChild(sprite10)
    sprite10:setAnchorPoint(0.5, 0)
    sprite10:setPosition(sprite2:getContentSize().width/2,20+math.ceil(num2/4)*130)

    local sprite13 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\01.png")
    self.container_3:addChild(sprite13)
    sprite13:setAnchorPoint(0.5, 0)
    sprite13:setPosition(75,130)

    local sprite14 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\01.png")
    self.container_3:addChild(sprite14)
    sprite14:setAnchorPoint(0.5, 0)
    sprite14:setPosition(sprite2:getContentSize().width/4+75,130)

    local sprite15 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\01.png")
    self.container_3:addChild(sprite15)
    sprite15:setAnchorPoint(0.5, 0)
    sprite15:setPosition(75,0)

    local sprite16 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\01.png")
    self.container_3:addChild(sprite16)
    sprite16:setAnchorPoint(0.5, 0)
    sprite16:setPosition(sprite2:getContentSize().width*2/4+75,130)

    local sprite17 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\01.png")
    self.container_3:addChild(sprite17)
    sprite17:setAnchorPoint(0.5, 0)
    sprite17:setPosition(sprite2:getContentSize().width*3/4+75,130)

end

--[[--
    修改头像

    @param dt 类型：number，对应文件后缀数字

    @return none
]]
function PortraitSelectionLayer:setportrait(filename)
    EventManager:doEvent(EventDef.ID.PORTRAIT_CHANGE,
    filename)
end
--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function PortraitSelectionLayer:update(dt)

end

return PortraitSelectionLayer

