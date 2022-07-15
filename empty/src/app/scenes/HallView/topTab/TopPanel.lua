----内容：顶部信息栏
----编写人员：孙靖博、郑蕾
----修订人员：郑蕾
----最后修改日期：7/15

local TopPanel = {}
local KnapsackData = require("app.data.KnapsackData")
local SettingMusic = require("src/app/scenes/SettingMusic")
local Towerdata = require("app/data/Towerdata")
local TowerDef  = require("app.def.TowerDef")
local Music = require("app/data/Music")
local SettingMusic = require("src/app/scenes/SettingMusic")


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
    --顶部背景
    local TopPanelBg=ccui.ImageView:create("ui/hall/Prompt text/bg-topPanel.png")
    TopPanelBg:setAnchorPoint(0,1)
    TopPanelBg:pos(0,height)
    TopPanelBg:addTo(infoLayer)

    --玩家名称背景框
    local playerInfoBg=ccui.ImageView:create("ui/hall/Prompt text/bg-name.png")
    playerInfoBg:setScale(1)
    playerInfoBg:setAnchorPoint(0,1)
    playerInfoBg:pos(100,height-20)
    playerInfoBg:addTo(infoLayer)
    --头像按钮
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
            local MusicOn = SettingMusic:isMusic1()
            print(MusicOn)
            if MusicOn == true then
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.playEffect(Music.COMMON[1])
                end)
            else
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.stopEffect()
                end)
            end
            --更换头像
            self:replaceHeadIcon(layer)
        end
    end)
    --头像文件
    self.head = "ui/hall/Prompt text/Default_Avatar.png"
    --头像区域
    self.headBg=ccui.ImageView:create(self.head)
    self.headBg:setAnchorPoint(0,1)
    self.headBg:pos(8,height-10)
    self.headBg:addTo(infoLayer)
    --名字
    local nameLabel=cc.Label:createWithTTF("黑山老妖04","ui/font/fzbiaozjw.ttf",20)
    nameLabel:setScale(1)
    nameLabel:setAnchorPoint(0,1)
    nameLabel:setColor(cc.c3b(255, 255, 255))
    nameLabel:pos(150,height-30)
    nameLabel:addTo(infoLayer)
    --奖杯图标
    local cupIcon=ccui.ImageView:create("ui/hall/Prompt text/trophy.png")
    cupIcon:setScale(1)
    cupIcon:setAnchorPoint(0,1)
    cupIcon:pos(0+150,height-70)
    cupIcon:addTo(infoLayer)

    --金币数量背景
    local goldNumBg=ccui.ImageView:create("ui/hall/Prompt text/bg-Base-diamonds &amp; gold coins.png")
    goldNumBg:setAnchorPoint(0,1)
    goldNumBg:pos(0+450,height-25)
    goldNumBg:addTo(infoLayer)
    --金币图标
    local coinIcon=ccui.ImageView:create("ui/hall/Prompt text/Gold-coin.png")
    coinIcon:setScale(1)
    coinIcon:setAnchorPoint(0,1)
    coinIcon:pos(0+430,height-20)
    coinIcon:addTo(infoLayer)

    --钻石数量背景
    local diamondNumBg=ccui.ImageView:create("ui/hall/Prompt text/bg-Base-diamonds &amp; gold coins.png")
    diamondNumBg:setAnchorPoint(0,1)
    diamondNumBg:pos(450,height-75)
    diamondNumBg:addTo(infoLayer)
    --钻石图标
    local diamondIcon=ccui.ImageView:create("ui/hall/Prompt text/Diamonds.png")
    diamondIcon:setScale(1)
    diamondIcon:setAnchorPoint(0,1)
    diamondIcon:pos(430,height-70)
    diamondIcon:addTo(infoLayer)

    --奖杯数
    local cupNum = KnapsackData:getCups()
    self.cupLabel=cc.Label:createWithTTF(cupNum,"ui/font/fzbiaozjw.ttf",24)
    self.cupLabel:setScale(1)
    self.cupLabel:setColor(cc.c3b(255,206,55))
    self.cupLabel:setAnchorPoint(0,1)
    self.cupLabel:pos(0+200,height-75)
    self.cupLabel:addTo(layer)
    --金币数
    local coinNum = KnapsackData:getGoldCoin()
    self.coinLabel=cc.Label:createWithTTF(coinNum,"ui/font/fzbiaozjw.ttf",26)
    self.coinLabel:setScale(1)
    self.coinLabel:setAnchorPoint(0,1)
    self.coinLabel:setColor(cc.c3b(255,255,255))
    self.coinLabel:pos(0+480,height-30)
    self.coinLabel:addTo(layer)
    --钻石数
    local diamondNum = KnapsackData:getDiamonds()
    self.diamondLabel=cc.Label:createWithTTF(diamondNum,"ui/font/fzbiaozjw.ttf",26)
    self.diamondLabel:setScale(1)
    self.diamondLabel:setAnchorPoint(0,1)
    self.diamondLabel:setColor(cc.c3b(255,255,255))
    self.diamondLabel:pos(0+480,height-80)
    self.diamondLabel:addTo(layer)

    --设置按钮
    local menuBtn = ccui.Button:create(
            "ui/hall/Prompt text/button-menu.png",
            "",
            "ui/hall/Prompt text/button-menu.png"
    )
    menuBtn:setAnchorPoint(0,1)
    menuBtn:pos(630,height-35)
    menuBtn:addTo(infoLayer)
    menuBtn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            local MusicOn = SettingMusic:isMusic1()
            print(MusicOn)
            if MusicOn == true then
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.playEffect(Music.COMMON[1])
                end)
            else
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.stopEffect()
                end)
            end
            --打开设置面板
            self:menuPopLayer(layer)
        end
    end)

