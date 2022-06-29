
local AtlasScene = class("AtlasScene", function()
    return display.newScene("AtlasScene")
end)

function AtlasScene:ctor()

    self:createMiddleMiddlePanel()
    --开始游戏按钮
    -- local images = {
    --     normal = "ui/hall/battle/Button-Battle_Mode.png",
    --     pressed = "",
    --     disabled = "ui/hall/battle/Button-Battle_Mode.png"
    -- }

    -- local NewGameBtn = ccui.Button:create(images["normal"], images["pressed"], images["disabled"])
    -- NewGameBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- -- 居中
    -- NewGameBtn:setPosition(cc.p(display.cx, display.cy))
    -- -- 设置缩放程度
    -- NewGameBtn:setScale(0.5, 0.5)
    -- -- 设置是否禁用(false为禁用)
    -- NewGameBtn:setEnabled(true)
    -- -- registerBtn:addClickEventListener(function()
    -- --     print("lalala")
    -- -- end)

    -- NewGameBtn:addTouchEventListener(function(sender, eventType)
	--  	if eventType == ccui.TouchEventType.ended then
	--  		local ABtn = import("app.scenes.GameView.GameScene"):new()
    --         display.replaceScene(ABtn,"turnOffTiles",0.5)
	--  	end
	-- end)

    -- self:addChild(NewGameBtn, 4)

    self:createMiddleBottomPanel()
    self:createMiddleTopPanel()
    self:createTroopPanel()
    -- local layer = self:ShopPanel()
    -- self:slide(layer)
    -- self:createCollectionPanel()

    local layer1 = self:createCollectionPanel()
    self:slide(layer1)
end


function AtlasScene:slide(layer)
    str = "null"
    local listener = cc.EventListenerTouchOneByOne:create()--单点触摸
    local function onTouchBegan(touch, event)
        local target = event:getCurrentTarget()
        local size = target:getContentSize()
        local rect = cc.rect(0, 0, size.width, size.height)
        local p = touch:getLocation()
        p = target:convertTouchToNodeSpace(touch)
        if cc.rectContainsPoint(rect, p) then
            return true
        end
        return false
    end

    local function onTouchMoved(touch, event)
        local location = touch:getStartLocationInView()
        local y1 = location["y"] or 0
        local location2 = touch:getLocationInView()
        local y2 = location2["y"] or 0
        if y1<y2 then
            str = "up"
        elseif y1>y2 then
            str = "down"
        end
    end
    local function onTouchEnded(touch, event)
        if str == "up" then
            self:slider(layer,-350)
            print(str)
        elseif str == "down" then
            self:slider(layer,350)
            print(str)
        end
    end

    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)
end

function AtlasScene:slider(layer,distance)
    local moveAction = cc.MoveBy:create(0.5,cc.p(0,distance))
    layer:runAction(moveAction)
end


--bg-battle_interface.png
function AtlasScene:createMiddleMiddlePanel()
    local width ,height  =display.width,display.top
    local settingLayer = ccui.Layout:create()
    settingLayer:setBackGroundImage("ui/hall/battle/bg-battle_interface.png")
    settingLayer:setContentSize(width,height)
    settingLayer:setAnchorPoint(0.5,0.5)
    settingLayer:setPosition(width*0.5,height*0.5)
    
    settingLayer:addTo(self)

end

function AtlasScene:createMiddleBottomPanel()
    local width,height = display.width,display.top
    local menuLayer = ccui.Layout:create()
    menuLayer:setContentSize(width,height)
    menuLayer:setAnchorPoint(0,0)
    menuLayer:setPosition(0,0)
    
    menuLayer:addTo(self)
    --商店
    local shopBtn = ccui.Button:create(
        "ui/hall/bottom-tab/tab-unselected-left.png",
        "ui/hall/bottom-tab/tab-selected.png",
        "ui/hall/bottom-tab/tab-unselected-left.png"
    )
    shopBtn:setAnchorPoint(0,0)
    shopBtn:setScale(240/230)
    shopBtn:pos(0,0)
    shopBtn:addTo(menuLayer)

    shopBtn:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			local shopScene=import("app/scenes/ShopScene"):new()
            display.replaceScene(shopScene)
		end
	end)
    --对战
    local battleBtn = ccui.Button:create(
        "ui/hall/bottom-tab/tab-unselected-middle.png",
        "ui/hall/bottom-tab/tab-selected.png",
        "ui/hall/bottom-tab/tab-unselected-middle.png"
    )
    battleBtn:setAnchorPoint(0,0)
    battleBtn:setScale(240/230)
    battleBtn:pos(0+230*240/230,0)
    battleBtn:addTo(menuLayer)
    --图鉴
    local AtlasBtn = ccui.Button:create(
        "ui/hall/bottom-tab/tab-unselected-right.png",
        "ui/hall/bottom-tab/tab-selected.png",
        "ui/hall/bottom-tab/tab-unselected-right.png"
    )
    AtlasBtn:setAnchorPoint(0,0)
    AtlasBtn:setScale(240/230)
    AtlasBtn:pos(0+230*240/230+230*240/230,0)
    AtlasBtn:addTo(menuLayer)
    
