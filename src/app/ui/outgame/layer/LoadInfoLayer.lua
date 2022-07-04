--[[--
    加载界面信息层
    LoadInfoLayer.lua
]]
local LoadInfoLayer = class("LoadInfoLayer", require("app.ui.outgame.layer.BaseLayer"))

local pro = 0

--[[--
    构造函数

    @param none

    @return none
]]
function LoadInfoLayer:ctor()
    LoadInfoLayer.super.ctor(self)

    --加载界面信息容器
    self.container_ = nil
    --提示信息
    self.tipLabelText_ = nil
    --加载进度
    self.proLabelText_ = nil
    --加载界面进度条
    self.loadBarPro_ = nil
    --加载界面进度
    self.pro_ = nil
    --加载界面进度条头部
    self.loadBarProHead_ = nil

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function LoadInfoLayer:initView()
    local width, height = display.width, 40
    self.pro = 0

    --容器
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0)
    self.container_:setPosition(display.cx, display.bottom)

    --提示
    self.tipLabelText_ = ccui.Text:create("大厅预加载，进行中...", "artcontent/font.fzhz.ttf",30)
    self.tipLabelText_:setColor(cc.c3b(255, 255, 255))
    self.tipLabelText_:setAnchorPoint(0.5, 1)
    self.tipLabelText_:setPosition(display.cx, height)
    self.tipLabelText_:setScale(0.6)
    self.container_:addChild(self.tipLabelText_)

    --加载进度
    self.proLabelText_ = ccui.Text:create(tostring(self.pro).."%", "artcontent/font.fzhz.ttf",30)
    self.proLabelText_:setColor(cc.c3b(253, 239, 117))
    self.proLabelText_:setAnchorPoint(1, 1)
    self.proLabelText_:setPosition(width - 10, height)
    self.proLabelText_:setScale(0.6)
    self.container_:addChild(self.proLabelText_)

    --进度条背景
    local loadBarProBG = cc.Sprite:create("artcontent/load/progress_bar_underlay.png")
    --720/15 按比例拉伸
    loadBarProBG:setScale(720/15,1)
    loadBarProBG:setAnchorPoint(0.5,0)
    loadBarProBG:pos(display.cx, 0)
    self.container_:addChild(loadBarProBG)

    --进度条
    self.loadBarPro_ = cc.ProgressTimer:create(cc.Sprite:create("artcontent/load/progressbar_stretch.png"))
    self.loadBarPro_:setScale(720/15,1)
    self.loadBarPro_:setAnchorPoint(0, 0)
    self.loadBarPro_:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    self.loadBarPro_:setMidpoint(cc.p(0, 0))
    self.loadBarPro_:setBarChangeRate(cc.p(1, 0))
    self.loadBarPro_:pos(0, 0)
    self.loadBarPro_:setPercentage(0)
    self.container_:addChild(self.loadBarPro_)

    --进度条头部
    self.loadBarProHead_ = cc.Sprite:create("artcontent/load/progressbar_header.png")
    self.loadBarProHead_:setAnchorPoint(0, 0)
    self.loadBarProHead_:pos(720 * 0 / 100, 0)
    self.container_:addChild(self.loadBarProHead_)
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function LoadInfoLayer:update(dt)
    pro = pro + dt * 100
    pro = math.floor(pro)
    if pro >= 100 then
        pro = 100
    end
    self.proLabelText_:setString(tostring(pro).."%")
    self.loadBarPro_:setPercentage(pro)
    self.loadBarProHead_:pos(720 * pro/100, 0)
end

return LoadInfoLayer