end

--更新金币数量
function TopPanel:setCoinString(str)
    if self.coinLabel then
        self.coinLabel:setString(str)
    end
end

--更新钻石数量
function TopPanel:setDiamondsString(str)
    if self.diamondLabel then
        self.diamondLabel:setString(str)
    end
end

--更新奖杯数量
function TopPanel:setCupsString(str)
    if self.cupLabel then
        self.cupLabel:setString(str)
    end
end

--更新名称
function TopPanel:setWordString(str)
    if self.nameLabel then
        self.nameLabel:setString(str)
    end
end

--[[
    函数用途：菜单弹窗
    --]]
function TopPanel:menuPopLayer(layer)
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
    menuLayer:pos(350,height-40)
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
            local MusicOn = SettingMusic:isMusic1()
            print(MusicOn)
            if MusicOn == true then
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.playEffect(Music.COMMON[1])
                end)
            else
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.stopEffect()
                end)
            end
            --公告弹窗
            print("功能未实现")
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
            local MusicOn = SettingMusic:isMusic1()
            print(MusicOn)
            if MusicOn == true then
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.playEffect(Music.COMMON[1])
                end)
            else
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.stopEffect()
                end)
            end
            --邮箱弹窗
            print("功能未实现")
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
            local MusicOn = SettingMusic:isMusic1()
            print(MusicOn)
            if MusicOn == true then
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.playEffect(Music.COMMON[1])
                end)
            else
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.stopEffect()
                end)
            end
            --对战记录弹窗
            print("功能未实现")
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
            local MusicOn = SettingMusic:isMusic1()
            print(MusicOn)
            if MusicOn == true then
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.playEffect(Music.COMMON[1])
                end)
            else
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.stopEffect()
                end)
            end
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

--[[
    函数用途：设置弹窗
    --]]
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

            local isMusic = SettingMusic:setMusic1(true)
            print(isMusic)
            print("音效开启")

            --音效是开启音效时候，全局变量设置为1，进入游戏界面如果全局变量1，则音效开启
        else
            print("2")

            local isMusic = SettingMusic:setMusic1(false)
            print(isMusic)
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
            print(isMusic)
            print("音乐开启")

            local MusicOn = SettingMusic:isMusic2()
            print(MusicOn)
            if MusicOn == true then
                local audio = require("framework.audio")
                audio.loadFile(Music.MUSIC[1], function ()
                    audio.playEffect(Music.MUSIC[1])
                end)
            else
                local audio = require("framework.audio")
                audio.loadFile(Music.MUSIC[1], function ()
                    audio.stopEffect()
                end)
            end

            --音效是开启音效时候，全局变量设置为1，进入游戏界面如果全局变量1，则音效开启
        else
            print("2")

            local isMusic = SettingMusic:setMusic2(false)
            print(isMusic)
            print("音乐关闭")

            local MusicOn = SettingMusic:isMusic2()
            print(MusicOn)
            if MusicOn == true then
                local audio = require("framework.audio")
                audio.loadFile(Music.MUSIC[1], function ()
                    audio.playEffect(Music.MUSIC[1])
                end)
            else
                local audio = require("framework.audio")
                audio.loadFile(Music.MUSIC[1], function ()
                    audio.stopEffect()
                end)
            end


            local isMusic = SettingMusic:setMusic2(false)
            print(isMusic)
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
            print(isMusic)
            print("技能介绍开启")

            --音效是开启音效时候，全局变量设置为1，进入游戏界面如果全局变量1，则音效开启
        else
            print("2")


            local isMusic = SettingMusic:setMusic3(false)
            print(isMusic)
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
            local MusicOn = SettingMusic:isMusic1()
            print(MusicOn)
            if MusicOn == true then
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.playEffect(Music.COMMON[1])
                end)
            else
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.stopEffect()
                end)
            end
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
            local MusicOn = SettingMusic:isMusic1()
            print(MusicOn)
            if MusicOn == true then
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.playEffect(Music.COMMON[1])
                end)
            else
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.stopEffect()
                end)
            end
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