end
--顶部
function AtlasScene:createMiddleTopPanel()
    local width,height = display.width,display.top
    local infoLayer = ccui.Layout:create()
    --infoLayer:setBackGroundImage("ui/hall/Prompt text/bg-topPanel.png")
    infoLayer:setContentSize(width,height)
    infoLayer:setAnchorPoint(0,0)
    infoLayer:setPosition(0,0)
    
    infoLayer:addTo(self)
    --小背景
    local bgicon=ccui.ImageView:create("ui/hall/Prompt text/bg-topPanel.png")
    bgicon:setScale(1)
    bgicon:setAnchorPoint(0,1)
    bgicon:pos(0,height)
    bgicon:addTo(infoLayer)

    --第二背景（黑色）
    local bg2icon=ccui.ImageView:create("ui/hall/Prompt text/bg-name.png")
    bg2icon:setScale(1)
    bg2icon:setAnchorPoint(0,1)
    bg2icon:pos(0+100,height-20)
    bg2icon:addTo(infoLayer)

    --头像

    local headBtn=ccui.Button:create(
        "ui/hall/Prompt text/Default_Avatar.png",
        "",
        "ui/hall/Prompt text/Default_Avatar.png"
    )
    headBtn:setScale(1)
    headBtn:setAnchorPoint(0,1)
    headBtn:pos(0+10,height-10)
    headBtn:addTo(infoLayer)

    headBtn:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			-- local newScene=import("app/scenes/HeadScene"):new()
            -- display.replaceScene(newScene)
            cc.Director:getInstance():pushScene(require("app.scenes.HeadScene").new())
		end
	end)

    --名字
    local namelabel=cc.Label:createWithTTF("黑山老妖04","ui/font/fzbiaozjw.ttf",30)
    namelabel:setScale(1)
    namelabel:setAnchorPoint(0,1)
    namelabel:pos(0+150,height-25)
    namelabel:addTo(infoLayer)
    --小奖杯 res\ui\hall\Prompt text\trophy.png
    local trophyicon=ccui.ImageView:create("ui/hall/Prompt text/trophy.png")
    trophyicon:setScale(1)
    trophyicon:setAnchorPoint(0,1)
    trophyicon:pos(0+150,height-70)
    trophyicon:addTo(infoLayer)

    --奖杯数
    local trophylabel=cc.Label:createWithTTF("100","ui/font/fzbiaozjw.ttf",30)
    trophylabel:setScale(1)
    trophylabel:setColor(cc.c3b(255,128,0))
    trophylabel:setAnchorPoint(0,1)
    trophylabel:pos(0+200,height-70)
    trophylabel:addTo(infoLayer)

    --两个小背景
    local bg3icon=ccui.ImageView:create("ui/hall/Prompt text/bg-Base-diamonds &amp; gold coins.png")
    bg3icon:setScale(1)
    bg3icon:setAnchorPoint(0,1)
    bg3icon:pos(0+450,height-25)
    bg3icon:addTo(infoLayer)

    local bg4icon=ccui.ImageView:create("ui/hall/Prompt text/bg-Base-diamonds &amp; gold coins.png")
    bg4icon:setScale(1)
    bg4icon:setAnchorPoint(0,1)
    bg4icon:pos(0+450,height-75)
    bg4icon:addTo(infoLayer)

    --金币
    local coinicon=ccui.ImageView:create("ui/hall/Prompt text/Gold-coin.png")
    coinicon:setScale(1)
    coinicon:setAnchorPoint(0,1)
    coinicon:pos(0+430,height-20)
    coinicon:addTo(infoLayer)

    --钻石
    local diamondicon=ccui.ImageView:create("ui/hall/Prompt text/Diamonds.png")
    diamondicon:setScale(1)
    diamondicon:setAnchorPoint(0,1)
    diamondicon:pos(0+430,height-70)
    diamondicon:addTo(infoLayer)
    --金币数
    local coinlabel=cc.Label:createWithTTF("100000","ui/font/fzbiaozjw.ttf",30)
    coinlabel:setScale(1)
    coinlabel:setAnchorPoint(0,1)
    coinlabel:pos(0+480,height-25)
    coinlabel:addTo(infoLayer)

    --钻石数
    local diamondlabel=cc.Label:createWithTTF("1000","ui/font/fzbiaozjw.ttf",30)
    diamondlabel:setScale(1)
    diamondlabel:setAnchorPoint(0,1)
    diamondlabel:pos(0+480,height-75)
    diamondlabel:addTo(infoLayer)
    
    --设置

    local settingBtn = ccui.Button:create(
        "ui/hall/Prompt text/button-menu.png",
        "",
        "ui/hall/Prompt text/button-menu.png"
    )
    settingBtn:setScale(1)
    settingBtn:setAnchorPoint(0,1)
    settingBtn:pos(0+630,height-35)
    settingBtn:addTo(infoLayer)

    settingBtn:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
            cc.Director:getInstance():pushScene(require("app.scenes.SettingScene").new())
		end
	end)



    -- local shopBtn = ccui.Button:create(
    --     "ui/hall/bottom-tab/tab-unselected-left.png",
    --     "ui/hall/bottom-tab/tab-selected.png",
    --     "ui/hall/bottom-tab/tab-unselected-left.png"
    -- )
    -- shopBtn:setAnchorPoint(0,0)
    -- shopBtn:setScale(240/230)
    -- shopBtn:pos(0,0)
    -- shopBtn:addTo(menuLayer)



