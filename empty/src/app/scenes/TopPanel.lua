local TopPanel = {}
local Headdata = require("app/data/Headdata")
local KnapsackData = require("app.data.KnapsackData")
local SettingMusic = require("src/app/scenes/SettingMusic")
local GeneralView = require("app.scenes.HallView.common.GeneralView")

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


    --设置按钮

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
            self:createSettingLayerPanel(layer)
        end
    end)

end

--右上角黄色按钮二级页面
function TopPanel:createSettingLayerPanel(layer)

    local width ,height = display.width,display.height
    local grayLayer = ccui.Layout:create()
    grayLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    grayLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    grayLayer:setBackGroundColorOpacity(128)--设置透明度
    grayLayer:setContentSize(width, height)
    grayLayer:pos(width*0.5, height *0.5)
    grayLayer:setAnchorPoint(0.5, 0.5)
    grayLayer:setTouchEnabled(true)
    grayLayer:addTo(layer)


    --菜单弹窗
    local menuLayer=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - menu_bar/bg-menu.png")
    menuLayer:setScale(1)
    menuLayer:setAnchorPoint(0,1)
    menuLayer:pos(0+350,height-40)
    menuLayer:addTo(grayLayer)


    --公告按钮
    local announceBtn = ccui.Button:create(
            "ui/hall/Prompt text/secondary_interface - menu_bar/bg-Buttom.png",
            "",
            "ui/hall/Prompt text/secondary_interface - menu_bar/bg-Buttom.png"
    )
    announceBtn:setPosition(cc.p(130, 340))
    announceBtn:addTouchEventListener(function(sender,eventType)--点击事件
        if eventType == ccui.TouchEventType.ended then
            --公告弹窗
        end
    end)
    announceBtn:addTo(menuLayer)
    --公告图标
    local announcementIcon =ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - menu_bar/icon - announcement.png")
    announcementIcon:setPosition(cc.p(55, 35))
    announcementIcon:addTo(announceBtn)
    --公告文字
    local announcementTitle =ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - menu_bar/text - announcements.png")
    announcementTitle:setPosition(cc.p(150, 35))
    announcementTitle:addTo(announceBtn)

    --邮箱按钮
    local emailBtn = ccui.Button:create(
            "ui/hall/Prompt text/secondary_interface - menu_bar/bg-Buttom.png",
            "",
            "ui/hall/Prompt text/secondary_interface - menu_bar/bg-Buttom.png"
    )
    emailBtn:setPosition(cc.p(130, 250))
    emailBtn:addTouchEventListener(function(sender,eventType)--点击事件
        if eventType == ccui.TouchEventType.ended then
            --邮箱弹窗
        end
    end)
    emailBtn:addTo(menuLayer)

    --邮箱图标
    local emailIcon =ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - menu_bar/icon-email.png")
    emailIcon:setPosition(cc.p(55, 35))
    emailIcon:addTo(emailBtn)
    --邮箱文字
    local emailTitle =ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - menu_bar/text-email.png")
    emailTitle:setPosition(cc.p(150, 35))
    emailTitle:addTo(emailBtn)

    --对战记录按钮
    local recordBtn = ccui.Button:create(
            "ui/hall/Prompt text/secondary_interface - menu_bar/bg-Buttom.png",
            "",
            "ui/hall/Prompt text/secondary_interface - menu_bar/bg-Buttom.png"
    )
    recordBtn:setPosition(cc.p(130, 160))
    recordBtn:addTouchEventListener(function(sender,eventType)--点击事件
        if eventType == ccui.TouchEventType.ended then
            --对战记录弹窗
        end
    end)
    recordBtn:addTo(menuLayer)
    --对战记录图标
    local battleIcon =ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - menu_bar/icon - battle_record.png")
    battleIcon:setPosition(cc.p(55, 35))
    battleIcon:addTo(recordBtn)
    --对战记录文字
    local battlesTitle =ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - menu_bar/text-battle_record.png")
    battlesTitle:setPosition(cc.p(150, 35))
    battlesTitle:addTo(recordBtn)

    --设置按钮
    local settingBtn = ccui.Button:create(
            "ui/hall/Prompt text/secondary_interface - menu_bar/bg-Buttom.png",
            "",
            "ui/hall/Prompt text/secondary_interface - menu_bar/bg-Buttom.png"
    )
    settingBtn:setPosition(cc.p(130, 70))
    settingBtn:addTouchEventListener(function(sender,eventType)--点击事件
        if eventType == ccui.TouchEventType.ended then
            --隐藏菜单弹窗
            menuLayer:setVisible(false)
            --打开设置弹窗
            self:settingLayer(grayLayer)
        end
    end)
    settingBtn:addTo(menuLayer)
    --设置图标
    local settingIcon =ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - menu_bar/icon-setting.png")
    settingIcon:setPosition(cc.p(55, 35))
    settingIcon:addTo(settingBtn)
    --设置文字
    local settingTitle =ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - menu_bar/text-setting.png")
    settingTitle:setPosition(cc.p(155, 35))
    settingTitle:addTo(settingBtn)


