--[[--
    头像选择层
    PortraitSelectionView.lua
]]
local PortraitSelectionView = class("PortraitSelectionView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 123))
end)
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local OutGameData = require("app.data.outgame.OutGameData")

--[[--
    构造函数

    @param none

    @return none
]]
function PortraitSelectionView:ctor()
    self.name=nil
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function PortraitSelectionView:initView()
    self.collected1,self.collected2,self.collected3,self.collected4=OutGameData:getCollected()
    self.uncollected1,self.uncollected2,self.uncollected3,self.uncollected4=OutGameData:getUnCollected()
    local num3={}
    local num4={}
    for i=1,#self.collected4 do
        num3[#num3+1]=self.collected4[i]
    end
    for i=1,#self.collected3 do
        num3[#num3+1]=self.collected3[i]
    end
    for i=1,#self.collected2 do
        num3[#num3+1]=self.collected2[i]
    end
    for i=1,#self.collected1 do
        num3[#num3+1]=self.collected1[i]
    end
    for i=1,#self.uncollected4 do
        num4[#num4+1]=self.uncollected4[i]
    end
    for i=1,#self.uncollected3 do
        num4[#num4+1]=self.uncollected3[i]
    end
    for i=1,#self.uncollected2 do
        num4[#num4+1]=self.uncollected2[i]
    end
    for i=1,#self.uncollected1 do
        num4[#num4+1]=self.uncollected1[i]
    end
    local obtained = num3--{1,2,3} --以获得头像
    local notobtained = num4--{4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20} --未获得头像
    local tempfilename
    local num1 = #obtained--以获得头像数量
    local num2 = #notobtained--未获得头像数量

    local portraitfilename = {}
    for i=1,20 do
        portraitfilename[i]=string.format("artcontent/lobby_ongame/currency/icon_tower/%02d.png",i)
    end

    local width, height = display.width, 1120
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, display.cy)

    --背景
    tempfilename="artcontent/lobby_ongame/topbar_playerinformation/avatar_selection/base_Popup.png"
    local sprite = display.newSprite(tempfilename)
    self.container_:addChild(sprite)
    sprite:setAnchorPoint(0.5, 0.5)
    sprite:setPosition(width/2,height/2)

    --X按钮
    tempfilename="artcontent/lobby_ongame/topbar_playerinformation/avatar_selection/button_off.png"
    local offBtn = ccui.Button:create(tempfilename)
    sprite:addChild(offBtn)
    offBtn:setAnchorPoint(1, 1)
    offBtn:setPosition(sprite:getContentSize().width-30,sprite:getContentSize().height-20)

    offBtn:addTouchEventListener(function(sender, eventType)
        -- ccui.TouchEventType
        if 2 == eventType then -- touch end
            self:removeFromParent(true)
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_btn_close.OGG",false)
            end
        end
    end)

    --解锁信息
    tempfilename="artcontent/lobby_ongame/topbar_playerinformation/avatar_selection/prompt_text.png"
    local textPrompt = display.newSprite(tempfilename)
    sprite:addChild(textPrompt)
    textPrompt:setAnchorPoint(0.5, 1)
    textPrompt:setPosition(sprite:getContentSize().width/2+70,sprite:getContentSize().height-130)

    if #cc.UserDefault:getInstance():getStringForKey("头像")==0 then
        cc.UserDefault:getInstance():setStringForKey("头像",portraitfilename[obtained[1]:getTower():getTowerId()])
        cc.UserDefault:getInstance():setStringForKey("名字",obtained[1]:getTower():getTowerName())
    end

    --选中的头像和名字
    local avatar = display.newSprite(cc.UserDefault:getInstance():getStringForKey("头像"))
    sprite:addChild(avatar)
    avatar:setAnchorPoint(0.5, 1)
    avatar:setPosition(sprite:getContentSize().width/2-150,sprite:getContentSize().height-90)

    local name=display.newTTFLabel({
		text = "坤坤",
        size = 25,
        color = display.COLOR_WHITE
	})
	:align(display.LEFT_CENTER, sprite:getContentSize().width/2-80,sprite:getContentSize().height-110)
	:addTo(sprite)
    name:setString(cc.UserDefault:getInstance():getStringForKey("名字"))

    --选择列表底图
    tempfilename="artcontent/lobby_ongame/topbar_playerinformation/avatar_selection/base_slidingarea.png"
    local base = display.newSprite(tempfilename)
    self.container_:addChild(base)
    base:setAnchorPoint(0.5, 0.5)
    base:setPosition(width/2,height/2)

    --创建选择列表
    local listView = ccui.ListView:create()
    listView:setContentSize(base:getContentSize().width, base:getContentSize().height)
    listView:setAnchorPoint(0.5, 0.5)
    listView:setPosition(base:getContentSize().width/2, base:getContentSize().height/2)
    listView:setDirection(1)
    listView:addTo(base)

    self.container_2 = ccui.Layout:create()
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
    tempfilename="artcontent/lobby_ongame/topbar_playerinformation/avatar_selection/splitline_acquired.png"
    local acquired = display.newSprite(tempfilename)
    self.container_2:addChild(acquired)
    acquired:setAnchorPoint(0.5, 0)
    acquired:setPosition(base:getContentSize().width/2,20+math.ceil(num1/4)*130)

    for k,v in pairs(obtained) do
        local obtainedBtn = ccui.Button:create(portraitfilename[v:getTower():getTowerId()])
        self.container_2:addChild(obtainedBtn)
        obtainedBtn:setAnchorPoint(0.5, 0)
        --obtainedBtn:setPosition(base:getContentSize().width*/4+75,130)
        local y = 20+math.ceil(num1/4)*130-math.ceil(k/4)*130
        if k%4==0 then
            obtainedBtn:setPosition(75+base:getContentSize().width*3/4,y)
        else
            obtainedBtn:setPosition(75+base:getContentSize().width*(k%4-1)/4,y)
        end
        obtainedBtn:addTouchEventListener(function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_click.OGG",false)
                end
                self.filename=portraitfilename[v:getTower():getTowerId()]
                avatar:setTexture(self.filename)
                name:setString(v:getTower():getTowerName())
                self.name=v:getTower():getTowerName()
            end
        end)
    end
    -- 未获得
    tempfilename="artcontent/lobby_ongame/topbar_playerinformation/avatar_selection/splitline_notacquired.png"
    local notacquired = display.newSprite(tempfilename)
    self.container_3:addChild(notacquired)
    notacquired:setAnchorPoint(0.5, 0)
    notacquired:setPosition(base:getContentSize().width/2,20+math.ceil(num2/4)*130)

    local notobtainedfilename="artcontent/lobby_ongame/currency/icon_towergray/%d.png"
    for k,v in pairs(notobtained) do
        obtainedBtn =  display.newSprite(string.format(notobtainedfilename,v:getTowerId()))
        self.container_3:addChild(obtainedBtn)
        obtainedBtn:setAnchorPoint(0.5, 0)
        --obtainedBtn:setPosition(base:getContentSize().width*/4+75,130)
        local y = 20+math.ceil(num2/4)*130-math.ceil(k/4)*130
        if k%4==0 then
            obtainedBtn:setPosition(75+base:getContentSize().width*3/4,y)
        else
            obtainedBtn:setPosition(75+base:getContentSize().width*(k%4-1)/4,y)
        end
    end

    --确认按钮
    tempfilename="artcontent/lobby_ongame/topbar_playerinformation/avatar_selection/button_confirm.png"
    local confirmBtn = ccui.Button:create(tempfilename)
    sprite:addChild(confirmBtn)
    confirmBtn:setAnchorPoint(0.5, 0)
    confirmBtn:setPosition(sprite:getContentSize().width/2,50)
    confirmBtn:addTouchEventListener(function(sender, eventType)
        -- ccui.TouchEventType
        if 2 == eventType then -- touch end
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_btn_click.OGG",false)
            end
            cc.UserDefault:getInstance():setStringForKey("头像",self.filename)
            cc.UserDefault:getInstance():setStringForKey("名字",self.name)
            PortraitSelectionView:setPortrait(self.filename)
            self:removeFromParent(true)
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
    设置头像文件

    @param dt 类型：number，对应文件后缀数字

    @return none
]]
function PortraitSelectionView:setFileName(filename)
    self.filename=filename
end
--[[--
    获取头像文件

    @param dt 类型：number，对应文件后缀数字

    @return none
]]
function PortraitSelectionView:getFileName()
    return self.filename
end
--[[--
    修改头像

    @param dt 类型：number，对应文件后缀数字

    @return none
]]
function PortraitSelectionView:setPortrait(filename)
    EventManager:doEvent(EventDef.ID.PORTRAIT_CHANGE,
    filename)
end

return PortraitSelectionView

