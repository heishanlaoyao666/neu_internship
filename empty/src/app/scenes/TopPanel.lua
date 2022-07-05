local TopPanel = {}
local Headdata = require("app/data/Headdata")
local KnapsackData = require("app.data.KnapsackData")

function TopPanel:setCoinString(str)
    coinlabel:setString(str)
end
function TopPanel:setDiamondsString(str)
    diamondlabel:setString(str)
end
function TopPanel:setCupsString(str)
    trophylabel:setString(str)
end


--[[
    函数用途：创建顶部信息栏
    --]]
function TopPanel:createMiddleTopPanel(layer)
    local width,height = display.width,display.top
    local infoLayer = ccui.Layout:create()
    infoLayer:setContentSize(width,height)
    infoLayer:setAnchorPoint(0,0)
    infoLayer:setPosition(0,0)
    infoLayer:addTo(layer)

    --奖杯数
    local cupNum = KnapsackData:getCups()
    trophylabel=cc.Label:createWithTTF(cupNum,"ui/font/fzbiaozjw.ttf",30)
    trophylabel:setScale(1)
    trophylabel:setColor(cc.c3b(255,128,0))
    trophylabel:setAnchorPoint(0,1)
    trophylabel:pos(0+200,height-70)
    trophylabel:addTo(layer)

    --金币数
    --local coinNum = Currency.getGoldCoin()
    local coinNum = KnapsackData:getGoldCoin()
    coinlabel=cc.Label:createWithTTF(coinNum,"ui/font/fzbiaozjw.ttf",30)
    coinlabel:setScale(1)
    coinlabel:setAnchorPoint(0,1)
    coinlabel:pos(0+480,height-25)
    coinlabel:addTo(layer)

    --钻石数
    local diamondNum = KnapsackData:getDiamonds()
    diamondlabel=cc.Label:createWithTTF(diamondNum,"ui/font/fzbiaozjw.ttf",30)
    diamondlabel:setScale(1)
    diamondlabel:setAnchorPoint(0,1)
    diamondlabel:pos(0+480,height-75)
    diamondlabel:addTo(layer)


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
            self:createlayerPanel(layer)
        end
    end)
    head = "ui/hall/Prompt text/Default_Avatar.png"
    headBg=ccui.ImageView:create(head)
    headBg:setScale(1)
    headBg:setAnchorPoint(0,1)
    headBg:pos(0+8,height-10)
    headBg:addTo(infoLayer)

    --名字
    local namelabel=cc.Label:createWithTTF("黑山老妖04","ui/font/fzbiaozjw.ttf",30)
    namelabel:setScale(1)
    namelabel:setAnchorPoint(0,1)
    namelabel:pos(0+150,height-25)
    namelabel:addTo(infoLayer)
    --小奖杯
    local trophyicon=ccui.ImageView:create("ui/hall/Prompt text/trophy.png")
    trophyicon:setScale(1)
    trophyicon:setAnchorPoint(0,1)
    trophyicon:pos(0+150,height-70)
    trophyicon:addTo(infoLayer)



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
            self:createsettinglayerPanel(layer)
        end
    end)

end

