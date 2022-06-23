local HeadScene = class("HeadScene", function()
    return display.newScene("HeadScene")
end)
local Headdata = require("app/data/Headdata")

function HeadScene:ctor()

    self:createMiddleMiddlePanel()

    --开始游戏按钮
    local images = {
        normal = "ui/hall/battle/Button-Battle_Mode.png",
        pressed = "",
        disabled = "ui/hall/battle/Button-Battle_Mode.png"
    }

    local NewGameBtn = ccui.Button:create(images["normal"], images["pressed"], images["disabled"])
    NewGameBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    NewGameBtn:setPosition(cc.p(display.cx, display.cy))
    NewGameBtn:setScale(0.5, 0.5)
    NewGameBtn:setEnabled(true)

    NewGameBtn:addTouchEventListener(function(sender, eventType)
	 	if eventType == ccui.TouchEventType.ended then
	 		local ABtn = import("app.scenes.GameView.GameScene"):new()
            display.replaceScene(ABtn,"turnOffTiles",0.5)
            print(transform)
	 	end
	end)

    -- local battleBtn = ccui.Button:create(
    --     "ui/hall/bottom-tab/tab-unselected-middle.png",
    --     "ui/hall/bottom-tab/tab-selected.png",
    --     "ui/hall/bottom-tab/tab-unselected-middle.png"
    -- )
    -- battleBtn:setAnchorPoint(0,0)
    -- battleBtn:setScale(240/230)
    -- battleBtn:pos(0+230*240/230,0)
    -- battleBtn:addTo(menuLayer)

    self:addChild(NewGameBtn)

    self:createMiddleBottomPanel()
    self:createMiddleTopPanel()

    self:createlayerPanel()

end

function HeadScene:createMiddleMiddlePanel()
    local width ,height  =display.width,display.top
    local settingLayer = ccui.Layout:create()
    settingLayer:setBackGroundImage("ui/hall/battle/bg-battle_interface.png")
    settingLayer:setContentSize(width,height)
    settingLayer:setAnchorPoint(0.5,0.5)
    settingLayer:setPosition(width*0.5,height*0.5)
    
    settingLayer:addTo(self)

end

function HeadScene:createMiddleBottomPanel()
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
function HeadScene:createMiddleTopPanel()
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
			local newScene=import("app/scenes/HeadScene"):new()
            display.replaceScene(newScene)
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
			local newScene=import("app/scenes/??Scene"):new()
            display.replaceScene(newScene)
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