--[[
    函数用途：替换头像二级界面
    --]]
function TopPanel:replaceHeadIcon(layer)

    --灰色背景层
    local width ,height = display.width,display.height
    local grayLayer = ccui.Layout:create()
    grayLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    grayLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    grayLayer:setBackGroundColorOpacity(128)--设置透明度
    grayLayer:setContentSize(width, height)
    grayLayer:pos(width*0.5, height *0.5)
    grayLayer:setAnchorPoint(0.5, 0.5)
    grayLayer:addTo(layer)

    --选择头像弹窗背景层
    local popUpLayer=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/bg-popup.png")
    popUpLayer:setAnchorPoint(0.5,0.5)
    popUpLayer:pos(display.cx,display.top-600)
    popUpLayer:addTo(grayLayer)

    --关闭按钮
    local deleteBtn=ccui.Button:create(
            "ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/button-close.png",
            "",
            "ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/button-close.png"
    )
    deleteBtn:setAnchorPoint(0.5,0.5)
    deleteBtn:pos(580,1010)
    deleteBtn:addTo(popUpLayer)
    deleteBtn:addTouchEventListener(function(sender, eventType)
        local MusicOn = SettingMusic:isMusic1()
        print(MusicOn)
        if MusicOn == true then
            local audio = require("framework.audio")
            audio.loadFile(Music.COMMON[2], function ()
                audio.playEffect(Music.COMMON[2])
            end)
        else
            local audio = require("framework.audio")
            audio.loadFile(Music.COMMON[2], function ()
                audio.stopEffect()
            end)
        end
        if 2 == eventType then
            grayLayer:setVisible(false)--隐藏二级弹窗
        end
    end)

    --头像
    self.headIcon =ccui.ImageView:create(self.head)
    self.headIcon:setScale(1)
    self.headIcon:setAnchorPoint(0,1)
    self.headIcon:pos(90,950)
    self.headIcon:addTo(popUpLayer)
    --头像名称
    self.name = "初始头像"
    self.nameLabel =cc.Label:createWithTTF(self.name,"ui/font/fzbiaozjw.ttf",30)
    self.nameLabel:setAnchorPoint(0,1)
    self.nameLabel:pos(220,950)
    self.nameLabel:addTo(popUpLayer)
    --介绍
    local infoText=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/Prompt_text.png")
    infoText:setScale(1)
    infoText:setAnchorPoint(0,1)
    infoText:pos(220,900)
    infoText:addTo(popUpLayer)


    --头像替换区背景
    local bg=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/bg-slider.png")
    bg:setAnchorPoint(0,1)
    bg:pos(15,800)
    bg:addTo(popUpLayer)
    --listView翻页
    local listView = ccui.ListView:create()
    listView:setContentSize(598,634)
    listView:setPosition(0,0)
    listView:setAnchorPoint(0, 0)
    listView:setDirection(1)--垂直方向
    listView:setItemsMargin(10)--间距
    listView:setBounceEnabled(true)--滑动惯性
    listView:addTo(bg)

    --已获得层级
    local slideLayer = ccui.Layout:create()
    --slideLayer:setBackGroundColorOpacity(180)--设置为透明
    --slideLayer:setBackGroundColorType(1)
    slideLayer:setAnchorPoint(0, 1)
    slideLayer:setPosition(cc.p(0, 0))
    slideLayer:setContentSize(598, 1000)
    slideLayer:addTo(listView)


    --已获得标题
    local getTitle=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/Split_line-obtained.png")
    getTitle:setAnchorPoint(0,0)
    getTitle:pos(20,940)
    getTitle:addTo(slideLayer)

    --将头像分类
    local towerdataobtained = {}
    local towerdatanotobtained = {}
    for i = 1, 20, 1 do
        if KnapsackData:getTowerData(i).unlock_  then
            table.insert(towerdataobtained,i)
        else
            table.insert(towerdatanotobtained,i)
        end
    end

    --排列已解锁的头像
    local offsetX = 0
    local offsetY = 0
    local finalY = display.top-400
    print(finalY)
    for key, value in pairs(towerdataobtained) do
        self:createGetHead(slideLayer,Towerdata.OBTAINED[value],offsetX,offsetY)
        offsetX = offsetX+130
        if key%4 ==0 then
            offsetX = 0
            finalY = finalY + offsetY-10
            offsetY = offsetY-120
        end
    end
    --如果已解锁数量不是4的倍数那未获得部分需要往下移动一行
    if #towerdataobtained%4 ~=0 then
        finalY = finalY-250
    end

    --未获得标题
    local notGetTitle=ccui.ImageView:create("ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/Split_line-not_obtained.png")
    notGetTitle:setAnchorPoint(0,0)
    notGetTitle:pos(20,finalY)
    notGetTitle:addTo(slideLayer)

    --排列未解锁的头像
    local offsetX = 0
    local originY = finalY-100
    local offsetY = 0
    for key, value in pairs(towerdatanotobtained) do
        self:createNotGetHead(slideLayer,Towerdata.NOTOBTAINED[value],offsetX,offsetY,originY)
        offsetX=offsetX+130
        if key%4 ==0 then
            offsetX = 0
            offsetY = offsetY-120
        end
    end


    --确认按钮
    local confirmBtn=ccui.Button:create(
            "ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/button-confirm.png",
            "",
            "ui/hall/Prompt text/secondary_interface - avatar_selection_pop-up/button-confirm.png"
    )
    confirmBtn:setAnchorPoint(0,0)
    confirmBtn:pos(180,30)
    confirmBtn:addTo(popUpLayer)
    confirmBtn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            local MusicOn = SettingMusic:isMusic1()
            print(MusicOn)
            if MusicOn == true then
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.playEffect(Music.COMMON[1])
                end)
            else
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.stopEffect()
                end)
            end
            self.headBg:loadTexture(self.head)
            grayLayer:setVisible(false)--隐藏二级弹窗
        end
    end)