--右上角黄色按钮二级页面
function TopPanel:createsettinglayerPanel(layer)

    local width ,height = display.width,display.height
    local SettingLayer = ccui.Layout:create()
    SettingLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    SettingLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    SettingLayer:setBackGroundColorOpacity(128)--设置透明度
    SettingLayer:setContentSize(width, height)
    SettingLayer:pos(width*0.5, height *0.5)
    SettingLayer:setAnchorPoint(0.5, 0.5)
    SettingLayer:addTo(layer)



    --设置弹窗
    local bgmenuicon=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - menu_bar/bg-menu.png")
    bgmenuicon:setScale(1)
    bgmenuicon:setAnchorPoint(0,1)
    bgmenuicon:pos(0+350,height-40)
    bgmenuicon:addTo(SettingLayer)



    local firstBtn = ccui.Button:create(
            "ui/hall/Prompt text/secondary_interface - menu_bar/bg-Buttom.png",
            "",
            "ui/hall/Prompt text/secondary_interface - menu_bar/bg-Buttom.png"
    )
    firstBtn:setPosition(cc.p(475, display.top-100))
    firstBtn:addTouchEventListener(function(sender,eventType)--点击事件
        if eventType == ccui.TouchEventType.ended then
            print("buy")
        end
    end)
    firstBtn:addTo(SettingLayer)

    --公告
    local announcementIcon =ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - menu_bar/icon - announcement.png")
    announcementIcon:setPosition(cc.p(55, 35))
    announcementIcon:addTo(firstBtn)
    local announcementsIcon =ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - menu_bar/text - announcements.png")
    announcementsIcon:setPosition(cc.p(155, 35))
    announcementsIcon:addTo(firstBtn)



    local secBtn = ccui.Button:create(
            "ui/hall/Prompt text/secondary_interface - menu_bar/bg-Buttom.png",
            "",
            "ui/hall/Prompt text/secondary_interface - menu_bar/bg-Buttom.png"
    )
    secBtn:setPosition(cc.p(475, display.top-190))
    secBtn:addTouchEventListener(function(sender,eventType)--点击事件
        if eventType == ccui.TouchEventType.ended then
            print("buy")
        end
    end)
    secBtn:addTo(SettingLayer)

    --邮箱
    local emailIcon =ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - menu_bar/icon-email.png")
    emailIcon:setPosition(cc.p(55, 35))
    emailIcon:addTo(secBtn)
    local emailsIcon =ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - menu_bar/text-email.png")
    emailsIcon:setPosition(cc.p(155, 35))
    emailsIcon:addTo(secBtn)



    local trdBtn = ccui.Button:create(
            "ui/hall/Prompt text/secondary_interface - menu_bar/bg-Buttom.png",
            "",
            "ui/hall/Prompt text/secondary_interface - menu_bar/bg-Buttom.png"
    )
    trdBtn:setPosition(cc.p(475, display.top-280))
    trdBtn:addTouchEventListener(function(sender,eventType)--点击事件
        if eventType == ccui.TouchEventType.ended then
            print("buy")
        end
    end)
    trdBtn:addTo(SettingLayer)

    --对战记录
    local battleIcon =ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - menu_bar/icon - battle_record.png")
    battleIcon:setPosition(cc.p(55, 35))
    battleIcon:addTo(trdBtn)
    local battlesIcon =ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - menu_bar/text-battle_record.png")
    battlesIcon:setPosition(cc.p(155, 35))
    battlesIcon:addTo(trdBtn)


    local fourthBtn = ccui.Button:create(
            "ui/hall/Prompt text/secondary_interface - menu_bar/bg-Buttom.png",
            "",
            "ui/hall/Prompt text/secondary_interface - menu_bar/bg-Buttom.png"
    )
    fourthBtn:setPosition(cc.p(475, display.top-370))
    fourthBtn:addTouchEventListener(function(sender,eventType)--点击事件
        if eventType == ccui.TouchEventType.ended then
            -- print("buy")
            -- local newScene=import("app/scenes/SetScene"):new()
            -- display.replaceScene(newScene)
            self:createsetlayerPanel(layer)
        end
    end)
    fourthBtn:addTo(SettingLayer)

    --设置
    local setIcon =ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - menu_bar/icon-setting.png")
    setIcon:setPosition(cc.p(55, 35))
    setIcon:addTo(fourthBtn)
    local setsIcon =ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - menu_bar/text-setting.png")
    setsIcon:setPosition(cc.p(155, 35))
    setsIcon:addTo(fourthBtn)

    -- 屏蔽点击
    SettingLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            return true
        end
    end)
    SettingLayer:setTouchEnabled(true)


