local SetScene = class("SetScene", function()
    return display.newScene("SetScene")
end)
local Headdata = require("app/data/Headdata")

function SetScene:ctor()

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

function SetScene:createMiddleMiddlePanel()
    local width ,height  =display.width,display.top
    local settingLayer = ccui.Layout:create()
    settingLayer:setBackGroundImage("ui/hall/battle/bg-battle_interface.png")
    settingLayer:setContentSize(width,height)
    settingLayer:setAnchorPoint(0.5,0.5)
    settingLayer:setPosition(width*0.5,height*0.5)
    
    settingLayer:addTo(self)

end

function SetScene:createMiddleBottomPanel()
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
function SetScene:createMiddleTopPanel()
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
			local newScene=import("app/scenes/SetScene"):new()
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

function SetScene:createlayerPanel()

    local width ,height = display.width,display.height
    local SetLayer = ccui.Layout:create()
    SetLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    SetLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    SetLayer:setBackGroundColorOpacity(128)--设置透明度
    SetLayer:setContentSize(width, height)
    SetLayer:pos(width*0.5, height *0.5)
    SetLayer:setAnchorPoint(0.5, 0.5)
    SetLayer:addTo(self)


    
    --设置弹窗
    local bgmenuicon1=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - setting pop-up_window/bg-Popup.png")
    bgmenuicon1:setScale(1)
    bgmenuicon1:setAnchorPoint(0,1)
    bgmenuicon1:pos(0+40,height-400)
    bgmenuicon1:addTo(SetLayer)

    --叉掉
    local deleteBtn1=ccui.Button:create(
        "ui/hall/Prompt text/secondary_interface - setting pop-up_window/button-close.png",
        "",
        "ui/hall/Prompt text/secondary_interface - setting pop-up_window/button-close.png"
    )
    deleteBtn1:setScale(1)
    deleteBtn1:setAnchorPoint(0,1)
    deleteBtn1:pos(0+610,height-415)
    deleteBtn1:addTo(SetLayer)

    deleteBtn1:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
            --一系列操作（清空缓存）

			-- local newScene=import("app/scenes/MainScene"):new()
            -- display.replaceScene(newScene)
            cc.Director:getInstance():popScene()
		end
	end)





    --退出游戏
    local deleteBtn2=ccui.Button:create(
        "ui/hall/Prompt text/secondary_interface - setting pop-up_window/button-exit.png",
        "",
        "ui/hall/Prompt text/secondary_interface - setting pop-up_window/button-exit.png"
    )
    deleteBtn2:setScale(1)
    deleteBtn2:setAnchorPoint(0,1)
    deleteBtn2:pos(0+250,height-705)
    deleteBtn2:addTo(SetLayer)

    deleteBtn2:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
            --一系列操作（清空缓存）

			-- local newScene=import("app/scenes/MainScene"):new()
            -- display.replaceScene(newScene)
            cc.Director:getInstance():popScene()
		end
	end)

    --版本号
    local font = ccui.Text:create("版本号：V60000.4334.99999999.999999 ", "", 21)
    font:setAnchorPoint(0,1)
    font:setTextColor(cc.c4b(255,255,255,60))
	font:pos(0+170,height-805)
	font:addTo(SetLayer)


  
    --音乐音效等
    local effecticon=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - setting pop-up_window/Title-Effect.png")
    effecticon:setScale(1)
    effecticon:setAnchorPoint(0,1)
    effecticon:pos(0+160,height-510)
    effecticon:addTo(SetLayer)

    local musicicon=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - setting pop-up_window/Title-Music.png")
    musicicon:setScale(1)
    musicicon:setAnchorPoint(0,1)
    musicicon:pos(0+160,height-570)
    musicicon:addTo(SetLayer)

    local skillicon=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - setting pop-up_window/Title-skill introduction.png")
    skillicon:setScale(1)
    skillicon:setAnchorPoint(0,1)
    skillicon:pos(0+160,height-510-60-60)
    skillicon:addTo(SetLayer)

    --音乐音效等按钮
    
    -- local sound_click_contrl = ccui.ImageView:create("ui/setting/sound_click_contrl_cover.png")
    -- sound_click_contrl:setAnchorPoint(0.5, 0.5)
    -- sound_click_contrl:pos(width*0.5, height*0.6)
    -- sound_click_contrl:addTo(settingLayer)
    -- local function onChangedCheckBox2(sender,eventType)
    --     local state=false
    --     if eventType==ccui.CheckBoxEventType.selected then
    --         state=true
    --         else if eventType==ccui.CheckBoxEventType.unselected then
    --             state=false
    --         end
    --     end
    --     --按照state执行命令
    --     if state then
    --         print("1")
    --         local SettingMusic = require("src/app/scenes/SettingMusic")
    --         local isMusic = SettingMusic:setMusic(true)
    --         print(isMusic)

    --         --音效是开启音效时候，全局变量设置为1，进入游戏界面如果全局变量1，则音效开启
    --     else 
    --         print("2")

    --         local SettingMusic = require("src/app/scenes/SettingMusic")
    --         local isMusic = SettingMusic:setMusic(false)
    --         print(isMusic)
    --         --音效是关闭音效时候，全局变量设置为2，进入游戏界面如果全局变量2，则音效关闭
    --     end

    -- end
    -- local sound_click_contrlButton=ccui.CheckBox:create(
    --     "ui/setting/soundon2_cover.png",
    --     "ui/setting/soundon2_cover.png",
    --     "ui/setting/soundon1_cover.png",
    --     "ui/setting/soundon1_cover.png",
    --     "ui/setting/soundon1_cover.png")
    -- sound_click_contrlButton:setAnchorPoint(0.5,0.5)
    -- sound_click_contrlButton:pos(width*0.5, height*0.5)
    -- sound_click_contrlButton:addTo(settingLayer)
    -- sound_click_contrlButton:addEventListener(onChangedCheckBox2)


    







    -- 屏蔽点击
    SetLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) 
        if event.name == "began" then
            return true
        end
    end)
    SetLayer:setTouchEnabled(true)


end



function SetScene:onEnter()
end

function SetScene:onExit()
end

return SetScene