end

--[[
    函数用途：排列已解锁的头像
    --]]
function TopPanel:createGetHead(layer,path,offsetX,offsetY)--层级、图片路径、偏移量
    --按钮：解锁头像
    local ItemButton = ccui.Button:create(path, path, path)
    ItemButton:setPosition(cc.p(105+offsetX, display.top-430+offsetY))
    ItemButton:addTouchEventListener(function(sender,eventType)--点击事件
        if eventType == ccui.TouchEventType.ended then
            local MusicOn = SettingMusic:isMusic1()
            print(MusicOn)
            if MusicOn == true then
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.playEffect(Music.COMMON[1])
                end)
            else
                local audio = require("framework.audio")
                audio.loadFile(Music.COMMON[1], function ()
                    audio.stopEffect()
                end)
            end
            self.head = path
            self.headIcon:loadTexture(self.head)
            local i =tonumber(string.sub(path,-6,-5))
            TopPanel:setWordString(TowerDef.TABLE[i].NAME)
        end
    end)
    ItemButton:addTo(layer)
end

--[[
    函数用途：排列未解锁的头像
    --]]
function TopPanel:createNotGetHead(layer,path,offsetX,offsetY,originY)--层级、图片路径、碎片数量、价格、偏移量
    --按钮：未解锁头像
    local ItemButton = ccui.Button:create(path, path, path)
    ItemButton:setPosition(cc.p(105+offsetX, originY+offsetY))
    ItemButton:addTouchEventListener(function(sender,eventType)--点击事件
        if eventType == ccui.TouchEventType.ended then
        end
    end)
    ItemButton:addTo(layer)

end
return TopPanel