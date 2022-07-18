----内容：阵容层内容以及点击替换编写
----编写人员：郑蕾、孙靖傅
---修订人员：郑蕾
---最后修改日期：7/18
local TroopLayer = {}
local Towerdata = require("app.data.Towerdata")
local TowerDef = require("app.def.TowerDef")
local KnapsackData = require("app.data.KnapsackData")
local Music = require("app.data.Music")
local SettingMusic = require("src.app.scenes.SettingMusic")

--阵容层
function TroopLayer:createTroopPanel(collectLayer)
    local height = display.top
    --阵容底图
    local troopBg=ccui.ImageView:create("ui/hall/Atlas/Subinterface_currentsquad/bottomchart_area.png")
    troopBg:setScale(1)
    troopBg:setAnchorPoint(0,1)
    troopBg:pos(0+35,height-134)
    troopBg:addTo(collectLayer)
    --顶部背景
    local troopTitleBg=ccui.ImageView:create("ui/hall/Atlas/Subinterface_currentsquad/bottomchart_title.png")
    troopTitleBg:setAnchorPoint(0,1)
    troopTitleBg:pos(35,height-50)
    troopTitleBg:addTo(collectLayer)
    --当前阵容文字
    local troopTitle=ccui.ImageView:create("ui/hall/Atlas/Subinterface_currentsquad/Text_currentdetails.png")
    troopTitle:setAnchorPoint(0,1)
    troopTitle:pos(150,55)
    troopTitle:addTo(troopTitleBg)
    --按钮底部连接
    local arrayLine=ccui.ImageView:create("ui/hall/Atlas/Subinterface_currentsquad/bottomchart_battlearrayline.png")
    arrayLine:setAnchorPoint(0,1)
    arrayLine:pos(350,40)
    arrayLine:addTo(troopTitleBg)
    --顶部三个按钮底图
    local originX = 0
    --阵容一
    self:troopFirstCreate(originX,arrayLine,collectLayer)
    originX = originX+70
    --阵容二
    self:troopSecondCreate(originX,arrayLine,collectLayer)
    originX = originX+70
    --阵容三
    self:troopThirdCreate(originX,arrayLine,collectLayer)
    --阵容数字
    local X = 385
    for i = 1,3 do
        local troopNum=ccui.ImageView:create("ui/hall/Atlas/Subinterface_currentsquad/number_"..i..".png")
        troopNum:setAnchorPoint(0.5,0.5)
        troopNum:pos(X,1180)
        troopNum:addTo(collectLayer)
        X = X+70
    end

end

--[[
    函数用途：阵容一层级
    --]]
function TroopLayer:troopFirstCreate(originX,arrayLine,collectLayer)
    local buttonBgPath = "ui/hall/Atlas/Subinterface_currentsquad/icon_unselectes.png"
    local height = display.top

    local buttonBgFirst = ccui.Button:create(buttonBgPath,buttonBgPath,buttonBgPath)
    buttonBgFirst:setAnchorPoint(0.5,0.5)
    buttonBgFirst:pos(originX,10)
    buttonBgFirst:addTo(arrayLine)
    buttonBgFirst:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            self.troop1stLayer:setVisible(true)
            self.troop2ndLayer:setVisible(false)
            self.troop3rdLayer:setVisible(false)
        end
    end)
    originX = originX+70
    --阵容一层级
    self.troop1stLayer = ccui.Layout:create()
    self.troop1stLayer:setBackGroundColorOpacity(180)--设置为透明
    --self.troop1stLayer:setBackGroundColorType(1)
    self.troop1stLayer:setContentSize(662,288)
    self.troop1stLayer:setAnchorPoint(0, 1)
    self.troop1stLayer:setPosition(35, height-50)
    self.troop1stLayer:addTo(collectLayer)
    --self.troop1stLayer:setVisible(false)
    --角标
    local arrow = ccui.ImageView:create("ui/hall/Atlas/Subinterface_currentsquad/arrow.png")
    arrow:setAnchorPoint(0.5,0.5)
    arrow:pos(350,209)
    arrow:addTo(self.troop1stLayer)
    --选中
    local selectedState = ccui.ImageView:create("ui/hall/Atlas/Subinterface_currentsquad/icon_selected.png")
    selectedState:setAnchorPoint(0.5,0.5)
    selectedState:pos(350,238)
    selectedState:addTo(self.troop1stLayer)
    --层级,卡牌图片路径,卡牌类型,卡牌等级,offsetX,offsetY
    self:createTroopItem(self.troop1stLayer,1,0,0)
    self:createTroopItem(self.troop1stLayer,6,130,0)
    self:createTroopItem(self.troop1stLayer,8,130+130,0)
    self:createTroopItem(self.troop1stLayer,9,130*3,0)
    self:createTroopItem(self.troop1stLayer,7,130*4,0)