end

--[[
    函数用途：加载界面，加载完毕后切换至游戏大厅
    --]]
function AtlasScene:loadingPanel()
    local loadPanel = ccui.Layout:create()--加载页面层级
    loadPanel:setContentSize(720, 1280)
    loadPanel:setAnchorPoint(0, 0)
    loadPanel:setPosition(0,0)
    loadPanel:addTo(self)

    display.newSprite("ui/loading/bottomchart.jpg")--加载页面_背景图
           :pos(display.cx,display.cy)
           :addTo(loadPanel)

    local tips = cc.Label:createWithTTF("大厅预加载，进行中...","ui/font/fzhz.ttf",20)--文本：大厅预加载
    tips:setPosition(360,30)
    tips:setColor(cc.c3b(255,255,255))
    tips:addTo(loadPanel)

    local progressNum = 0--文本：加载进度
    local progress = cc.Label:createWithTTF(progressNum,"ui/font/fzhz.ttf",20)
    progress:setPosition(650,30)
    progress:setColor(cc.c3b(255,239,117))
    progress:addTo(loadPanel)

    --[[ cc.Director:getInstance():getScheduler():scheduleScriptFunc(
             function()
                 progressNum = progressNum+1
                 progress:setString(progressNum)
             end,0.1,false)--]]



    local barProBg = cc.Sprite:create("ui/loading/processbar_bottomchart.png")--进度条背景
    barProBg:setAnchorPoint(0,0)
    barProBg:setScale(48,1)
    barProBg:setPosition(0, 0)
    barProBg:addTo(loadPanel)

    local barPro = cc.ProgressTimer:create(cc.Sprite:create("ui/loading/processbar_stretch_full.png"))--进度条组件
    barPro:setAnchorPoint(0,0)
    barPro:setPosition(cc.p(0, 0))
    barPro:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    barPro:setMidpoint(cc.p(0, 0))--进度条起点位置
    barPro:setBarChangeRate(cc.p(1, 0))--进度方向为水平方向
    barPro:addTo(loadPanel)
    barPro:setPercentage(0)--起始进度为0

    local loadAction = cc.ProgressFromTo:create(5,0,100)--动作：5秒内从0到100
    local callFuncAction = cc.CallFunc:create(function()--动作执行完毕回调函数
        loadPanel:setVisible(false)
    end)
    local delayTimeAction = cc.DelayTime:create(0.5)--延时0.5s
    local sequenceAction = cc.Sequence:create(loadAction,delayTimeAction,callFuncAction)
    barPro:runAction(sequenceAction)

