--[[--
    PlayScene.lua

    描述：游戏场景类
]]
local PlayScene = class("PlayScene", require("app.ui.scene.BaseScene"))
local GameData = require("app.data.GameData")
local GameDef = require("app.def.GameDef")
local BottomInfoLayer = require("app.ui.view.play.BottomInfoLayer")
local CenterInfoLayer = require("app.ui.view.play.CenterInfoLayer")
local TopInfoLayer = require("app.ui.view.play.TopInfoLayer")
local BattleLayer = require("app.ui.view.play.BattleLayer")
local ResultLayer = require("app.ui.view.play.ResultLayer")
local SoundManager = require("app.manager.SoundManager")
local Log = require("app.util.Log")

local RES_DIR = "img/play/"

local ZORDER = {
    BG = -1, -- 背景层
    BATTLE = 0, -- 战斗层（棋盘、敌人）
    COVER = 1, -- 遮盖层（背景相关）
    INFO = 2, -- 信息层（上、中、下）
    ANIM = 3, -- 动画层
    RESULT = 4, -- 结算层
}

--[[--
    描述：构造函数

    @param ...

    @return none
]]
function PlayScene:ctor(...)
    PlayScene.super.ctor(self, ...)

    Log.d()

    self.myBattleLayer_ = nil -- 类型：BattleLayer，我的战斗层
end

--[[--
    描述：场景进入

    @param none

    @return none
]]
function PlayScene:onEnter()
    PlayScene.super.onEnter(self)

    Log.d()

    -- 初始化底图
    local bgSprite = display.newSprite(RES_DIR .. "bg.png", display.cx, display.cy)
    bgSprite:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
    bgSprite:setScale(display.scale)
    self:addChild(bgSprite, ZORDER.BG)

    -- 初始化遮盖
    local aboveSprite = display.newSprite(RES_DIR .. "bg_above.png", display.cx, display.cy)
    aboveSprite:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
    aboveSprite:setScale(display.scale)
    self:addChild(aboveSprite, ZORDER.COVER)

    -- 初始化我的战斗层
    self.myBattleLayer_ = BattleLayer.new(true)
    self:addChild(self.myBattleLayer_, ZORDER.BATTLE)

    -- TODO 初始化对手战斗层

    -- 初始化顶部信息层
    local topInfoLayer = TopInfoLayer.new()
    self:addChild(topInfoLayer, ZORDER.INFO)

    -- 初始化中部信息层
    local centerInfoLayer = CenterInfoLayer.new()
    self:addChild(centerInfoLayer, ZORDER.INFO)

    -- 初始化底部信息层
    local bottomInfoLayer = BottomInfoLayer.new()
    self:addChild(bottomInfoLayer, ZORDER.INFO)

    self:setUpdateEnable(true)
end

--[[--
    2dx 中 scene 的生命周期，由 2dx 回调 onEnterTransitionFinish
    @param none

    @return none
]]
function PlayScene:onEnterTransitionFinish()
    PlayScene.super.onEnterTransitionFinish(self)

    Log.d()

    SoundManager:playBGM(SoundManager.DEF.BGM.PLAY)
end

--[[--
    描述：帧刷新

    @param dt 类型：number，帧刷新间隔，单位：毫秒

    @return none
]]
function PlayScene:onUpdate(dt)
    if GameData.state_ ~= GameDef.STATE.PLAY then
        return
    end

    self.myBattleLayer_:onUpdate(dt)
end

--[[--
    描述：展示结算

    @param none

    @return none
]]
function PlayScene:showResult()
    Log.d()

    local resultLayer = ResultLayer.new()
    self:addChild(resultLayer, ZORDER.RESULT)
    resultLayer:show()
end

return PlayScene