end

--[[
    函数用途：阵容二层级
    --]]
function TroopLayer:troopSecondCreate(originX,arrayLine,collectLayer)
    local buttonBgPath = "ui/hall/Atlas/Subinterface_currentsquad/icon_unselectes.png"
    local height = display.top

    local buttonBgSecond = ccui.Button:create(buttonBgPath,buttonBgPath,buttonBgPath)
    buttonBgSecond:setAnchorPoint(0.5,0.5)
    buttonBgSecond:pos(originX,10)
    buttonBgSecond:addTo(arrayLine)
    buttonBgSecond:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            self.troop1stLayer:setVisible(false)
            self.troop2ndLayer:setVisible(true)
            self.troop3rdLayer:setVisible(false)
        end
    end)
    --阵容二层级
    self.troop2ndLayer = ccui.Layout:create()
    self.troop2ndLayer:setBackGroundColorOpacity(180)--设置为透明
    --self.troop2ndLayer:setBackGroundColorType(1)
    self.troop2ndLayer:setContentSize(662,288)
    self.troop2ndLayer:setAnchorPoint(0, 1)
    self.troop2ndLayer:setPosition(35, height-50)
    self.troop2ndLayer:addTo(collectLayer)
    self.troop2ndLayer:setVisible(false)
    --角标
    local arrow = ccui.ImageView:create("ui/hall/Atlas/Subinterface_currentsquad/arrow.png")
    arrow:setAnchorPoint(0.5,0.5)
    arrow:pos(420,209)
    arrow:addTo(self.troop2ndLayer)
    --选中
    local selectedState = ccui.ImageView:create("ui/hall/Atlas/Subinterface_currentsquad/icon_selected.png")
    selectedState:setAnchorPoint(0.5,0.5)
    selectedState:pos(420,238)
    selectedState:addTo(self.troop2ndLayer)
    --层级,卡牌图片路径,卡牌类型,卡牌等级,offsetX,offsetY
    self:createTroopItem(self.troop2ndLayer,2,0,0)
    self:createTroopItem(self.troop2ndLayer,6,130,0)
    self:createTroopItem(self.troop2ndLayer,8,130+130,0)
    self:createTroopItem(self.troop2ndLayer,9,130*3,0)
    self:createTroopItem(self.troop2ndLayer,7,130*4,0)

end

--[[
    函数用途：阵容三层级
    --]]
function TroopLayer:troopThirdCreate(originX,arrayLine,collectLayer)
    local buttonBgPath = "ui/hall/Atlas/Subinterface_currentsquad/icon_unselectes.png"
    local height = display.top

    local buttonBgThird = ccui.Button:create(buttonBgPath,buttonBgPath,buttonBgPath)
    buttonBgThird:setAnchorPoint(0.5,0.5)
    buttonBgThird:pos(originX,10)
    buttonBgThird:addTo(arrayLine)
    buttonBgThird:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            self.troop1stLayer:setVisible(false)
            self.troop2ndLayer:setVisible(false)
            self.troop3rdLayer:setVisible(true)
        end
    end)
    --阵容二层级
    self.troop3rdLayer = ccui.Layout:create()
    self.troop3rdLayer:setBackGroundColorOpacity(180)--设置为透明
    --self.troop2ndLayer:setBackGroundColorType(1)
    self.troop3rdLayer:setContentSize(662,288)
    self.troop3rdLayer:setAnchorPoint(0, 1)
    self.troop3rdLayer:setPosition(35, height-50)
    self.troop3rdLayer:addTo(collectLayer)
    self.troop3rdLayer:setVisible(false)
    --角标
    local arrow = ccui.ImageView:create("ui/hall/Atlas/Subinterface_currentsquad/arrow.png")
    arrow:setAnchorPoint(0.5,0.5)
    arrow:pos(490,209)
    arrow:addTo(self.troop3rdLayer)
    --选中
    local selectedState = ccui.ImageView:create("ui/hall/Atlas/Subinterface_currentsquad/icon_selected.png")
    selectedState:setAnchorPoint(0.5,0.5)
    selectedState:pos(490,238)
    selectedState:addTo(self.troop3rdLayer)
    --层级,卡牌图片路径,卡牌类型,卡牌等级,offsetX,offsetY
    self:createTroopItem(self.troop3rdLayer,3,0,0)
    self:createTroopItem(self.troop3rdLayer,6,130,0)
    self:createTroopItem(self.troop3rdLayer,8,130+130,0)
    self:createTroopItem(self.troop3rdLayer,9,130*3,0)
    self:createTroopItem(self.troop3rdLayer,7,130*4,0)