end
--收集层
function AtlasScene:createCollectionPanel()
    local width,height = display.width,display.top
    local CollectionLayer = ccui.Layout:create()
    CollectionLayer:setContentSize(width,height)
    CollectionLayer:setAnchorPoint(0,0)
    CollectionLayer:setPosition(0,0)

    --暴击伤害提示信息
    local criticaldamageback=ccui.ImageView:create("ui/hall/Atlas/Subinterface_info/bottomchart_info.png")
    criticaldamageback:setScale(1)
    criticaldamageback:setAnchorPoint(0,1)
    criticaldamageback:pos(0+55,height-480)
    criticaldamageback:addTo(CollectionLayer)

    local criticaldamagebacktext2=ccui.ImageView:create("ui/hall/Atlas/Subinterface_info/Text-Totalcriticaldamage.png")
    criticaldamagebacktext2:setScale(1)
    criticaldamagebacktext2:setAnchorPoint(0,1)
    criticaldamagebacktext2:pos(0+250,height-500)
    criticaldamagebacktext2:addTo(CollectionLayer)

    local criticaldamagebacktext1=ccui.ImageView:create("ui/hall/Atlas/Subinterface_info/Text-anydefensetowerupgradedwillpermanentlyincreasecriticalhitdamage.png")
    criticaldamagebacktext1:setScale(1)
    criticaldamagebacktext1:setAnchorPoint(0,1)
    criticaldamagebacktext1:pos(0+190,height-550)
    criticaldamagebacktext1:addTo(CollectionLayer)
    
    --暴击值
    local criticaldamagelabel=cc.Label:createWithTTF("220%","ui/font/fzbiaozjw.ttf",30)
    criticaldamagelabel:setScale(1)
    criticaldamagelabel:setColor(cc.c3b(255,128,0))
    criticaldamagelabel:setAnchorPoint(0,1)
    criticaldamagelabel:pos(0+410,height-500)
    criticaldamagelabel:addTo(CollectionLayer)
    
    CollectionLayer:addTo(self)
    --已收集
    local collectedimage=ccui.ImageView:create("ui/hall/Atlas/Subinterface_towerlist/splitline_collected.png")
    collectedimage:setScale(1)
    collectedimage:setAnchorPoint(0,1)
    collectedimage:pos(0,height-600)
    collectedimage:addTo(CollectionLayer)

    self:createCollectedItem(CollectionLayer,"ui/hall/Atlas/Subinterface_towerlist/bottomchart-tower-rare.png",
    "ui/hall/common/Tower-Icon/01.png","ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_disturb.png",
    "ui/hall/Atlas/Subinterface_currentsquad/rank/lv.8.png",0,-450)
    self:createCollectedItem(CollectionLayer,"ui/hall/Atlas/Subinterface_towerlist/bottomchart-tower-rare.png",
    "ui/hall/common/Tower-Icon/01.png","ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_attack.png",
    "ui/hall/Atlas/Subinterface_currentsquad/rank/lv.8.png",170,-450)
    self:createCollectedItem(CollectionLayer,"ui/hall/Atlas/Subinterface_towerlist/bottomchart-tower-rare.png"
    ,"ui/hall/common/Tower-Icon/01.png","ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_attack.png",
    "ui/hall/Atlas/Subinterface_currentsquad/rank/lv.8.png",170*2,-450)
    self:createCollectedItem(CollectionLayer,"ui/hall/Atlas/Subinterface_towerlist/bottomchart-tower-rare.png"
    ,"ui/hall/common/Tower-Icon/01.png","ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_attack.png",
    "ui/hall/Atlas/Subinterface_currentsquad/rank/lv.8.png",170*3,-450)
    self:createCollectedItem(CollectionLayer,"ui/hall/Atlas/Subinterface_towerlist/bottomchart-tower-rare.png"
    ,"ui/hall/common/Tower-Icon/01.png","ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_attack.png",
    "ui/hall/Atlas/Subinterface_currentsquad/rank/lv.9.png",0,-700)


    --未收集
    local notcollectedimage=ccui.ImageView:create("ui/hall/Atlas/Subinterface_towerlist/splitline_notcollected.png")
    notcollectedimage:setScale(1)
    notcollectedimage:setAnchorPoint(0,1)
    notcollectedimage:pos(0,height-1200)
    notcollectedimage:addTo(CollectionLayer)


    return CollectionLayer
end

--二级页面（使用）
function AtlasScene:towerusingPanel(layer,bg)
    local width ,height = display.width,display.height
    --层：灰色背景
    local towerusingLayer = ccui.Layout:create()
    towerusingLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    towerusingLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    towerusingLayer:setBackGroundColorOpacity(128)--设置透明度
    towerusingLayer:setContentSize(width, height)
    towerusingLayer:pos(width*0.5, height *0.5)
    towerusingLayer:setAnchorPoint(0.5, 0.5)
    towerusingLayer:addTo(self)
    towerusingLayer:setTouchEnabled(true)--屏蔽一级界面

    local pop2Layer = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerusing/group119.png")
    pop2Layer:pos(display.cx,display.cy-300)
    pop2Layer:setAnchorPoint(0.5,0.5)
    pop2Layer:addTo(towerusingLayer)

    local changetowericon = ccui.ImageView:create(bg)
    changetowericon:setPosition(304,230)
    changetowericon:setScale(1)
    changetowericon:addTo(pop2Layer)

    --按钮：取消替换
    local cancelButton = ccui.Button:create(
            "ui/hall/Atlas/Secondaryinterface_towerusing/BT.png",
            "ui/hall/Atlas/Secondaryinterface_towerusing/BT.png",
            "ui/hall/Atlas/Secondaryinterface_towerusing/BT.png")
    cancelButton:setPosition(cc.p(300, 70))
    cancelButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        elseif eventType == ccui.TouchEventType.ended then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
           towerusingLayer:setVisible(false)--隐藏二级弹窗
            layer:setTouchEnabled(true)
        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    cancelButton:addTo(pop2Layer)


end