end
--二级弹窗：设置界面
function TopPanel:settingLayer(grayLayer)
    --弹窗背景
    local popUpBg=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - setting pop-up_window/bg-Popup.png")
    popUpBg:setAnchorPoint(0.5,0.5)
    popUpBg:pos(display.cx,display.cy)
    popUpBg:addTo(grayLayer)

    --关闭按钮
    local closeBtn=ccui.Button:create(
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/button-close.png",
            "",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/button-close.png"
    )
    closeBtn:setAnchorPoint(0.5,0.5)
    closeBtn:pos(600,410)
    closeBtn:addTo(popUpBg)
    closeBtn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            --关闭弹窗
            grayLayer:setVisible(false)
        end
    end)


    --版本号
    local vision = ccui.Text:create("版本号：V60000.4334.99999999.999999 ", "", 21)
    vision:setAnchorPoint(0,1)
    vision:setTextColor(cc.c4b(255,255,255,60))
    vision:pos(0+150,40)
    vision:addTo(popUpBg)

    --音效文字
    local effectTitle=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - setting pop-up_window/Title-Effect.png")
    effectTitle:setAnchorPoint(0,1)
    effectTitle:pos(0+160,340)
    effectTitle:addTo(popUpBg)
    --音乐文字
    local musicTitle=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - setting pop-up_window/Title-Music.png")
    musicTitle:setAnchorPoint(0,1)
    musicTitle:pos(0+160,280)
    musicTitle:addTo(popUpBg)
    --技能介绍文字
    local skillTitle=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - setting pop-up_window/Title-skill introduction.png")
    skillTitle:setAnchorPoint(0,1)
    skillTitle:pos(0+160,220)
    skillTitle:addTo(popUpBg)

    --音效
    local function effectStateOnChange(sender,eventType)
        local state=false
        if eventType==ccui.CheckBoxEventType.selected then
            state=true
        elseif eventType==ccui.CheckBoxEventType.unselected then
            state=false
        end

        --按照state执行命令
        if state then
            print("1")

            local isEffect = SettingMusic:setMusic1(true)
            print("音效开启")

            --音效是开启音效时候，全局变量设置为1，进入游戏界面如果全局变量1，则音效开启
        else
            print("2")

            local isEffect = SettingMusic:setMusic1(false)
            print("音效关闭")
            --音效是关闭音效时候，全局变量设置为2，进入游戏界面如果全局变量2，则音效关闭
        end
    end

    --音效CheckBox
    local effectCheckBox=ccui.CheckBox:create(
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-off.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-off.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-on.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-on.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-on.png")
    effectCheckBox:setAnchorPoint(0,1)
    effectCheckBox:pos(display.cx,340)
    effectCheckBox:addTo(popUpBg)
    effectCheckBox:addEventListener(effectStateOnChange)


    local function musicStateOnChange(sender,eventType)
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

            local isMusic = SettingMusic:setMusic2(true)
            print("音乐开启")

            --音效是开启音效时候，全局变量设置为1，进入游戏界面如果全局变量1，则音效开启
        else
            print("2")


            local isMusic = SettingMusic:setMusic2(false)
            print("音乐关闭")
            --音效是关闭音效时候，全局变量设置为2，进入游戏界面如果全局变量2，则音效关闭
        end

    end

    local musicCheckBox=ccui.CheckBox:create(
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-off.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-off.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-on.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-on.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-on.png")
    musicCheckBox:setAnchorPoint(0,1)
    musicCheckBox:pos(display.cx, 280)
    musicCheckBox:addTo(popUpBg)
    musicCheckBox:addEventListener(musicStateOnChange)



    local function skillStateOnChange(sender,eventType)
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

            local isMusic = SettingMusic:setMusic3(true)
            print("技能介绍开启")

            --音效是开启音效时候，全局变量设置为1，进入游戏界面如果全局变量1，则音效开启
        else
            print("2")


            local isMusic = SettingMusic:setMusic3(false)
            print("技能介绍关闭")
            --音效是关闭音效时候，全局变量设置为2，进入游戏界面如果全局变量2，则音效关闭
        end

    end

    local skillCheckBox=ccui.CheckBox:create(
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-off.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-off.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-on.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-on.png",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/CheckBox-on.png")
    skillCheckBox:setAnchorPoint(0,1)
    skillCheckBox:pos(display.cx,220)
    skillCheckBox:addTo(popUpBg)
    skillCheckBox:addEventListener(skillStateOnChange)

    --退出游戏按钮
    local exitBtn=ccui.Button:create(
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/button-exit.png",
            "",
            "ui/hall/Prompt text/secondary_interface - setting pop-up_window/button-exit.png"
    )
    exitBtn:setScale(1)
    exitBtn:setAnchorPoint(0.5,0.5)
    exitBtn:pos(display.cx-50,100)
    exitBtn:addTo(popUpBg)
    exitBtn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            popUpBg:setVisible(false)
            self:exitPopLayer(grayLayer)
        end
    end)
end

--[[
    函数用途：退出弹窗
    --]]
function TopPanel:exitPopLayer(grayLayer)
    self.Type = {"Exit","Gold","Diamond","Cup","CardGold","CardFragment"}
    --弹窗背景
    local generalBg = ccui.ImageView:create("ui/hall/common/SecondaryInterface-General notification Popup/bg-pop-up.png")
    generalBg:setPosition(display.cx,display.cy)
    generalBg:addTo(grayLayer)
    generalBg:setTouchEnabled(true)
    local text = ccui.ImageView:create("ui/hall/common/SecondaryInterface-General notification Popup/Text - confirm exit.png")
    text:setAnchorPoint(0.5,0.5)
    text:setPosition(cc.p(display.cx-100, 180))
    text:addTo(generalBg)
    --确认按钮
    local confirmButton = ccui.Button:create(
            "ui/hall/common/SecondaryInterface-General notification Popup/Button - confirm.png",
            "ui/hall/common/SecondaryInterface-General notification Popup/Button - confirm.png",
            "ui/hall/common/SecondaryInterface-General notification Popup/Button - confirm.png")
    confirmButton:setAnchorPoint(0.5,0.5)
    confirmButton:setPosition(cc.p(display.cx-100, 70))
    confirmButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        elseif eventType == ccui.TouchEventType.ended then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
            cc.Director:getInstance():popScene()
        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    confirmButton:addTo(generalBg)
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