end

--阵容按钮
function TroopLayer:createTroopItem(layer,i,offsetX,offsetY)
    local path = Towerdata.OBTAINED[i]
    local towerType = "ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_"..TowerDef.TABLE[i].TYPE..".png"
    local id = tonumber(string.sub(path,27,-5))
    local level = "ui/hall/Atlas/Subinterface_currentsquad/rank/lv."..KnapsackData:getTowerGrade(id)..".png"

    --按钮
    local ItemButton = ccui.ImageView:create(path)
    ItemButton:setPosition(cc.p(75+offsetX, offsetY+120))
    ItemButton:setTouchEnabled(true)
    ItemButton:addTo(layer)

    --攻击 辅助 控制 干扰 召唤
    local quality =ccui.ImageView:create(towerType)
    quality:setPosition(cc.p(90, 100))
    quality:addTo(ItemButton)

    --等级底图
    local levelBg =ccui.ImageView:create("ui/hall/Atlas/Subinterface_currentsquad/bottomchart_rank.png")
    levelBg:setPosition(cc.p(60, -20))
    levelBg:addTo(ItemButton)
    --等级
    local levels =ccui.ImageView:create(level)
    levels:setPosition(cc.p(60, -20))
    levels:addTo(ItemButton)

    ItemButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
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
            if self.i~=0 then--如果ID存在则替换，替换后设置为0放置再次点击会继续替换
                self:Change(ItemButton,quality,levels,self.i)
                self.i = 0
            end
            self.towerUsingLayer:setVisible(false)--隐藏弹窗

        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)

end

--[[
    函数用途：替换卡牌
    --]]
function TroopLayer:Change(ItemButton,quality,levels,i)
    local path = Towerdata.OBTAINED[i]
    local towerType = "ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_"..TowerDef.TABLE[i].TYPE..".png"
    local id = tonumber(string.sub(path,27,-5))
    local level = "ui/hall/Atlas/Subinterface_currentsquad/rank/lv."..KnapsackData:getTowerGrade(id)..".png"
    ItemButton:loadTexture(path)
    quality:loadTexture(towerType)
    levels:loadTexture(level)
end

--二级页面（使用）
function TroopLayer:towerUsingPanel(collectLayer,icon)
    local width ,height = display.width,display.height
    self.i = tonumber(string.sub(icon,27,-5))
    --层：背景层
    self.towerUsingLayer = ccui.Layout:create()
    --self.towerUsingLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    self.towerUsingLayer:setBackGroundColorOpacity(180)--设置透明度
    self.towerUsingLayer:setContentSize(width, height)
    self.towerUsingLayer:pos(width*0.5, height *0.5)
    self.towerUsingLayer:setAnchorPoint(0.5, 0.5)
    self.towerUsingLayer:addTo(collectLayer)

    local popLayer = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerusing/group119.png")
    popLayer:pos(display.cx,display.cy)
    popLayer:setAnchorPoint(0.5,0.5)
    popLayer:addTo(self.towerUsingLayer)

    local towerIcon = ccui.ImageView:create(icon)
    towerIcon:setPosition(304,230)
    towerIcon:addTo(popLayer)

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
            self.towerusingLayer:setVisible(false)--隐藏二级弹窗
            collectLayer:setTouchEnabled(true)
        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    cancelButton:addTo(popLayer)


end

return TroopLayer