--二级页面（卡牌升级替换等）
function AtlasScene:towerinfoPanel(layer,bg,path,towertype,rank)--图片路径，塔类型，卡等级
    local width ,height = display.width,display.height
    --层：灰色背景
    local towerinfoLayer = ccui.Layout:create()
    towerinfoLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    towerinfoLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    towerinfoLayer:setBackGroundColorOpacity(128)--设置透明度
    towerinfoLayer:setContentSize(width, height)
    towerinfoLayer:pos(width*0.5, height *0.5)
    towerinfoLayer:setAnchorPoint(0.5, 0.5)
    towerinfoLayer:addTo(self)
    towerinfoLayer:setTouchEnabled(true)--屏蔽一级界面

    --图片：弹窗背景
    local popLayer = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/buttomchart_pop_up_windows.png")
    popLayer:pos(display.cx, display.cy-220)
    popLayer:setAnchorPoint(0.5, 0.5)
    popLayer:addTo(towerinfoLayer)



    --图片：塔
    local ItemBg =ccui.ImageView:create(path)
    ItemBg:setScale(1)
    ItemBg:setPosition(cc.p(120, 685))
    ItemBg:addTo(popLayer)
    
    --ta
    local towericon =ccui.ImageView:create(bg)
    towericon:setScale(1)
    towericon:setPosition(cc.p(120, 685))
    towericon:addTo(popLayer)
    --等级
    local toweritem =ccui.ImageView:create(rank)
    toweritem:setScale(1)
    toweritem:setPosition(cc.p(120, 635))
    toweritem:addTo(popLayer)

    --技能介绍底图  bottomchart_skillintroduction.png
    local skillinfobg = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/bottomchart_skillintroduction.png")
    skillinfobg:setScale(1)
    skillinfobg:setPosition(cc.p(420, 635))
    skillinfobg:addTo(popLayer)

    --塔类型  bottomchart_skillintroduction.png
    local towertype1 = ccui.ImageView:create(towertype)
    towertype1:setScale(1.2)
    towertype1:setPosition(cc.p(165, 770))
    towertype1:addTo(popLayer)

    --名字  title_1.png
    local nameimage = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/text_info/title_1.png")
    nameimage:setScale(1)
    nameimage:setPosition(cc.p(240, 750))
    nameimage:addTo(popLayer)
    local namelabel=cc.Label:createWithTTF("风暴巨龙","ui/font/fzzdhjw.ttf",34)
    namelabel:setScale(1)
    namelabel:setColor(cc.c3b(255, 255, 255))
    namelabel:setAnchorPoint(0,1)
    namelabel:pos(0+220,730)
    namelabel:addTo(popLayer)

    --稀有度
    local rareimage = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/text_info/rarity.png")
    rareimage:setScale(1)
    rareimage:setPosition(cc.p(540, 750))
    rareimage:addTo(popLayer)
    local rarelabel=cc.Label:createWithTTF("传说","ui/font/fzzdhjw.ttf",34)
    rarelabel:setScale(1)
    rarelabel:setColor(cc.c3b(255, 255, 255))
    rarelabel:setAnchorPoint(0,1)
    rarelabel:pos(0+510,730)
    rarelabel:addTo(popLayer)

    --技能介绍
    local skillinfoimage = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/text_info/skillinfo.png")
    skillinfoimage:setScale(1)
    skillinfoimage:setPosition(cc.p(255, 675))
    skillinfoimage:addTo(popLayer)
    local skillinfolabel=cc.Label:createWithTTF("每隔一段时间可以在三个形态之间切换\n，二技能攻速大幅度加强，三形态攻击\n必定暴击。","ui/font/fzzdhjw.ttf",20)
    skillinfolabel:setScale(1)
    skillinfolabel:setColor(cc.c3b(255, 255, 255))
    skillinfolabel:setAnchorPoint(0,1)
    skillinfolabel:pos(0+220,655)
    skillinfolabel:addTo(popLayer)



    -- --文本：碎片数量
    -- local fragmentNum = cc.Label:createWithTTF(towertype,"ui/font/fzbiaozjw.ttf",25)
    -- fragmentNum:setPosition(cc.p(80,30))
    -- fragmentNum:setColor(cc.c3b(255, 206, 55))
    -- --fragmentNum:enableShadow(cc.c3b(0,0,0), cc.size(2,-2), 100)--字体描边有待学习
    -- fragmentNum:addTo(ItemBg)

    --属性背景
    local typebg1 = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/bottomchart_attribute_default.png")
    typebg1:setScale(1)
    typebg1:setPosition(cc.p(175, 460))
    typebg1:addTo(popLayer)
    local typebg2 = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/bottomchart_attribute_default.png")
    typebg2:setScale(1)
    typebg2:setPosition(cc.p(490, 460))
    typebg2:addTo(popLayer)
    local typebg3 = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/bottomchart_attribute_default.png")
    typebg3:setScale(1)
    typebg3:setPosition(cc.p(175, 350))
    typebg3:addTo(popLayer)
    local typebg4 = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/bottomchart_attribute_default.png")
    typebg4:setScale(1)
    typebg4:setPosition(cc.p(490, 350))
    typebg4:addTo(popLayer)
    local typebg5 = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/bottomchart_attribute_default.png")
    typebg5:setScale(1)
    typebg5:setPosition(cc.p(175, 240))
    typebg5:addTo(popLayer)
    local typebg6 = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/bottomchart_attribute_default.png")
    typebg6:setScale(1)
    typebg6:setPosition(cc.p(490, 240))
    typebg6:addTo(popLayer)

    --背景属性文字
    -- type1attri
    -- type1icon
    -- type1label

    local type1icon = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/icon_attribute/type.png")
    type1icon:setScale(1)
    type1icon:setPosition(cc.p(90, 460))
    type1icon:addTo(popLayer)
    local type1attri = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/text_info/type_down.png")
    type1attri:setScale(1)
    type1attri:setPosition(cc.p(130, 480))
    type1attri:addTo(popLayer)
    local type1label=cc.Label:createWithTTF("攻击向","ui/font/fzzdhjw.ttf",26)
    type1label:setScale(1)
    type1label:setColor(cc.c3b(255, 255, 255))
    type1label:setAnchorPoint(0,1)
    type1label:pos(0+115,460)
    type1label:enableOutline(cc.c4b(20, 20, 66, 255),2)
    type1label:addTo(popLayer)


    local type2icon = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/icon_attribute/ATK.png")
    type2icon:setScale(1)
    type2icon:setPosition(cc.p(400, 460))
    type2icon:addTo(popLayer)
    local type2attri = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/text_info/ATK.png")
    type2attri:setScale(1)
    type2attri:setPosition(cc.p(450, 480))
    type2attri:addTo(popLayer)
    local type2label=cc.Label:createWithTTF("20","ui/font/fzzdhjw.ttf",26)
    type2label:setScale(1)
    type2label:setColor(cc.c3b(255, 255, 255))
    type2label:setAnchorPoint(0,1)
    type2label:pos(0+425,460)
    type2label:enableOutline(cc.c4b(20, 20, 66, 255),2)
    type2label:addTo(popLayer)


    local type3icon = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/icon_attribute/speed.png")
    type3icon:setScale(1)
    type3icon:setPosition(cc.p(90, 350))
    type3icon:addTo(popLayer)
    local type3attri = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/text_info/speed.png")
    type3attri:setScale(1)
    type3attri:setPosition(cc.p(130, 370))
    type3attri:addTo(popLayer)
    local type3label=cc.Label:createWithTTF("0.6s","ui/font/fzzdhjw.ttf",26)
    type3label:setScale(1)
    type3label:setColor(cc.c3b(255, 255, 255))
    type3label:setAnchorPoint(0,1)
    type3label:pos(0+115,350)
    type3label:enableOutline(cc.c4b(20, 20, 66, 255),2)
    type3label:addTo(popLayer)


    local type4icon = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/icon_attribute/target.png")
    type4icon:setScale(1)
    type4icon:setPosition(cc.p(400, 350))
    type4icon:addTo(popLayer)
    local type4attri = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/text_info/target_copy.png")
    type4attri:setScale(1)
    type4attri:setPosition(cc.p(440, 370))
    type4attri:addTo(popLayer)
    local type4label=cc.Label:createWithTTF("前方","ui/font/fzzdhjw.ttf",26)
    type4label:setScale(1)
    type4label:setColor(cc.c3b(255, 255, 255))
    type4label:setAnchorPoint(0,1)
    type4label:pos(0+425,350)
    type4label:enableOutline(cc.c4b(20, 20, 66, 255),2)
    type4label:addTo(popLayer)


    local type5icon = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/icon_attribute/slowdown.png")
    type5icon:setScale(1)
    type5icon:setPosition(cc.p(90, 240))
    type5icon:addTo(popLayer)
    local type5attri = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/text_info/firsttransformationtime.png")
    type5attri:setScale(1)
    type5attri:setPosition(cc.p(170, 260))
    type5attri:addTo(popLayer)
    local type5label=cc.Label:createWithTTF("6s","ui/font/fzzdhjw.ttf",26)
    type5label:setScale(1)
    type5label:setColor(cc.c3b(255, 255, 255))
    type5label:setAnchorPoint(0,1)
    type5label:pos(0+115,240)
    type5label:enableOutline(cc.c4b(20, 20, 66, 255),2)
    type5label:addTo(popLayer)


    local type6icon = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/icon_attribute/timeinterval.png")
    type6icon:setScale(1)
    type6icon:setPosition(cc.p(400, 240))
    type6icon:addTo(popLayer)
    local type6attri = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/text_info/secondtransformationtime.png")
    type6attri:setScale(1)
    type6attri:setPosition(cc.p(490, 260))
    type6attri:addTo(popLayer)
    local type6label=cc.Label:createWithTTF("4s","ui/font/fzzdhjw.ttf",26)
    type6label:setScale(1)
    type6label:setColor(cc.c3b(255, 255, 255))
    type6label:setAnchorPoint(0,1)
    type6label:pos(0+425,240)
    type6label:enableOutline(cc.c4b(20, 20, 66, 255),2)
    type6label:addTo(popLayer)


    --按钮：升级按钮
    local upgradeButton = ccui.Button:create(
            "ui/hall/Atlas/Secondaryinterface_towerinfo/button_upgrade.png",
            "ui/hall/Atlas/Secondaryinterface_towerinfo/button_upgrade.png",
            "ui/hall/Atlas/Secondaryinterface_towerinfo/button_upgrade.png")
    upgradeButton:setPosition(cc.p(320, 110))
    upgradeButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        elseif eventType == ccui.TouchEventType.ended then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    upgradeButton:addTo(popLayer)


    --按钮：强化按钮
    local intensityButton = ccui.Button:create(
            "ui/hall/Atlas/Secondaryinterface_towerinfo/button_intensify.png",
            "ui/hall/Atlas/Secondaryinterface_towerinfo/button_intensify.png",
            "ui/hall/Atlas/Secondaryinterface_towerinfo/button_intensify.png")
    intensityButton:setPosition(cc.p(120, 110))
    intensityButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        elseif eventType == ccui.TouchEventType.ended then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    intensityButton:addTo(popLayer)

    --按钮：使用按钮
    local usingButton = ccui.Button:create(
            "ui/hall/Atlas/Secondaryinterface_towerinfo/button_use.png",
            "ui/hall/Atlas/Secondaryinterface_towerinfo/button_use.png",
            "ui/hall/Atlas/Secondaryinterface_towerinfo/button_use.png")
    usingButton:setPosition(cc.p(520, 110))
    usingButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        elseif eventType == ccui.TouchEventType.ended then
            self:towerusingPanel(layer,bg)
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    usingButton:addTo(popLayer)



    --当前暴击伤害
    local currentcriticaldanmagelabel=cc.Label:createWithTTF("200%","ui/font/fzhzgbjw.ttf",20)
    currentcriticaldanmagelabel:setScale(1)
    currentcriticaldanmagelabel:setColor(cc.c3b(255, 193, 46))
    currentcriticaldanmagelabel:setAnchorPoint(0,1)
    currentcriticaldanmagelabel:pos(0+280,45)
    currentcriticaldanmagelabel:addTo(popLayer)

    --升级后
    local upgradecurrentcriticaldanmagelabel=cc.Label:createWithTTF("+3%","ui/font/fzhzgbjw.ttf",20)
    upgradecurrentcriticaldanmagelabel:setScale(1)
    upgradecurrentcriticaldanmagelabel:setColor(cc.c3b(255, 193, 46))
    upgradecurrentcriticaldanmagelabel:setAnchorPoint(0,1)
    upgradecurrentcriticaldanmagelabel:pos(0+470,45)
    upgradecurrentcriticaldanmagelabel:addTo(popLayer)


    -- --图片：确认按钮的金币图标
    -- local coin =ccui.ImageView:create("ui/hall/shop/SecondaryInterface-Goldcoin_store_purchase_confirmation_pop-up/Icon-gold_coin.png")
    -- coin:setPosition(cc.p(60, 40))
    -- coin:addTo(confirmButton)
    -- --文本：确认按钮的金额文本
    -- local rankNum = cc.Label:createWithTTF(rank,"ui/font/fzbiaozjw.ttf",30)
    -- rankNum:setPosition(cc.p(120,40))
    -- rankNum:setColor(cc.c3b(255, 255, 255))
    -- --rankNum:enableShadow(cc.c3b(0,0,0), cc.size(2,-2), 100)--字体描边有待学习
    -- rankNum:addTo(confirmButton)

    --按钮：关闭窗口
    local closeButton = ccui.Button:create(
            "ui/hall/shop/SecondaryInterface-Goldcoin_store_purchase_confirmation_pop-up/Button-off.png",
            "ui/hall/shop/SecondaryInterface-Goldcoin_store_purchase_confirmation_pop-up/Button-off.png",
            "ui/hall/shop/SecondaryInterface-Goldcoin_store_purchase_confirmation_pop-up/Button-off.png")
    closeButton:setPosition(cc.p(620, 770))
    closeButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        elseif eventType == ccui.TouchEventType.ended then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
            towerinfoLayer:setVisible(false)--隐藏二级弹窗
            layer:setTouchEnabled(true)
        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    closeButton:addTo(popLayer)
