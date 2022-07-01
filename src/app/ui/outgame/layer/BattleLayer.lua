--[[--
    战斗层
    BattleLayer
]]
local BattleLayer = class("BattleLayer", function()
    return display.newLayer()
end)
local EventDef = require("app.def.outgame.EventDef")
local EventManager = require("app.manager.EventManager")
--[[--
    构造函数

    @param none

    @return none
]]
function BattleLayer:ctor()
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function BattleLayer:initView()
    local width, height = display.width, 1120
    --战斗界面（游戏外）
    self.container_ = ccui.Layout:create()
    self.container_:addTo(self)
    self.container_:setContentSize(display.width, height)
    self.container_:setPosition(0, 0)

    --底图
    local sprite = display.newSprite("artcontent/lobby(ongame)/battle_interface/basemap_interfaces.png")
    self.container_:addChild(sprite)
    sprite:setPosition(display.cx,display.cy)

    --对战模式按钮
    local button = ccui.Button:create("artcontent/lobby(ongame)/battle_interface/button_battlemode.png")
    self.container_:addChild(button)
    button:setAnchorPoint(0.5, 0.5)
    button:setPosition(width/2, height/2-30)
    button:addTouchEventListener(function(sender, eventType)
        -- ccui.TouchEventType
        if 2 == eventType then -- touch end
            -- body
            EventManager:doEvent(EventDef.ID.MATCH)
        end
    end)
    --已选队伍底图
    local sprite1 = display.newSprite("artcontent/lobby(ongame)/battle_interface/basemap_selectedteams.png")
    self.container_:addChild(sprite1)
    sprite1:setPosition(display.cx,200)

    --天梯背景和ListView创建
    local sprite2 = display.newSprite("artcontent/lobby(ongame)/battle_interface/rank/basemap_rank.png")
    self.container_:addChild(sprite2)
    sprite2:setPosition(display.cx,display.cy+300)
    self.listcontainer_ =ccui.Layout:create()
    self.listcontainer_:setContentSize(sprite2:getContentSize().width-100, sprite2:getContentSize().height)
    self.listcontainer_:setAnchorPoint(0.5,0.5)
    self.listcontainer_:setPosition(sprite2:getContentSize().width/2,sprite2:getContentSize().height/2)
    self.listcontainer_:addTo(sprite2)

    local listView = ccui.ListView:create()
    local listcontainerSize=self.listcontainer_:getContentSize()
    listView:setContentSize(listcontainerSize.width, listcontainerSize.height)
    listView:setAnchorPoint(0.5, 0.5)
    listView:setPosition(listcontainerSize.width/2,listcontainerSize.height/2+50)
    listView:setDirection(2)
    listView:addTo(self.listcontainer_)
    listView:setBounceEnabled(true)
    self.imgstatus={}
    for i=1,20 do
        self.imgstatus[i]=1
    end
    for i=1,20 do
        self.imgcontainer_ =ccui.Layout:create()
        local img = ccui.Button:create("artcontent/lobby(ongame)/battle_interface/rank/locked_blueborder.png")
        img:setAnchorPoint(0,0.5)
        img:setPosition(50,img:getContentSize().height/2)
        self.imgcontainer_:addChild(img)
        self.imgcontainer_:setContentSize(img:getContentSize().width+50,img:getContentSize().height)
        self.imgcontainer_:setAnchorPoint(0.5,0.5)
        self.imgcontainer_:setPosition(sprite2:getContentSize().width/2,sprite2:getContentSize().height/2+100)
        self.imgcontainer_:addTo(listView)
        self.spritelocked = display.newSprite("artcontent/lobby(ongame)/battle_interface/rank/locked.png")
        img:addChild(self.spritelocked)
        self.spritelocked:setAnchorPoint(0.5, 0)
        self.spritelocked:setPosition(img:getContentSize().width/2,-25)
        self.spritelocked:setVisible(true)
        self.spriteget = display.newSprite("artcontent/lobby(ongame)/battle_interface/rank/group130.png")
        img:addChild(self.spriteget)
        self.spriteget:setAnchorPoint(0.5, 0)
        self.spriteget:setPosition(img:getContentSize().width/2,-25)
        self.spriteget:setVisible(false)
        img:addTouchEventListener(function(sender, eventType)
            if 2 == eventType then -- touch end
                self.MatchLayer_=MatchLayer.new():addTo(self)
            end
        end)
        if self.imgstatus[i]==1 then
            --img:loadTextureNormal
        elseif self.imgstatus[i]==2 then
            local tempfilename="artcontent/lobby(ongame)/battle_interface/rank/unlocked_notclamide_yellowborder.png"
            img:loadTextureNormal(tempfilename)
            self.spritelocked:setVisible(false)
            img:addTouchEventListener(function(sender, eventType)
                if 2 == eventType then -- touch end
                    print(2)
                end
            end)
        else
            img:loadTextureNormal("artcontent/lobby(ongame)/battle_interface/rank/available.png")
            self.spritelocked:setVisible(false)
            self.spriteget:setVisible(true)
            img:addTouchEventListener(function(sender, eventType)
                if 2 == eventType then -- touch end
                    print(3)
                end
            end)
        end

    end
    --进度条背景
    local loadBarProBG = cc.Sprite:create("artcontent/lobby(ongame)/battle_interface/rank/sacle/scale_ruler.png")
    loadBarProBG:setScale(self.imgcontainer_:getContentSize().width*20/loadBarProBG:getContentSize().width,1)
    loadBarProBG:setAnchorPoint(0,0)
    loadBarProBG:pos(0, 0)
    listView:addChild(loadBarProBG)

   --进度条
   local tempfilename="artcontent/lobby(ongame)/battle_interface/rank/sacle/rectangle_1.png"
   self.loadBarPro_ = cc.ProgressTimer:create(cc.Sprite:create(tempfilename))
   self.loadBarPro_:setScale(14.3,1)
   self.loadBarPro_:setAnchorPoint(0, 0.5)
   self.loadBarPro_:setType(cc.PROGRESS_TIMER_TYPE_BAR)--从左到右
   self.loadBarPro_:setMidpoint(cc.p(0, 0))
   self.loadBarPro_:setBarChangeRate(cc.p(1, 0))
   self.loadBarPro_:pos(3, loadBarProBG:getContentSize().height/2+1)
   self.loadBarPro_:setPercentage(0)
   loadBarProBG:addChild(self.loadBarPro_)

   local spritekey = display.newSprite("artcontent/lobby(ongame)/battle_interface/rank/sacle/key.png")
   spritekey:setScale(loadBarProBG:getContentSize().width/self.imgcontainer_:getContentSize().width/20,1)
   loadBarProBG:addChild(spritekey)
   spritekey:setAnchorPoint(0, 0.5)
   spritekey:setPosition(0,loadBarProBG:getContentSize().height/2)

    for i=1,20 do
       local spritescale = display.newSprite("artcontent/lobby(ongame)/battle_interface/rank/sacle/scale.png")
       spritescale:setScale(loadBarProBG:getContentSize().width/self.imgcontainer_:getContentSize().width/20,1)
       loadBarProBG:addChild(spritescale)
       spritescale:setAnchorPoint(0, 0.5)
       spritescale:setPosition(3+(2*i-1)*(self.imgcontainer_:getContentSize().width/13-0.5),
       loadBarProBG:getContentSize().height/2)
    end

    self.progress=cc.UserDefault:getInstance():getIntegerForKey("奖杯数")*1.01/2000
    for i=1,20 do
        if i< (self.progress/50+1)/2 and self.imgstatus[i]==1 then
            self.imgstatus[i]=2
        end
    end

    if self.progress<1 then
        self.loadBarPro_:setPercentage(self.progress)
    else
        self.loadBarPro_:setPercentage(1)
    end

end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function BattleLayer:update(dt)
end

return BattleLayer

