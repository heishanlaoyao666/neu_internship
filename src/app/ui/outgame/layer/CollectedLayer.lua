--[[--
    已收集层
    CollectedLayer.lua
]]
local CollectedLayer = class("CollectedLayer", require("app.ui.outgame.layer.BaseLayer"))
local OutGameData = require("app.data.outgame.OutGameData")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
--[[--
    构造函数

    @param none

    @return none
]]
function CollectedLayer:ctor()
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function CollectedLayer:initView()
    local tempfilename
    local width, height = display.width, 1120
    -- self.container_2 = ccui.Layout:create()
    -- self.container_2:setContentSize(display.width, display.height)
    -- self:addChild(self.container_2)
    -- self.container_2:setPosition(0, 0)
    --

    self.collected1,self.collected2,self.collected3,self.collected4=OutGameData:getCollected()
    local num3={}
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
    print(#num3)
    --创建三个容器，分别装提示信息，已收集和未收集
    self.container_C2 = ccui.Layout:create()
    self.container_C2:setContentSize(width, 200+math.ceil(#num3/4)*250)
    self.container_C2:setAnchorPoint(0.5,0.5)
    self.container_C2:setPosition(display.cx, display.cy)
    self.container_C2:addTo(self)


    self.typefilename={"towertype_tapping","towertype_disturbance","towertype_sup","towertype_control"}
    --已收集,一行占250
    if #num3==0 then
        --self.container_C3:setContentSize(width, 450+math.ceil(#num4/4+1)*250)
    else
        for i=1,#num3 do
            tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_list/basemap_towernomal.png"
            local spriteC17 =ccui.Button:create(tempfilename)
            self.container_C2:addChild(spriteC17)
            spriteC17:setAnchorPoint(0.5, 0)
            if i%4==0 then
                spriteC17:setPosition(100+width*3/4,100+math.ceil(#num3/4)*250-math.ceil(i/4)*250)
            else
                spriteC17:setPosition(100+width*(i%4-1)/4,100+math.ceil(#num3/4)*250-math.ceil(i/4)*250)
            end
            local spriteD6 = display.newSprite(string.format("artcontent/lobby(ongame)/currency/icon_tower/%02d.png",
            num3[i]:getTower():getTowerId()))
            spriteC17:addChild(spriteD6)
            spriteD6:setAnchorPoint(0.5, 0.5)
            spriteD6:setPosition(spriteC17:getContentSize().width/2,spriteC17:getContentSize().height/2+30)
            local spriteD7 = display.
            newSprite(string.format("artcontent/lobby(ongame)/atlas_interface/tower_list/grade/Lv.%d.png",
            num3[i]:getTower():getLevel()))
            spriteC17:addChild(spriteD7)
            spriteD7:setAnchorPoint(0.5, 0.5)
            spriteD7:setPosition(spriteC17:getContentSize().width/2,spriteC17:getContentSize().height/2-40)
            tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_list/progressbar_basemap_fragmentsnumber.png"
            local spriteD8 = display.newSprite(tempfilename)
            spriteC17:addChild(spriteD8)
            spriteD8:setAnchorPoint(0.5, 0.5)
            spriteD8:setPosition(spriteC17:getContentSize().width/2,spriteC17:getContentSize().height/2-80)
            tempfilename="artcontent/lobby(ongame)/atlas_interface/tower_list/progress_progress_fragmentsnumber.png"
            local spriteD9= display.newSprite(tempfilename)
            spriteD8:addChild(spriteD9)
            spriteD9:setAnchorPoint(0.5, 0.5)
            spriteD9:setPosition(spriteD8:getContentSize().width/2,spriteD8:getContentSize().height/2)
            local spriteD10 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/tower_list/"..
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
    local spriteC9 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/tower_list/split_collected.png")
    self.container_C2:addChild(spriteC9)
    spriteC9:setAnchorPoint(0.5, 0)
    spriteC9:setPosition(display.cx,100+math.ceil(#num3/4)*250)--math.ceil()向正无穷取整

end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function CollectedLayer:update(dt)
end

return CollectedLayer