end

--塔按钮
function AtlasScene:createCollectedItem(layer,path,bg,towertype,rank,offsetX,offsetY)--层级、稀有度背景、图片路径、塔种类、等级、偏移量

    --按钮：商品1
    local ItemButton = ccui.Button:create(path, path, path)
    ItemButton:setPosition(cc.p(100+offsetX, display.top-340+offsetY))
    ItemButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.ended then
            self:towerinfoPanel(layer,bg,path,towertype,rank)
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    ItemButton:addTo(layer)
    --塔
    local towerbg = ccui.ImageView:create(bg)
    towerbg:setPosition(cc.p(80,145))
    towerbg:addTo(ItemButton)

    --攻击 辅助 控制 干扰 召唤
    local towertypeicon =ccui.ImageView:create(towertype)
    towertypeicon:setPosition(cc.p(125, 205))
    towertypeicon:addTo(ItemButton)

    -- --等级底图
    -- local goldCoinIcon =ccui.ImageView:create("ui/hall/Atlas/Subinterface_currentsquad/bottomchart_rank.png")
    -- goldCoinIcon:setPosition(cc.p(60, -20))
    -- goldCoinIcon:addTo(ItemButton)

    --等级
    local Rank =ccui.ImageView:create(rank)
    Rank:setPosition(cc.p(80, 70))
    Rank:addTo(ItemButton)

    local processbar_black = ccui.ImageView:create("ui/hall/Atlas/Subinterface_towerlist/processbar_bottomchart_numberoffragments.png")
    processbar_black:setPosition(cc.p(80,30))
    processbar_black:addTo(ItemButton)

    local processnum = cc.Label:createWithTTF("20/2","ui/font/fzbiaozjw.ttf",24)
    processnum:setPosition(cc.p(80,30))
    --165, 237, 255
    processnum:setColor(cc.c3b(165, 237, 255))
    processnum:addTo(ItemButton)




    -- HEAD01 = "ui/hall/common/Tower-Icon/01.png",
    -- HEAD02 = "ui/hall/common/Tower-Icon/02.png",
    -- HEAD03 = "ui/hall/common/Tower-Icon/03.png",
    -- HEAD04 = "ui/hall/common/Tower-Icon/04.png",
    -- HEAD05 = "ui/hall/common/Tower-Icon/05.png",


    --ui\hall\Atlas\Secondaryinterface_towerinfo

    --攻击 辅助 控制 干扰 召唤
    -- towertype_attack.png
    -- towertype_auxiliary.png
    -- towertype_control.png
    -- towertype_disturb.png
    -- towertype_summon.png