end
--设置界面二级界面
function TopPanel:createsetlayerPanel(layer)

    local width ,height = display.width,display.height
    local SetLayer = ccui.Layout:create()
    SetLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    SetLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    SetLayer:setBackGroundColorOpacity(128)--设置透明度
    SetLayer:setContentSize(width, height)
    SetLayer:pos(width*0.5, height *0.5)
    SetLayer:setAnchorPoint(0.5, 0.5)
    SetLayer:addTo(layer)
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
            -- cc.Director:getInstance():popScene()
            SetLayer:setVisible(false)
            SetLayer:setTouchEnabled(false)
            local newScene=import("app/scenes/MainScene"):new()
            display.replaceScene(newScene)
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


    local function onChangedCheckBox1(sender,eventType)
        local state=false
        if eventType==ccui.CheckBoxEventType.selected then
            state=true
        else if eventType==ccui.CheckBoxEventType.unselected then
            state=false
        end
        end
        --按照state执行命令
        if state then
            print("1")
            local SettingMusic = require("src/app/scenes/SettingMusic")
            local isMusic = SettingMusic:setMusic1(true)
            print(isMusic)

            --音效是开启音效时候，全局变量设置为1，进入游戏界面如果全局变量1，则音效开启
        else
            print("2")

            local SettingMusic = require("src/app/scenes/SettingMusic")
            local isMusic = SettingMusic:setMusic1(false)
            print(isMusic)
            --音效是关闭音效时候，全局变量设置为2，进入游戏界面如果全局变量2，则音效关闭
        end

    end
    local sound_click_contrlButton1=ccui.CheckBox:create(
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-off.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-off.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-on.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-on.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-on.png")
    sound_click_contrlButton1:setAnchorPoint(0,0)
    sound_click_contrlButton1:pos(width*0.5, height*0.5+90)
    sound_click_contrlButton1:addTo(SetLayer)
    sound_click_contrlButton1:addEventListener(onChangedCheckBox1)


    local function onChangedCheckBox2(sender,eventType)
        local state=false
        if eventType==ccui.CheckBoxEventType.selected then
            state=true
        else if eventType==ccui.CheckBoxEventType.unselected then
            state=false
        end
        end
        --按照state执行命令
        if state then
            print("1")
            local SettingMusic = require("src/app/scenes/SettingMusic")
            local isMusic = SettingMusic:setMusic2(true)
            print(isMusic)

            --音效是开启音效时候，全局变量设置为1，进入游戏界面如果全局变量1，则音效开启
        else
            print("2")

            local SettingMusic = require("src/app/scenes/SettingMusic")
            local isMusic = SettingMusic:setMusic2(false)
            print(isMusic)
            --音效是关闭音效时候，全局变量设置为2，进入游戏界面如果全局变量2，则音效关闭
        end

    end

    local sound_click_contrlButton2=ccui.CheckBox:create(
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-off.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-off.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-on.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-on.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-on.png")
    sound_click_contrlButton2:setAnchorPoint(0,0)
    sound_click_contrlButton2:pos(width*0.5, height*0.5+90-65)
    sound_click_contrlButton2:addTo(SetLayer)
    sound_click_contrlButton2:addEventListener(onChangedCheckBox2)



    local function onChangedCheckBox3(sender,eventType)
        local state=false
        if eventType==ccui.CheckBoxEventType.selected then
            state=true
        else if eventType==ccui.CheckBoxEventType.unselected then
            state=false
        end
        end
        --按照state执行命令
        if state then
            print("1")
            local SettingMusic = require("src/app/scenes/SettingMusic")
            local isMusic = SettingMusic:setMusic3(true)
            print(isMusic)

            --音效是开启音效时候，全局变量设置为1，进入游戏界面如果全局变量1，则音效开启
        else
            print("2")

            local SettingMusic = require("src/app/scenes/SettingMusic")
            local isMusic = SettingMusic:setMusic3(false)
            print(isMusic)
            --音效是关闭音效时候，全局变量设置为2，进入游戏界面如果全局变量2，则音效关闭
        end

    end

    local sound_click_contrlButton3=ccui.CheckBox:create(
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-off.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-off.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-on.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-on.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-on.png")
    sound_click_contrlButton3:setAnchorPoint(0,0)
    sound_click_contrlButton3:pos(width*0.5, height*0.5+90-65-65)
    sound_click_contrlButton3:addTo(SetLayer)
    sound_click_contrlButton3:addEventListener(onChangedCheckBox3)










    -- 屏蔽点击
    SetLayer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            return true
        end
    end)
    SetLayer:setTouchEnabled(true)


end
--选择头像二级界面
function TopPanel:createlayerPanel(layer)

    local width ,height = display.width,display.height
    local HeadLayer = ccui.Layout:create()
    HeadLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    HeadLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    HeadLayer:setBackGroundColorOpacity(128)--设置透明度
    HeadLayer:setContentSize(width, height)
    HeadLayer:pos(width*0.5, height *0.5)
    HeadLayer:setAnchorPoint(0.5, 0.5)
    HeadLayer:addTo(layer)

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
            -- cc.Director:getInstance():popScene()
            HeadLayer:setVisible(false)--隐藏二级弹窗
            -- layer:setTouchEnabled(true)
            HeadLayer:setTouchEnabled(false)
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
            -- cc.Director:getInstance():popScene()

            HeadLayer:setVisible(false)--隐藏二级弹窗
            -- layer:setTouchEnabled(true)
            HeadLayer:setTouchEnabled(false)
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

function TopPanel:createItem(layer,path,offsetX,offsetY)--层级、图片路径、偏移量
    --按钮：商品1
    local ItemButton = ccui.Button:create(path, path, path)
    ItemButton:setPosition(cc.p(200+offsetX, display.top-530+offsetY))
    ItemButton:addTouchEventListener(function(sender,eventType)--点击事件
        if eventType == ccui.TouchEventType.ended then
            head = path
            -- headBg:setString(head)
            headBg:loadTexture(head)
            print("buy")
            --获取path找到图片的名字传回文件

            --后续读文件修改头像
        end
    end)
    ItemButton:addTo(layer)

end

function TopPanel:createItem2(layer,path,offsetX,offsetY)--层级、图片路径、碎片数量、价格、偏移量
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
return TopPanel