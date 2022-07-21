--[[--
    背包层
    KnapsackLayer.lua
]]
local KnapsackLayer = class("KnapsackLayer", require("app.ui.outgame.layer.BaseLayer"))
local ConstDef = require("app.def.outgame.ConstDef")
local OutGameData = require("app.data.outgame.OutGameData")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local CurrentLineupLayer = require("app.ui.outgame.layer.CurrentLineupLayer")
local TipsLayer = require("app.ui.outgame.layer.TipsLayer")
local OutgameMsg = require("app.msg.OutgameMsg")
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
    local tempfilename
    local width, height = display.width, 1120
    self.container_2 = ccui.Layout:create()
    self.container_2:setContentSize(display.width, display.height)
    self:addChild(self.container_2)
    self.container_2:setPosition(0, 0)
    --底图
    local spriteC = display.newSprite("artcontent/lobby_ongame/atlas_interface/basemap_guide.png")
    self.container_2:addChild(spriteC)
    spriteC:setAnchorPoint(0.5, 0.5)
    spriteC:setPosition(display.cx,display.cy)

    --当前阵容
    CurrentLineupLayer:new():addTo(self.container_2)

    --
    local listViewC = ccui.ListView:create()
    listViewC:setContentSize(display.width, height)
    listViewC:setAnchorPoint(0.5, 1)
    listViewC:setPosition(display.cx,height-353)
    listViewC:setDirection(1)
    listViewC:addTo(self.container_2)
    --提示信息容器，提示信息在188行
    self.container_C1 = ccui.Layout:create()
    -- self.container_C1:setBackGroundColor(cc.c3b(200, 0, 0))
    -- self.container_C1:setBackGroundColorType(1)
    self.container_C1:setContentSize(width, 150)
    self.container_C1:setAnchorPoint(0.5,0.5)
    self.container_C1:setPosition(display.cx, display.cy)
    self.container_C1:addTo(listViewC)

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
    if cc.UserDefault:getInstance():getIntegerForKey("towerData")==2 then
        local data2={id={},num={},level={}}
        for i=1,#num3 do
            data2.id[i]=num3[i]:getTower():getTowerId()
            data2.num[i]=num3[i]:getTowerNumber()
            data2.level[i]=num3[i]:getTower():getLevel()
        end
        local account=cc.UserDefault:getInstance():getStringForKey("account")
        OutgameMsg:sendData(account,"towerData",data2)
    end
    print("已收集数："..#num3)
    print("未收集数："..#num4)
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

    self.typefilename={"artcontent/lobby_ongame/atlas_interface/tower_list/towertype_tapping.png",
    "artcontent/lobby_ongame/atlas_interface/tower_list/towertype_disturbance.png",
    "artcontent/lobby_ongame/atlas_interface/tower_list/towertype_sup.png",
    "artcontent/lobby_ongame/atlas_interface/tower_list/towertype_control.png"}
    --已收集,一行占250
    if #num3==0 then
        self.container_C3:setContentSize(width, 450+math.ceil(#num4/4+1)*250)
    else
        for i=1,#num3 do
            tempfilename="artcontent/lobby_ongame/atlas_interface/tower_list/basemap_towernomal.png"
            local level = num3[i]:getTower():getLevel() -- 当前塔的等级
            local rarity =num3[i]:getTower():getTowerRarity() -- 当前塔的稀有度
            local spriteC17 =ccui.Button:create(tempfilename)
            self.container_C2:addChild(spriteC17)
            spriteC17:setAnchorPoint(0.5, 0)
            if i%4==0 then
                spriteC17:setPosition(100+width*3/4,100+math.ceil(#num3/4)*250-math.ceil(i/4)*250)
            else
                spriteC17:setPosition(100+width*(i%4-1)/4,100+math.ceil(#num3/4)*250-math.ceil(i/4)*250)
            end
            local spriteD6 = display.newSprite(string.format("artcontent/lobby_ongame/currency/icon_tower/%02d.png",
            num3[i]:getTower():getTowerId()))
            spriteC17:addChild(spriteD6)
            spriteD6:setAnchorPoint(0.5, 0.5)
            spriteD6:setPosition(spriteC17:getContentSize().width/2,spriteC17:getContentSize().height/2+30)
            if rarity ==1 then
            elseif rarity ==2 and level==1 then
                for j=1,2 do
                    OutGameData:initLevelUp(num3[i])
                end
            elseif rarity ==3 and level==1 then
                for j=1,4 do
                    OutGameData:initLevelUp(num3[i])
                end
            elseif rarity ==4 and level==1 then
                for j=1,8 do
                    OutGameData:initLevelUp(num3[i])
                end
            end
            level = num3[i]:getTower():getLevel() -- 当前塔的等级
            local spriteD7 = display.
            newSprite(string.format("artcontent/lobby_ongame/atlas_interface/tower_list/grade/Lv.%d.png",
            level))
            spriteC17:addChild(spriteD7)
            spriteD7:setAnchorPoint(0.5, 0.5)
            spriteD7:setPosition(spriteC17:getContentSize().width/2,spriteC17:getContentSize().height/2-40)
            tempfilename="artcontent/lobby_ongame/atlas_interface/tower_list/progressbar_basemap_fragmentsnumber.png"
            local spriteD8 = display.newSprite(tempfilename)
            spriteC17:addChild(spriteD8)
            spriteD8:setAnchorPoint(0.5, 0.5)
            spriteD8:setPosition(spriteC17:getContentSize().width/2,spriteC17:getContentSize().height/2-80)
            tempfilename="artcontent/lobby_ongame/atlas_interface/tower_list/progress_progress_fragmentsnumber.png"
            local spriteD9= display.newSprite(tempfilename)
            spriteD8:addChild(spriteD9)
            spriteD9:setAnchorPoint(0.5, 0.5)
            spriteD9:setPosition(spriteD8:getContentSize().width/2,spriteD8:getContentSize().height/2)
            self.num=display.newTTFLabel({
                text = "0/1",
                size = 22,
                color = display.COLOR_WHITE
            })
            :align(display.CENTER, spriteD9:getContentSize().width/2,spriteD9:getContentSize().height/2)
            :addTo(spriteD9)
            self.num:setString(num3[i]:getTowerNumber().."/"..ConstDef.LEVEL_UP_NEED_CARD[level+1][rarity])
            local spriteD10 = display.newSprite(self.typefilename[num3[i]:getTower():getTowerType()])
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
    local spriteC9 = display.newSprite("artcontent/lobby_ongame/atlas_interface/tower_list/split_collected.png")
    self.container_C2:addChild(spriteC9)
    spriteC9:setAnchorPoint(0.5, 0)
    spriteC9:setPosition(display.cx,100+math.ceil(#num3/4)*250)--math.ceil()向正无穷取整

    --提示信息
    TipsLayer:new():addTo(self.container_C1)

    if #num4==0 then
        --self.container_C3:setContentSize(width, 450+math.ceil(#num4/4+1)*250)
    else
        for i=1,#num4 do
            tempfilename="artcontent/lobby_ongame/atlas_interface/tower_list/basemap_towernomal.png"
            local spriteC16 = display.newSprite(tempfilename)
            self.container_C3:addChild(spriteC16)
            spriteC16:setAnchorPoint(0.5, 0)
            if i%4==0 then
                spriteC16:setPosition(100+width*3/4,450+math.ceil(#num4/4)*250-math.ceil(i/4)*250)
            else
                spriteC16:setPosition(100+width*(i%4-1)/4,450+math.ceil(#num4/4)*250-math.ceil(i/4)*250)
            end
            tempfilename="artcontent/lobby_ongame/currency/icon_towergray/%d.png"
            local spriteD1 = display.newSprite(string.format(tempfilename,num4[i]:getTowerId()))
            spriteC16:addChild(spriteD1)
            spriteD1:setAnchorPoint(0.5, 0.5)
            spriteD1:setPosition(spriteC16:getContentSize().width/2,spriteC16:getContentSize().height/2+30)
            local spriteD2 = display.newSprite("artcontent/lobby_ongame/atlas_interface/tower_list/grade/Lv.1.png")
            spriteC16:addChild(spriteD2)
            spriteD2:setAnchorPoint(0.5, 0.5)
            spriteD2:setPosition(spriteC16:getContentSize().width/2,spriteC16:getContentSize().height/2-40)
            tempfilename="artcontent/lobby_ongame/atlas_interface/tower_list/progressbar_basemap_fragmentsnumber.png"
            local spriteD3 = display.newSprite(tempfilename)
            spriteC16:addChild(spriteD3)
            spriteD3:setAnchorPoint(0.5, 0.5)
            spriteD3:setPosition(spriteC16:getContentSize().width/2,spriteC16:getContentSize().height/2-80)
            tempfilename="artcontent/lobby_ongame/atlas_interface/tower_list/progress_progress_fragmentsnumber.png"
            local spriteD4 = display.newSprite(tempfilename)
            spriteD3:addChild(spriteD4)
            spriteD4:setAnchorPoint(0.5, 0.5)
            spriteD4:setPosition(spriteD3:getContentSize().width/2,spriteD3:getContentSize().height/2)
            local spriteD5 = display.newSprite(self.typefilename[num4[i]:getTowerType()])
            spriteC16:addChild(spriteD5)
            spriteD5:setAnchorPoint(1, 1)
            spriteD5:setPosition(spriteC16:getContentSize().width-10,spriteC16:getContentSize().height)
        end
    end
    local spriteC12 = display.newSprite("artcontent/lobby_ongame/atlas_interface/tower_list/split_notcollected.png")
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