end
--阵容层
function AtlasScene:createTroopPanel()
    local width,height = display.width,display.top
    local TroopLayer = ccui.Layout:create()
    TroopLayer:setContentSize(width,height)
    TroopLayer:setAnchorPoint(0,0)
    TroopLayer:setPosition(0,0)
    
    TroopLayer:addTo(self)
    --当前阵容底图
    local currenttroop=ccui.ImageView:create("ui/hall/Atlas/Subinterface_currentsquad/bottomchart_title.png")
    currenttroop:setScale(1)
    currenttroop:setAnchorPoint(0,1)
    currenttroop:pos(0+35,height-170)
    currenttroop:addTo(TroopLayer)

    local currenttroopblack=ccui.ImageView:create("ui/hall/Atlas/Subinterface_currentsquad/bottomchart_area.png")
    currenttroopblack:setScale(1)
    currenttroopblack:setAnchorPoint(0,1)
    currenttroopblack:pos(0+35,height-255)
    currenttroopblack:addTo(TroopLayer)
    --当前阵容文字
    local trooplabel=cc.Label:createWithTTF("当前阵容","ui/font/fzbiaozjw.ttf",40)
    trooplabel:setAnchorPoint(0,1)
    trooplabel:pos(0+200,height-190)
    trooplabel:addTo(TroopLayer)

    self:createTroopItem(TroopLayer,"ui/hall/common/Tower-Icon/01.png"
    ,"ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_disturb.png","ui/hall/Atlas/Subinterface_currentsquad/rank/lv.8.png",0,0)
    self:createTroopItem(TroopLayer,"ui/hall/common/Tower-Icon/01.png"
    ,"ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_attack.png","ui/hall/Atlas/Subinterface_currentsquad/rank/lv.8.png",130,0)
    self:createTroopItem(TroopLayer,"ui/hall/common/Tower-Icon/01.png"
    ,"ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_attack.png","ui/hall/Atlas/Subinterface_currentsquad/rank/lv.8.png",130+130,0)
    self:createTroopItem(TroopLayer,"ui/hall/common/Tower-Icon/01.png"
    ,"ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_attack.png","ui/hall/Atlas/Subinterface_currentsquad/rank/lv.8.png",130*3,0)
    self:createTroopItem(TroopLayer,"ui/hall/common/Tower-Icon/01.png"
    ,"ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_attack.png","ui/hall/Atlas/Subinterface_currentsquad/rank/lv.9.png",130*4,0)



