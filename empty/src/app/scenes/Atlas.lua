
local Atlas = class("Atlas")

local Headdata = require("app/data/Headdata")
local Towerdata = require("app/data/Towerdata")
local TowerDef = require("app/def/TowerDef")


function Atlas:ctor()
end

function Atlas:setATKString(str)
    type2label:setString(str)
end
function Atlas:setCOINString(str)
    coin_label:setString(str)
end

function Atlas:slide(layer)
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
        if y2-y1>50 then
            --print(layer:getPositionY())
            if layer:getPositionY() ~= 0 then--边缘内滑动
                str = "down"
            end
        elseif y1-y2>50 then
            if layer:getPositionY() ~=370 then--边缘内滑动
                str = "up"
            end
        end
    end
    local function onTouchEnded(touch, event)
        if str == "down" then
            self:slider(layer,-370)
            print(str)
        elseif str == "up" then
            self:slider(layer,370)
            print(str)
        end
    end

    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)
end

function Atlas:slider(layer,distance)
    local moveAction = cc.MoveBy:create(0.5,cc.p(0,distance))
    layer:runAction(moveAction)
end

--收集层
function Atlas:createCollectionPanel()
    local width,height = display.width,display.top
    local AtlasLayer = ccui.Layout:create()
    AtlasLayer:setBackGroundColorOpacity(180)--设置为透明
    --AtlasLayer:setBackGroundColorType(1)
    AtlasLayer:setAnchorPoint(0, 0)
    AtlasLayer:setPosition(0, display.top)




    AtlasLayer:setContentSize(720, 1280)
    self:slide(AtlasLayer)

    --图片：背景图
    local Bg = ccui.ImageView:create("ui/hall/battle/bg-battle_interface.png")
    Bg:setAnchorPoint(0.5, 0.5)
    Bg:setPosition(display.cx,display.cy)
    Bg:addTo(AtlasLayer)

    --暴击伤害提示信息
    local criticaldamageback=ccui.ImageView:create("ui/hall/Atlas/Subinterface_info/bottomchart_info.png")
    criticaldamageback:setScale(1)
    criticaldamageback:setAnchorPoint(0,1)
    criticaldamageback:pos(0+55,height-480+120)
    criticaldamageback:addTo(AtlasLayer)

    local criticaldamagebacktext2=ccui.ImageView:create("ui/hall/Atlas/Subinterface_info/Text-Totalcriticaldamage.png")
    criticaldamagebacktext2:setScale(1)
    criticaldamagebacktext2:setAnchorPoint(0,1)
    criticaldamagebacktext2:pos(0+250,height-500+120)
    criticaldamagebacktext2:addTo(AtlasLayer)

    local criticaldamagebacktext1=ccui.ImageView:create("ui/hall/Atlas/Subinterface_info/Text-anydefensetowerupgradedwillpermanentlyincreasecriticalhitdamage.png")
    criticaldamagebacktext1:setScale(1)
    criticaldamagebacktext1:setAnchorPoint(0,1)
    criticaldamagebacktext1:pos(0+190,height-550+120)
    criticaldamagebacktext1:addTo(AtlasLayer)

    --暴击值
    local criticaldamagelabel=cc.Label:createWithTTF("220%","ui/font/fzbiaozjw.ttf",30)
    criticaldamagelabel:setScale(1)
    criticaldamagelabel:setColor(cc.c3b(255,128,0))
    criticaldamagelabel:setAnchorPoint(0,1)
    criticaldamagelabel:pos(0+410,height-500+120)
    criticaldamagelabel:addTo(AtlasLayer)

    --已收集
    local collectedimage=ccui.ImageView:create("ui/hall/Atlas/Subinterface_towerlist/splitline_collected.png")
    collectedimage:setScale(1)
    collectedimage:setAnchorPoint(0,1)
    collectedimage:pos(0,height-600+120)
    collectedimage:addTo(AtlasLayer)

    -- self:createCollectedItem(AtlasLayer,"ui/hall/Atlas/Subinterface_towerlist/bottomchart-tower-rare.png",
    -- "ui/hall/common/Tower-Icon/01.png","ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_disturb.png",
    -- "ui/hall/Atlas/Subinterface_currentsquad/rank/lv.8.png",0,-450)
    -- self:createCollectedItem(AtlasLayer,"ui/hall/Atlas/Subinterface_towerlist/bottomchart-tower-rare.png",
    -- "ui/hall/common/Tower-Icon/02.png","ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_attack.png",
    -- "ui/hall/Atlas/Subinterface_currentsquad/rank/lv.8.png",170,-450)
    -- self:createCollectedItem(AtlasLayer,"ui/hall/Atlas/Subinterface_towerlist/bottomchart-tower-rare.png"
    -- ,"ui/hall/common/Tower-Icon/03.png","ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_attack.png",
    -- "ui/hall/Atlas/Subinterface_currentsquad/rank/lv.8.png",170*2,-450)
    -- self:createCollectedItem(AtlasLayer,"ui/hall/Atlas/Subinterface_towerlist/bottomchart-tower-rare.png"
    -- ,"ui/hall/common/Tower-Icon/04.png","ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_attack.png",
    -- "ui/hall/Atlas/Subinterface_currentsquad/rank/lv.8.png",170*3,-450)
    -- self:createCollectedItem(AtlasLayer,"ui/hall/Atlas/Subinterface_towerlist/bottomchart-tower-rare.png"
    -- ,"ui/hall/common/Tower-Icon/05.png","ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_attack.png",
    -- "ui/hall/Atlas/Subinterface_currentsquad/rank/lv.9.png",0,-700)


    local a = 0
    local b = -450
    for key, value in pairs(Towerdata.OBTAINED) do

        local TowerString = Towerdata.OBTAINED[key]
        --print(TowerString)
        --print("图片数字"..(string.sub(Towerdata.OBTAINED[1],-6,-5)))
        -- print("稀有度"..TowerDef.RARITY.LEGEND)
        local chartnum = tonumber(string.sub(TowerString,-6,-5))
        local rarity = TowerDef.TABLE[chartnum].RARITY
        local raritystring
        if rarity == 1 then
            --print(rarity)
            raritystring = "common"
        elseif rarity ==2 then
            --print(rarity)
            raritystring = "rare"
        elseif rarity==3 then
            --print(rarity)
            raritystring = "epic"
        else
            --print(rarity)
            raritystring = "legend"
        end

        local towertype = TowerDef.TABLE[chartnum].TYPE
        local towertypestring
        if towertype == 1 then
            --print(rarity)
            towertypestring = "attack"
        elseif towertype ==2 then
            --print(rarity)
            towertypestring = "disturb"
        elseif towertype==3 then
            --print(rarity)
            towertypestring = "auxiliary"
        else
            --print(rarity)
            towertypestring = "control"
        end


        self:createCollectedItem(AtlasLayer,
                "ui/hall/Atlas/Subinterface_towerlist/bottomchart-tower-"..raritystring..".png",
                TowerString,
                "ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_"..towertypestring..".png",
                "ui/hall/Atlas/Subinterface_currentsquad/rank/lv.".."9"..".png",a,b)
        a=a+170
        if key%4 ==0 then
            a = 0
            b = b-250
        end
    end


    --     --循环
    --     local TowerString = Towerdata.OBTAINED[1]
    --     --print(TowerString)
    --     --print("图片数字"..(string.sub(Towerdata.OBTAINED[1],-6,-5)))
    --     -- print("稀有度"..TowerDef.RARITY.LEGEND)
    --     local chartnum = tonumber(string.sub(TowerString,-6,-5))
    --     local rarity = TowerDef.TABLE[chartnum].RARITY
    --     local raritystring
    --     if rarity == 1 then
    --         --print(rarity)
    --         raritystring = "common"
    --     elseif rarity ==2 then
    --         --print(rarity)
    --         raritystring = "rare"
    --     elseif rarity==3 then
    --         --print(rarity)
    --         raritystring = "epic"
    --     else
    --         --print(rarity)
    --         raritystring = "legend"
    --     end

    --     local towertype = TowerDef.TABLE[chartnum].TYPE
    --     local towertypestring
    --     if towertype == 1 then
    --         --print(rarity)
    --         towertypestring = "attack"
    --     elseif towertype ==2 then
    --         --print(rarity)
    --         towertypestring = "disturb"
    --     elseif towertype==3 then
    --         --print(rarity)
    --         towertypestring = "auxiliary"
    --     else
    --         --print(rarity)
    --         towertypestring = "control"
    --     end



    --     self:createCollectedItem(AtlasLayer,
    --     "ui/hall/Atlas/Subinterface_towerlist/bottomchart-tower-"..raritystring..".png",
    --     TowerString,
    --     "ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_"..towertypestring..".png",
    --     "ui/hall/Atlas/Subinterface_currentsquad/rank/lv.".."9"..".png",170,-700)

    -- self:createCollectedItem(AtlasLayer,"ui/hall/Atlas/Subinterface_towerlist/bottomchart-tower-rare.png"
    -- ,"ui/hall/common/Tower-Icon/05.png","ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_attack.png",
    -- "ui/hall/Atlas/Subinterface_currentsquad/rank/lv.9.png",0,-700)




    --未收集
    local notcollectedimage=ccui.ImageView:create("ui/hall/Atlas/Subinterface_towerlist/splitline_notcollected.png")
    notcollectedimage:setScale(1)
    notcollectedimage:setAnchorPoint(0,1)
    notcollectedimage:pos(0,height-1200+120)
    notcollectedimage:addTo(AtlasLayer)

    self:createTroopPanel(AtlasLayer)
    return AtlasLayer

