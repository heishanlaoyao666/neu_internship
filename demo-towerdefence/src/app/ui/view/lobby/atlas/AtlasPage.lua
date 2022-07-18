--[[--
    AtlasPage.lua

    描述：图鉴界面
]]
local AtlasPage = class("AtlasPage", require("app.ui.view.common.BasePage"))
local Log = require("app.util.Log")

local RES_DIR = "img/lobby/atlas/"

--[[--
    描述：构造函数

    @param none

    @return none
]]
function AtlasPage:ctor()
    AtlasPage.super.ctor(self)

    Log.d()
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function AtlasPage:onEnter()
    AtlasPage.super.onEnter(self)

    Log.d()

    self:setContentSize(cc.size(display.width, display.height))
    self:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    self:setPosition(0, 0)

    -- 初始化底图
    local bgSprite = display.newSprite(RES_DIR .. "bg.png", 0, 0)
    bgSprite:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    bgSprite:setScaleX(display.scaleX)
    bgSprite:setScaleY(display.scaleY)
    self:addChild(bgSprite, -1)
end

return AtlasPage