end


--阵容按钮
function AtlasScene:createTroopItem(layer,path,towertype,rank,offsetX,offsetY)--层级、图片路径、碎片数量、价格、偏移量

    --按钮：商品1
    local ItemButton = ccui.Button:create(path, path, path)
    ItemButton:setPosition(cc.p(100+offsetX, display.top-340+offsetY))
    ItemButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.ended then
            --self:goldPurchasePanel(layer,path,towertype,rank)
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    ItemButton:addTo(layer)

    --攻击 辅助 控制 干扰 召唤
    local fragmentBg =ccui.ImageView:create(towertype)
    fragmentBg:setPosition(cc.p(90, 100))
    fragmentBg:addTo(ItemButton)

    --等级底图
    local goldCoinIcon =ccui.ImageView:create("ui/hall/Atlas/Subinterface_currentsquad/bottomchart_rank.png")
    goldCoinIcon:setPosition(cc.p(60, -20))
    goldCoinIcon:addTo(ItemButton)

    --等级
    local Rank =ccui.ImageView:create(rank)
    Rank:setPosition(cc.p(60, -20))
    Rank:addTo(ItemButton)



    -- HEAD01 = "ui/hall/common/Tower-Icon/01.png",
    -- HEAD02 = "ui/hall/common/Tower-Icon/02.png",
    -- HEAD03 = "ui/hall/common/Tower-Icon/03.png",
    -- HEAD04 = "ui/hall/common/Tower-Icon/04.png",
    -- HEAD05 = "ui/hall/common/Tower-Icon/05.png",


    --ui\hall\Atlas\Secondaryinterface_towerinfo

    --攻击 辅助 控制 干扰 召唤
    -- towertype_attack.png
    -- towertype_auxiliary.png
    -- towertype_control.png
    -- towertype_disturb.png
    -- towertype_summon.png

end


function AtlasScene:onEnter()
end

function AtlasScene:onExit()
end

return AtlasScene
