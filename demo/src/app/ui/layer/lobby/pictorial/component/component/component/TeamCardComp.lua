--[[
    TeamCardComp.lua
    队伍卡片组件
    描述：队伍卡片组件
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local TeamCardComp = class("TeamCardComp", require("app.ui.layer.BaseUILayout"))
local ConstDef = require("app.def.ConstDef")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")

--[[--
    构造函数

    @param card 类型：CardBase，卡片

    @return none
]]
function TeamCardComp:ctor(card)
    TeamCardComp.super.ctor(self)

    self.container_ = nil
    self.sprite_ = nil
    self.level_ = nil
    self.attr_ = nil

    self:initParam(card)
    self:initView()
end

--[[--
    参数初始化 类型：CardBase，卡片

    @param none

    @return none
]]
function TeamCardComp:initParam(card)
    self.card_ = card

    self.tag_ = self.card_:getId()
end


--[[--
    界面初始化

    @param none

    @return none
]]
function TeamCardComp:initView()

    local width, height = 1.2*ConstDef.CARD_SIZE.TYPE_1.WIDTH, ConstDef.CARD_SIZE.TYPE_1.HEIGHT
    self:setContentSize(width, height)

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(width, height)
    self:addChild(self.container_)


    self.sprite_ = ccui.ImageView:create(self.card_:getSmallColorSpriteImg())
    self.sprite_:setPosition(width * 0.5, height * 0.6)
    self.container_:addChild(self.sprite_)

    self.level_ = ccui.ImageView:create(self.card_:getLevelImg())
    self.level_:setPosition(width * 0.5, height * 0.1)
    self.container_:addChild(self.level_)

    self.attr_ = ccui.ImageView:create(self.card_:getTypeImg())
    self.attr_:setPosition(width * 0.8, height * 0.9)
    self.container_:addChild(self.attr_)

end

--[[--
    onEnter事件

    @param none

    @return none
]]
function TeamCardComp:onEnter()
    EventManager:regListener(EventDef.ID.INIT_PLAYER_DATA, self, function()
        self:update()
    end)
    EventManager:regListener(EventDef.ID.CARD_UPGRADE, self, function(tag)
        if self.tag_ == tag then
            self:update()
        end
    end)
end

--[[--
    onExit事件

    @param none

    @return none
]]
function TeamCardComp:onExit()
    EventManager:unRegListener(EventDef.ID.INIT_PLAYER_DATA, self)
    EventManager:unRegListener(EventDef.ID.CARD_UPGRADE, self)
end

--[[--
    界面初始化

    @param none

    @return none
]]
function TeamCardComp:update()
    -- 更新视图
    self.level_:loadTexture(self.card_:getLevelImg())
end

return TeamCardComp