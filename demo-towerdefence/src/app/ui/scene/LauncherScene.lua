--[[--
    LauncherScene.lua

    描述：启动场景类
]]
local LauncherScene = class("LauncherScene", require("app.ui.scene.BaseScene"))
local SceneManager = require("app.manager.SceneManager")
local LoadingBar = require("app.ui.view.common.LoadingBar")
local SendMsg = require("app.msg.SendMsg")
local Log = require("app.util.Log")

local RES_DIR = "img/loading/"

--[[--
    描述：构造函数
    
    @param ...
    
    @return none
]]
function LauncherScene:ctor(...)
    LauncherScene.super.ctor(self, ...)

    self.loadingBar_ = nil -- 类型：LoadingBar，进度条，显示加载进度
    self.progressLabel_ = nil -- 类型：Label，进度文本
    self.progress_ = 0 -- 类型：number，加载进度
end

--[[--
    描述：场景进入

    @param none

    @return none
]]
function LauncherScene:onEnter()
    LauncherScene.super.onEnter(self)

    -- 初始化底图
    local bgSprite = display.newSprite(RES_DIR .. "bg.jpg")
    bgSprite:setAnchorPoint(display.ANCHOR_POINTS[display.BOTTOM_LEFT])
    bgSprite:setPosition(0, 0)
    bgSprite:setScaleX(display.scaleX)
    bgSprite:setScaleY(display.scaleY)
    self:addChild(bgSprite, -1)

    -- 初始化提示文本
    local text = "抵制不良游戏，拒绝盗版游戏。注意自我保护，谨防上当受骗。\n" ..
            "适度游戏益脑，沉迷游戏伤身。合理安排时间，享受健康生活。"
    local promptLabel = display.newTTFLabel({
        text = text,
        size = 20 * display.scale,
        font = "font/fzhz.ttf",
        color = display.COLOR_WHITE,
        align = cc.TEXT_ALIGNMENT_CENTER,
    })
    promptLabel:setAnchorPoint(0, 0)
    local labelX = (display.width - promptLabel:getContentSize().width) / 2
    promptLabel:setPosition(labelX, 35 * display.scale)
    self:addChild(promptLabel)

    -- 初始化进度条
    self.loadingBar_ = LoadingBar.new(720)
    self.loadingBar_:setPosition(0, 0)
    self.loadingBar_:setScaleX(display.scaleX)
    self.loadingBar_:setScaleY(display.scaleY)
    self:addChild(self.loadingBar_)

    -- 初始化进度文本
    self.progressLabel_ = display.newTTFLabel({
        text = "0%",
        size = 20 * display.scale,
        font = "font/fzhz.ttf",
        color = cc.c3b(253, 239, 117),
        align = cc.TEXT_ALIGNMENT_CENTER,
    })
    self.progressLabel_:setAnchorPoint(1, 0)
    self.progressLabel_:setPosition(display.right - 10 * display.scale, 25 * display.scale)
    self:addChild(self.progressLabel_)

    -- 启用帧刷新
    self:setUpdateEnable(true)

    -- 发起登录
end

--[[--
    描述：帧刷新

    @param dt 类型：number，帧刷新间隔，单位：秒

    @return none
]]
function LauncherScene:onUpdate(dt)
    -- 此处为假的进度加载，实际项目中应该做资源更新和资源预加载
    self.progress_ = self.progress_ + 2
    self.loadingBar_:setProgress(self.progress_)
    self.progressLabel_:setString(tostring(math.min(100, math.floor(self.progress_))) .. "%")

    if self.progress_ >= 100 then
        self:setUpdateEnable(false)

        SceneManager:changeScene({
            sceneId = SceneManager.DEF.ID.LOBBY,
            transitionType = "slideInR",
            transitionTime = 0.3,
        })
    end
end

return LauncherScene