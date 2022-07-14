--[[--
    底部信息层
    BottomInfoLayer.lua
]]
local BottomInfoLayer = class("BottomInfoLayer", require("app.ui.outgame.layer.BaseLayer"))
--[[--
    构造函数

    @param none

    @return none
]]
function BottomInfoLayer:ctor()
    BottomInfoLayer.super.ctor(self)

    self.container_ = nil -- 类型：Layout，控件容器

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function BottomInfoLayer:initView()
    local width, height = display.width, 80
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0)
    self.container_:setPosition(display.cx, 0)

    local unLeftImg = ccui.ImageView:create("artcontent/lobby(ongame)/bottombar_tabbutton/tab_unchecked_left.png")
    self.container_:addChild(unLeftImg)
    unLeftImg:setScale9Enabled(true)
    unLeftImg:setContentSize(cc.size(width/3, 120))
    unLeftImg:setAnchorPoint(0, 0)
    unLeftImg:setScale(1)
    unLeftImg:setPosition(0, 0)

    local unMediumImg = ccui.ImageView:create("artcontent/lobby(ongame)/bottombar_tabbutton/tab_unchecked_medium.png")
    self.container_:addChild(unMediumImg)
    unMediumImg:setScale9Enabled(true)
    unMediumImg:setContentSize(cc.size(width/3, 120))
    unMediumImg:setAnchorPoint(0, 0)
    unMediumImg:setScale(1)
    unMediumImg:setPosition(width/3, 0)

    local unRightImg = ccui.ImageView:create("artcontent/lobby(ongame)/bottombar_tabbutton/tab_unchecked_right.png")
    self.container_:addChild(unRightImg)
    unRightImg:setScale9Enabled(true)
    unRightImg:setContentSize(cc.size(width/3, 120))
    unRightImg:setAnchorPoint(0, 0)
    unRightImg:setScale(1)
    unRightImg:setPosition(width*2/3, 0)

    local selectedImg = ccui.ImageView:create("artcontent/lobby(ongame)/bottombar_tabbutton/tab_currently_selected.png")
    self.container_:addChild(selectedImg)
    selectedImg:setScale9Enabled(true)
    selectedImg:setContentSize(cc.size(width/3, 140))
    selectedImg:setAnchorPoint(0, 0)
    selectedImg:setScale(1)
    selectedImg:setPosition(width/3, 0)

    local iconAtlasImg = ccui.ImageView:create("artcontent/lobby(ongame)/bottombar_tabbutton/icon_atlas.png")
    self.container_:addChild(iconAtlasImg)
    iconAtlasImg:setAnchorPoint(0.5, 0)
    iconAtlasImg:setScale(1)
    iconAtlasImg:setPosition(120, 0)

    local titleAtlasImg = ccui.ImageView:create("artcontent/lobby(ongame)/bottombar_tabbutton/title_atlas.png")
    self.container_:addChild(titleAtlasImg)
    titleAtlasImg:setAnchorPoint(0.5, 0)
    titleAtlasImg:setPosition(120, 0)
    titleAtlasImg:setVisible(false)

    local iconBattleImg = ccui.ImageView:create("artcontent/lobby(ongame)/bottombar_tabbutton/icon_battle.png")
    self.container_:addChild(iconBattleImg)
    iconBattleImg:setAnchorPoint(0.5, 0)
    iconBattleImg:setScale(1)
    iconBattleImg:setPosition(width/3+120, 0)

    local titleBattleImg = ccui.ImageView:create("artcontent/lobby(ongame)/bottombar_tabbutton/title_battle.png")
    self.container_:addChild(titleBattleImg)
    titleBattleImg:setAnchorPoint(0.5, 0)
    titleBattleImg:setPosition(width/3+120, 0)
    titleBattleImg:setVisible(true)

    local iconStoreImg = ccui.ImageView:create("artcontent/lobby(ongame)/bottombar_tabbutton/icon_store.png")
    self.container_:addChild(iconStoreImg)
    iconStoreImg:setAnchorPoint(0.5, 0)
    iconStoreImg:setScale(1)
    iconStoreImg:setPosition(width*2/3+120, 0)

    local titleStoreImg = ccui.ImageView:create("artcontent/lobby(ongame)/bottombar_tabbutton/title_store.png")
    self.container_:addChild(titleStoreImg)
    titleStoreImg:setAnchorPoint(0.5, 0)
    titleStoreImg:setPosition(width*2/3+120, 0)
    titleStoreImg:setVisible(false)

    if cc.UserDefault:getInstance():getIntegerForKey("bottom")==1 then
        selectedImg:setPosition(0, 0)
        iconAtlasImg:setPositionY(20)
        titleAtlasImg:setVisible(true)
        iconBattleImg:setPositionY(0)
        titleBattleImg:setVisible(false)
        iconStoreImg:setPositionY(0)
        titleStoreImg:setVisible(false)
    elseif cc.UserDefault:getInstance():getIntegerForKey("bottom")==2 then
        selectedImg:setPosition(width/3, 0)
        iconAtlasImg:setPositionY(0)
        titleAtlasImg:setVisible(false)
        iconBattleImg:setPositionY(20)
        titleBattleImg:setVisible(true)
        iconStoreImg:setPositionY(0)
        titleStoreImg:setVisible(false)
    elseif cc.UserDefault:getInstance():getIntegerForKey("bottom")==3 then
        selectedImg:setPosition(width*2/3, 0)
        iconAtlasImg:setPositionY(0)
        titleAtlasImg:setVisible(false)
        iconBattleImg:setPositionY(0)
        titleBattleImg:setVisible(false)
        iconStoreImg:setPositionY(20)
        titleStoreImg:setVisible(true)
    end

end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function BottomInfoLayer:update(dt)

end

return BottomInfoLayer