end

--二级页面（使用）
function Atlas:towerusingPanel(layer,bg)
    local width ,height = display.width,display.height
    --层：灰色背景
    local towerusingLayer = ccui.Layout:create()
    towerusingLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    towerusingLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    towerusingLayer:setBackGroundColorOpacity(128)--设置透明度
    towerusingLayer:setContentSize(width, height)
    towerusingLayer:pos(width*0.5, height *0.5)
    towerusingLayer:setAnchorPoint(0.5, 0.5)
    towerusingLayer:addTo(layer)
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
function Atlas:towerinfoPanel(layer,path,bg,towertype,rank)--稀有度背景，图片路径，塔类型，卡等级
    local width ,height = display.width,display.height
    --层：灰色背景
    local towerinfoLayer = ccui.Layout:create()
    towerinfoLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    towerinfoLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    towerinfoLayer:setBackGroundColorOpacity(128)--设置透明度
    towerinfoLayer:setContentSize(width, height)

    --随着滑动的位置而改变
    if layer:getPositionY() == 0 then
        towerinfoLayer:pos(width/2, height/2)
    else
        towerinfoLayer:pos(width/2, height/2-370)
    end

    --towerinfoLayer:pos(width*0.5, height *0.5)
    towerinfoLayer:setAnchorPoint(0.5, 0.5)
    towerinfoLayer:addTo(layer)
    towerinfoLayer:setTouchEnabled(true)--屏蔽一级界面


    --     local TowerString = Towerdata.OBTAINED[1]
    --     --print(TowerString)
    --     --print("图片数字"..(string.sub(Towerdata.OBTAINED[1],-6,-5)))
    --     -- print("稀有度"..TowerDef.RARITY.LEGEND)
    --     local chartnum = tonumber(string.sub(TowerString,-6,-5))
    --     local rarity = TowerDef.TABLE[chartnum].RARITY
    --     local raritystring
    local TowerString = bg
    local chartnum = tonumber(string.sub(TowerString,-6,-5))

    local rarity = TowerDef.TABLE[chartnum].RARITY

    local raritystring  --稀有度
    if rarity == 1 then
        --print(rarity)
        raritystring = "普通"
    elseif rarity ==2 then
        --print(rarity)
        raritystring = "稀有"
    elseif rarity==3 then
        --print(rarity)
        raritystring = "史诗"
    else
        --print(rarity)
        raritystring = "传说"
    end

    local skillinfo = TowerDef.TABLE[chartnum].INFORMATION --技能介绍

    local towertype = TowerDef.TABLE[chartnum].TYPE
    local towertypestring  --类型
    if towertype == 1 then
        --print(rarity)
        towertypestring = "攻击向"
    elseif towertype ==2 then
        --print(rarity)
        towertypestring = "干扰向"
    elseif towertype==3 then
        --print(rarity)
        towertypestring = "辅助向"
    else
        --print(rarity)
        towertypestring = "控制向"
    end
    --local atk = KnapsackData:getatk(chartnum)
    local atk = TowerDef.TABLE[chartnum].ATK  --攻击力
    local speed = TowerDef.TABLE[chartnum].FIRECD  --攻速
    local target = TowerDef.TABLE[chartnum].MODE
    local targetstring  --目标
    if target == 1 then
        --print(rarity)
        targetstring = "前方"
    elseif target ==2 then
        --print(rarity)
        targetstring = "最大生命"
    else
        --print(rarity)
        targetstring = "随机"
    end



    --图片：弹窗背景
    local popLayer = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/buttomchart_pop_up_windows.png")
    popLayer:pos(display.cx, display.cy+100)
    popLayer:setAnchorPoint(0.5, 0.5)
    popLayer:addTo(towerinfoLayer)



    --图片：稀有度框框
    local ItemBg =ccui.ImageView:create(path)
    ItemBg:setScale(1)
    ItemBg:setPosition(cc.p(120, 685))
    ItemBg:addTo(popLayer)

    --塔
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
    local rarelabel=cc.Label:createWithTTF(raritystring,"ui/font/fzzdhjw.ttf",34)
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
    local skillinfolabel=cc.Label:createWithTTF(skillinfo,"ui/font/fzzdhjw.ttf",20)
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
    local type1label=cc.Label:createWithTTF(towertypestring,"ui/font/fzzdhjw.ttf",26)
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

    type2label=cc.Label:createWithTTF(KnapsackData:getatk(chartnum),"ui/font/fzzdhjw.ttf",26)
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
    local type3label=cc.Label:createWithTTF(speed.."s","ui/font/fzzdhjw.ttf",26)
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
    local type4label=cc.Label:createWithTTF(targetstring ,"ui/font/fzzdhjw.ttf",26)
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


    --按钮：升级按钮------------------------------------------------------------------
    local upgradeButton = ccui.Button:create(
            "ui/hall/Atlas/Secondaryinterface_towerinfo/button_upgrade.png",
            "ui/hall/Atlas/Secondaryinterface_towerinfo/button_upgrade.png",
            "ui/hall/Atlas/Secondaryinterface_towerinfo/button_upgrade.png")
    -- local updatelabel
    upgradeButton:setPosition(cc.p(320, 110))
    upgradeButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then

            updatelabel=cc.Label:createWithTTF("+"..TowerDef.TABLE[chartnum].ATK_UPGRADE,"ui/font/fzzdhjw.ttf",26)
            updatelabel:setScale(1)
            updatelabel:setColor(cc.c3b(255, 255, 255))
            updatelabel:setAnchorPoint(0,1)
            updatelabel:pos(0+495,460)
            updatelabel:enableOutline(cc.c4b(20, 20, 66, 255),2)
            updatelabel:addTo(popLayer)




            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        elseif eventType == ccui.TouchEventType.ended then
            



            KnapsackData:uplevel(chartnum)            
            Atlas:setATKString(KnapsackData:getatk(chartnum))
            Atlas:setCOINString(KnapsackData:getupgradecoin(chartnum))

            updatelabel:setVisible(false)

            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        elseif eventType == ccui.TouchEventType.canceled then

            updatelabel:setVisible(false)

            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.moved then
            --Atlas:setCOINString(KnapsackData:getupgradecoin(chartnum))
        end
    end)
    upgradeButton:addTo(popLayer)

    local coin_icon = ccui.ImageView:create("ui/hall/Atlas/Secondaryinterface_towerinfo/icon_coin.png")
    coin_icon:setScale(1)
    coin_icon:setPosition(cc.p(50, 30))
    coin_icon:addTo(upgradeButton)
    
    local coinnum
    if rarity == 1 then
        coinnum = 5
    elseif rarity ==2 then
        coinnum = 50
    elseif rarity ==3 then
        coinnum = 400
    else
        coinnum =8000
    end
    coin_label=cc.Label:createWithTTF(KnapsackData:getupgradecoin(chartnum),"ui/font/fzbiaozjw.ttf",24)
    coin_label:setScale(1)
    coin_label:setColor(cc.c3b(255, 255, 255))
    coin_label:setPosition(cc.p(110, 30))
    coin_label:enableOutline(cc.c4b(0, 0, 0, 255),2)
    coin_label:addTo(upgradeButton)





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
function Atlas:createCollectedItem(layer,path,bg,towertype,rank,offsetX,offsetY)--层级、稀有度背景、图片路径、塔种类、等级、偏移量

    --按钮：商品1
    local ItemButton = ccui.Button:create(path, path, path)
    ItemButton:setPosition(cc.p(100+offsetX, display.top-340+offsetY+120))
    ItemButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.ended then
            self:towerinfoPanel(layer,path,bg,towertype,rank)
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
function Atlas:createTroopPanel(layer)
    local width,height = display.width,display.top
    --当前阵容底图
    local currenttroop=ccui.ImageView:create("ui/hall/Atlas/Subinterface_currentsquad/bottomchart_title.png")
    currenttroop:setScale(1)
    currenttroop:setAnchorPoint(0,1)
    currenttroop:pos(0+35,height-50)
    currenttroop:addTo(layer)

    local currenttroopblack=ccui.ImageView:create("ui/hall/Atlas/Subinterface_currentsquad/bottomchart_area.png")
    currenttroopblack:setScale(1)
    currenttroopblack:setAnchorPoint(0,1)
    currenttroopblack:pos(0+35,height-135)
    currenttroopblack:addTo(layer)
    --当前阵容文字
    local trooplabel=cc.Label:createWithTTF("当前阵容","ui/font/fzbiaozjw.ttf",40)
    trooplabel:setAnchorPoint(0,1)
    trooplabel:pos(0+200,height-70)
    trooplabel:addTo(layer)

    self:createTroopItem(layer,"ui/hall/common/Tower-Icon/01.png"
    ,"ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_disturb.png","ui/hall/Atlas/Subinterface_currentsquad/rank/lv.13.png",0,0)
    self:createTroopItem(layer,"ui/hall/common/Tower-Icon/06.png"
    ,"ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_attack.png","ui/hall/Atlas/Subinterface_currentsquad/rank/lv.12.png",130,0)
    self:createTroopItem(layer,"ui/hall/common/Tower-Icon/08.png"
    ,"ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_attack.png","ui/hall/Atlas/Subinterface_currentsquad/rank/lv.11.png",130+130,0)
    self:createTroopItem(layer,"ui/hall/common/Tower-Icon/09.png"
    ,"ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_attack.png","ui/hall/Atlas/Subinterface_currentsquad/rank/lv.8.png",130*3,0)
    self:createTroopItem(layer,"ui/hall/common/Tower-Icon/07.png"
    ,"ui/hall/Atlas/Secondaryinterface_towerinfo/towertype_attack.png","ui/hall/Atlas/Subinterface_currentsquad/rank/lv.9.png",130*4,0)

end


--阵容按钮
function Atlas:createTroopItem(layer,path,towertype,rank,offsetX,offsetY)--层级、图片路径、碎片数量、价格、偏移量

    --按钮：商品1
    local ItemButton = ccui.Button:create(path, path, path)
    ItemButton:setPosition(cc.p(100+offsetX, display.top-340+offsetY+120))
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


function Atlas:onEnter()
end

function Atlas:onExit()
end

return Atlas
