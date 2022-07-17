--[[
    SpriteLayer.lua
    精灵层
    描述：精灵层
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local SpriteLayer = class("SpriteLayer", require("app.ui.layer.BaseLayer"))
local GoldStoreComp = require("app.ui.layer.lobby.store.component.GoldStoreComp")
local DiamondStoreComp = require("app.ui.layer.lobby.store.component.DiamondStoreComp")
local ConstDef = require("app.def.ConstDef")


--[[--
    构造函数

    @param none

    @return none
]]
function SpriteLayer:ctor()
    SpriteLayer.super.ctor(self)

    self.container_ = nil
    self.goldStoreComp_ = nil
    self.diamondStoreComp_ = nil

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function SpriteLayer:initView()
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, display.cy)

    -- 主体ListView
    self.mainListView_ = ccui.ListView:create()
    self.mainListView_:setContentSize(ConstDef.WINDOW_SIZE.MAIN.WIDTH,
            ConstDef.WINDOW_SIZE.MAIN.HEIGHT)
    self.mainListView_:setAnchorPoint(0, -0.11)
    self.mainListView_:setDirection(1)
    self.container_:addChild(self.mainListView_)

    -- 金币商店
    local goldStoreBG = ccui.Layout:create()
    goldStoreBG:setContentSize(ConstDef.WINDOW_SIZE.GOLD_STORE.WIDTH,
            1.8*ConstDef.WINDOW_SIZE.GOLD_STORE.HEIGHT)
    self.mainListView_:pushBackCustomItem(goldStoreBG)

    self.goldStoreComp_ = GoldStoreComp.new()
    self.mainListView_:pushBackCustomItem(self.goldStoreComp_)

    -- 钻石商店
    local diamondStoreBG = ccui.Layout:create()
    diamondStoreBG:setContentSize(ConstDef.WINDOW_SIZE.DIAMOND_STORE.WIDTH,
            ConstDef.WINDOW_SIZE.DIAMOND_STORE.HEIGHT)
    self.mainListView_:pushBackCustomItem(diamondStoreBG)

    self.diamondStoreComp_ = DiamondStoreComp.new()
    self.mainListView_:pushBackCustomItem(self.diamondStoreComp_)

end

return SpriteLayer