function HeadScene:createlayerPanel()

    local width ,height = display.width,display.height
    local HeadLayer = ccui.Layout:create()
    HeadLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    HeadLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    HeadLayer:setBackGroundColorOpacity(128)--设置透明度
    HeadLayer:setContentSize(width, height)
    HeadLayer:pos(width*0.5, height *0.5)
    HeadLayer:setAnchorPoint(0.5, 0.5)
    HeadLayer:addTo(self)

    --ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/bg-popup.png
    --选择头像
    local headselection=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/bg-popup.png")
    headselection:setScale(1)
    headselection:setAnchorPoint(0,1)
    headselection:pos(0+50,height-110)
    headselection:addTo(HeadLayer)

    
    --叉掉
    local deleteBtn=ccui.Button:create(
        "ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/button-close.png",
        "",
        "ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/button-close.png"
    )
    deleteBtn:setScale(1)
    deleteBtn:setAnchorPoint(0,1)
    deleteBtn:pos(0+600,height-125)
    deleteBtn:addTo(HeadLayer)

    deleteBtn:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
            --一系列操作（清空缓存）

			-- local newScene=import("app/scenes/MainScene"):new()
            -- display.replaceScene(newScene)
            cc.Director:getInstance():popScene()
		end
	end)

    --头像和文字

    local headicon =ccui.ImageView:create("ui/hall/common/Tower-Icon/01.png")
    headicon:setScale(1)
    headicon:setAnchorPoint(0,1)
    headicon:pos(0+150,height-250)
    headicon:addTo(HeadLayer)

    local wordicon =cc.Label:createWithTTF("火焰猎人","ui/font/fzbiaozjw.ttf",30)
    wordicon:setScale(1)
    wordicon:setAnchorPoint(0,1)
    wordicon:pos(0+290,height-250)
    wordicon:addTo(HeadLayer)




    --介绍
    local infoicon=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/Prompt_text.png")
    infoicon:setScale(1)
    infoicon:setAnchorPoint(0,1)
    infoicon:pos(0+280,height-300)
    infoicon:addTo(HeadLayer)

    --bg-slider
    local evergeticon=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/bg-slider.png")
    evergeticon:setScale(1)
    evergeticon:setAnchorPoint(0,1)
    evergeticon:pos(0+65,height-410)
    evergeticon:addTo(HeadLayer)

    --已获得
    local evergeticon=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/Split_line-obtained.png")
    evergeticon:setScale(1)
    evergeticon:setAnchorPoint(0,1)
    evergeticon:pos(0+90,height-420)
    evergeticon:addTo(HeadLayer)


    --未获得
    local nevergeticon=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/Split_line-not_obtained.png")
    nevergeticon:setScale(1)
    nevergeticon:setAnchorPoint(0,1)
    nevergeticon:pos(0+90,height-820)
    nevergeticon:addTo(HeadLayer)

    --确认
    local confirmBtn=ccui.Button:create(
        "ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/button-confirm.png",
        "",
        "ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/button-confirm.png"
    )
    confirmBtn:setScale(1)
    confirmBtn:setAnchorPoint(0,1)
    confirmBtn:pos(0+230,height-1055)
    confirmBtn:addTo(HeadLayer)

    confirmBtn:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then

            --一系列操作（确认缓存文件，并清空缓存）

			-- local newScene=import("app/scenes/MainScene"):new()
            -- display.replaceScene(newScene)
            cc.Director:getInstance():popScene()
		end
	end)

    -- print(Headdata.OBTAINED.HEAD01)
    -- print(Headdata.OBTAINED2[2])

    -- self:createItem(HeadLayer,Headdata.OBTAINED2[1],0,0)
    -- self:createItem(HeadLayer,Headdata.OBTAINED2[2],110,0)
    -- self:createItem(HeadLayer,Headdata.OBTAINED2[3],220,0)
    -- self:createItem(HeadLayer,Headdata.OBTAINED2[4],330,0)
    -- self:createItem(HeadLayer,Headdata.OBTAINED2[5],0,-150)
    local a = 0
    local b = 0
    for key, value in pairs(Headdata.OBTAINED2) do

        self:createItem(HeadLayer,value,a,b)
        a=a+110
        if key%4 ==0 then
            a = 0
            b = b-115
        end
    end

    local c = 0
    local d = 0
    for key, value in pairs(Headdata.NOTOBTAINED2) do

        self:createItem2(HeadLayer,value,c,d)
        c=c+110
        if key%4 ==0 then
            c = 0
            d = d-115
        end
    end

    -- 屏蔽点击
    HeadLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) 
        if event.name == "began" then
            return true
        end
    end)
    HeadLayer:setTouchEnabled(true)


end

function HeadScene:createItem(layer,path,offsetX,offsetY)--层级、图片路径、碎片数量、价格、偏移量
    --按钮：商品1
    local ItemButton = ccui.Button:create(path, path, path)
    ItemButton:setPosition(cc.p(200+offsetX, display.top-530+offsetY))
    ItemButton:addTouchEventListener(function(sender,eventType)--点击事件
        if eventType == ccui.TouchEventType.ended then
            -- print("buy")
            --获取path找到图片的名字传回文件

            --后续读文件修改头像
        end
    end)
    ItemButton:addTo(layer)

end

function HeadScene:createItem2(layer,path,offsetX,offsetY)--层级、图片路径、碎片数量、价格、偏移量
    --按钮：商品1
    local ItemButton = ccui.Button:create(path, path, path)
    ItemButton:setPosition(cc.p(200+offsetX, display.top-930+offsetY))
    ItemButton:addTouchEventListener(function(sender,eventType)--点击事件
        if eventType == ccui.TouchEventType.ended then
            print("buy")
        end
    end)
    ItemButton:addTo(layer)

end

function HeadScene:onEnter()
end

function HeadScene:onExit()
end

return HeadScene
