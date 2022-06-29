--[[--
    BaseLayer.lua
    Layer基类
]]
local KnapsackLayer = class("KnapsackLayer", function()
    return display.newLayer()
end)
local OutGameData = require("src\\app\\data\\outgame\\OutGameData.lua")
local EventDef = require("src\\app\\def\\outgame\\EventDef.lua")
local EventManager = require("app.manager.EventManager")
local IntensifiesLayer = require("src\\app\\ui\\outgame\\layer\\IntensifiesLayer.lua")
--[[--
    构造函数

    @param none

    @return none
]]
function KnapsackLayer:ctor()
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function KnapsackLayer:initView()
    local width, height = display.width, 1120
    self.container_2 = ccui.Layout:create()
    self.container_2:setContentSize(display.width, display.height)
    self:addChild(self.container_2)
    self.container_2:setPosition(0, 0)
    local spriteC = display.newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\basemap_guide.png")
    self.container_2:addChild(spriteC)
    spriteC:setAnchorPoint(0.5, 0.5)
    spriteC:setPosition(display.cx,display.cy)
    local spriteC7 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\basemap_area.png")
    self.container_2:addChild(spriteC7)
    spriteC7:setAnchorPoint(0.5, 1)
    spriteC7:setPosition(display.cx,height-150)

    local spriteC1 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\basemap_title.png")
    self.container_2:addChild(spriteC1)
    spriteC1:setAnchorPoint(0.5, 1)
    spriteC1:setPosition(display.cx,height-80)

    local spriteC2 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\text_currentlineup.png")
    self.container_2:addChild(spriteC2)
    spriteC2:setAnchorPoint(0.5, 1)
    spriteC2:setPosition(display.cx-110,height-100)

    local spriteC3 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\basemap_lineupconnection.png")
    self.container_2:addChild(spriteC3)
    spriteC3:setAnchorPoint(0.5, 1)
    spriteC3:setPosition(display.cx+80,height-110)

    local landscapeCheckBox1 = ccui.CheckBox:
    create("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\icon_unchecked.png",
    nil, "res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\icon_checked.png", nil, nil)
    :align(display.LEFT_CENTER, -20, spriteC3:getContentSize().height/2)
    :addTo(spriteC3)

    local landscapeCheckBox2 = ccui.CheckBox:
    create("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\icon_unchecked.png",
    nil, "res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\icon_checked.png", nil, nil)
    :align(display.LEFT_CENTER, spriteC3:getContentSize().width/2-20, spriteC3:getContentSize().height/2)
    :addTo(spriteC3)

    local landscapeCheckBox3 = ccui.CheckBox:
    create("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\icon_unchecked.png",
    nil, "res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\icon_checked.png", nil, nil)
    :align(display.LEFT_CENTER, spriteC3:getContentSize().width-20, spriteC3:getContentSize().height/2)
    :addTo(spriteC3)

    local spriteC4 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\number_1.png")
    landscapeCheckBox1:addChild(spriteC4)
    spriteC4:setAnchorPoint(0.5, 0.5)
    spriteC4:setPosition(landscapeCheckBox1:getContentSize().width/2,landscapeCheckBox1:getContentSize().height/2)

    local spriteC5 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\number_2.png")
    landscapeCheckBox2:addChild(spriteC5)
    spriteC5:setAnchorPoint(0.5, 0.5)
    spriteC5:setPosition(landscapeCheckBox2:getContentSize().width/2,landscapeCheckBox2:getContentSize().height/2)

    local spriteC6 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\number_3.png")
    landscapeCheckBox3:addChild(spriteC6)
    spriteC6:setAnchorPoint(0.5, 0.5)
    spriteC6:setPosition(landscapeCheckBox3:getContentSize().width/2,landscapeCheckBox3:getContentSize().height/2)

    local listViewC = ccui.ListView:create()
    listViewC:setContentSize(display.width, height)
    listViewC:setAnchorPoint(0.5, 1)
    listViewC:setPosition(display.cx,height-353)
    listViewC:setDirection(1)
    listViewC:addTo(self.container_2)
    self.container_C1 = ccui.Layout:create()
    -- self.container_C1:setBackGroundColor(cc.c3b(200, 0, 0))
    -- self.container_C1:setBackGroundColorType(1)
    self.container_C1:setContentSize(width, 150)
    self.container_C1:setAnchorPoint(0.5,0.5)
    self.container_C1:setPosition(display.cx, display.cy)
    self.container_C1:addTo(listViewC)
    --提示信息
    local spriteC8 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\prompt_information\\basemap_tips.png")
    self.container_C1:addChild(spriteC8)
    spriteC8:setAnchorPoint(0.5, 0)
    spriteC8:setPosition(display.cx,30)

    local spriteC10 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\prompt_information\\text_2.png")
    spriteC8:addChild(spriteC10)
    spriteC10:setAnchorPoint(0.5, 0.5)
    spriteC10:setPosition(spriteC8:getContentSize().width/2-50,spriteC8:getContentSize().height/2+20)

    local spriteC11 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\prompt_information\\text_1.png")
    spriteC8:addChild(spriteC11)
    spriteC11:setAnchorPoint(0.5, 0.5)
    spriteC11:setPosition(spriteC8:getContentSize().width/2,spriteC8:getContentSize().height/2-20)
    self.collected1,self.collected2,self.collected3,self.collected4=OutGameData:getCollected()
    self.uncollected1,self.uncollected2,self.uncollected3,self.uncollected4=OutGameData:getUnCollected()
    local num1 = #self.collected1+#self.collected2+#self.collected3+#self.collected4
    local num2 = #self.uncollected1+#self.uncollected2+#self.uncollected3+#self.uncollected4
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
    print(#num3)
    print(#num4)
    --创建三个容器，分别装提示信息，已收集和未收集
    self.container_C2 = ccui.Layout:create()
    self.container_C2:setContentSize(width, 200+math.ceil(#num3/4)*250)
    self.container_C2:setAnchorPoint(0.5,0.5)
    self.container_C2:setPosition(display.cx, display.cy)
    self.container_C2:addTo(listViewC)

    self.container_C3 = ccui.Layout:create()
    self.container_C3:setContentSize(width, 450+math.ceil(#num4/4)*250)
    self.container_C3:setAnchorPoint(0.5,0.5)
    self.container_C3:setPosition(display.cx, display.cy)
    self.container_C3:addTo(listViewC)

    self.typefilename={"towertype_tapping","towertype_disturbance","towertype_sup","towertype_control"}
    --已收集,一行占250
    if #num3==0 then
        self.container_C3:setContentSize(width, 450+math.ceil(#num4/4+1)*250)
    else
        for i=1,#num3 do
            local spriteC17 =ccui.Button:
            create("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\basemap_towernomal.png")
            self.container_C2:addChild(spriteC17)
            spriteC17:setAnchorPoint(0.5, 0)
            if i%4==0 then
                spriteC17:setPosition(100+width*3/4,100+math.ceil(#num3/4)*250-math.ceil(i/4)*250)
            else
                spriteC17:setPosition(100+width*(i%4-1)/4,100+math.ceil(#num3/4)*250-math.ceil(i/4)*250)
            end
            local spriteD6 = display.
            newSprite(string.format("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\%02d.png",
            num3[i]:getTower():getTowerId()))
            spriteC17:addChild(spriteD6)
            spriteD6:setAnchorPoint(0.5, 0.5)
            spriteD6:setPosition(spriteC17:getContentSize().width/2,spriteC17:getContentSize().height/2+30)
            local spriteD7 = display.
            newSprite(string.format("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\grade\\Lv.%d.png",
            num3[i]:getTower():getLevel()))
            spriteC17:addChild(spriteD7)
            spriteD7:setAnchorPoint(0.5, 0.5)
            spriteD7:setPosition(spriteC17:getContentSize().width/2,spriteC17:getContentSize().height/2-40)
            local spriteD8 = display.
            newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\progressbar_basemap_fragmentsnumber.png")
            spriteC17:addChild(spriteD8)
            spriteD8:setAnchorPoint(0.5, 0.5)
            spriteD8:setPosition(spriteC17:getContentSize().width/2,spriteC17:getContentSize().height/2-80)
            local spriteD9= display.
            newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\progress_progress_fragmentsnumber.png")
            spriteD8:addChild(spriteD9)
            spriteD9:setAnchorPoint(0.5, 0.5)
            spriteD9:setPosition(spriteD8:getContentSize().width/2,spriteD8:getContentSize().height/2)
            local spriteD10 = display.
            newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\"..
            self.typefilename[num3[i]:getTower():getTowerType()]..".png")
            spriteC17:addChild(spriteD10)
            spriteD10:setAnchorPoint(1, 1)
            spriteD10:setPosition(spriteC17:getContentSize().width-10,spriteC17:getContentSize().height)
            spriteC17:addTouchEventListener(
                function(sender, eventType)
                    -- ccui.TouchEventType
                    if 2 == eventType then -- touch end
                        if cc.UserDefault:getInstance():getBoolForKey("音效") then
                            audio.playEffect("sounds/ui_btn_click.OGG",false)
                        end
                        EventManager:doEvent(EventDef.ID.INTENSIFIES,num3[i])
                    end
                end
            )
        end
    end
    local spriteC9 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\split_collected.png")
    self.container_C2:addChild(spriteC9)
    spriteC9:setAnchorPoint(0.5, 0)
    spriteC9:setPosition(display.cx,100+math.ceil(#num3/4)*250)--math.ceil()向正无穷取整
    if #num4==0 then
        --self.container_C3:setContentSize(width, 450+math.ceil(#num4/4+1)*250)
    else
        for i=1,#num4 do
            local spriteC16 = display.
            newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\basemap_towernomal.png")
            self.container_C3:addChild(spriteC16)
            spriteC16:setAnchorPoint(0.5, 0)
            if i%4==0 then
                spriteC16:setPosition(100+width*3/4,450+math.ceil(#num4/4)*250-math.ceil(i/4)*250)
            else
                spriteC16:setPosition(100+width*(i%4-1)/4,450+math.ceil(#num4/4)*250-math.ceil(i/4)*250)
            end
            local spriteD1 = display.
            newSprite(string.format("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\%02d.png",
            num4[i]:getTowerId()))
            spriteC16:addChild(spriteD1)
            spriteD1:setAnchorPoint(0.5, 0.5)
            spriteD1:setPosition(spriteC16:getContentSize().width/2,spriteC16:getContentSize().height/2+30)
            local spriteD2 = display.
            newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\grade\\Lv.1.png")
            spriteC16:addChild(spriteD2)
            spriteD2:setAnchorPoint(0.5, 0.5)
            spriteD2:setPosition(spriteC16:getContentSize().width/2,spriteC16:getContentSize().height/2-40)
            local spriteD3 = display.
            newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\progressbar_basemap_fragmentsnumber.png")
            spriteC16:addChild(spriteD3)
            spriteD3:setAnchorPoint(0.5, 0.5)
            spriteD3:setPosition(spriteC16:getContentSize().width/2,spriteC16:getContentSize().height/2-80)
            local spriteD4 = display.
            newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\progress_progress_fragmentsnumber.png")
            spriteD3:addChild(spriteD4)
            spriteD4:setAnchorPoint(0.5, 0.5)
            spriteD4:setPosition(spriteD3:getContentSize().width/2,spriteD3:getContentSize().height/2)
            local spriteD5 = display.
            newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\"..
            self.typefilename[num4[i]:getTowerType()]..".png")
            spriteC16:addChild(spriteD5)
            spriteD5:setAnchorPoint(1, 1)
            spriteD5:setPosition(spriteC16:getContentSize().width-10,spriteC16:getContentSize().height)
        end
    end
    local spriteC12 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\split_notcollected.png")
    self.container_C3:addChild(spriteC12)
    spriteC12:setAnchorPoint(0.5, 0)
    spriteC12:setPosition(display.cx,450+math.ceil(#num4/4)*250)
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function KnapsackLayer:update(dt)
end

return KnapsackLayer