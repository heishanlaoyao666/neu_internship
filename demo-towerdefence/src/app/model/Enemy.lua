--[[--
    Enemy.lua

    描述：敌人基类
]]
local Enemy = class("Enemy")
local GameDef = require("app.def.GameDef")
local MathUtil = require("app.util.MathUtil")
local Log = require("app.util.Log")

-- 怪物行进路线，左、上、右
local LEFT_MILE = GameDef.HEIGHT - 60
local TOP_MILE = GameDef.WIDTH
local RIGHT_MILE = LEFT_MILE
local TOTAL_MILE = LEFT_MILE + TOP_MILE + RIGHT_MILE

--[[--
    描述：构造函数

    @param none

    @return none
]]
function Enemy:ctor()
    self.id_ = 0 -- 类型：number，对象id
    self.enemyId_ = 0 -- 类型：number，类型id
    self.blood_ = 0 -- 类型：number，血量
    self.mile_ = 0 -- 类型：number，里程

    self.targetX_ = 0 -- 类型：number，目标坐标x
    self.targetY_ = 0 -- 类型：number，目标坐标y
    self.x_ = 0 -- 类型：number，坐标x
    self.y_ = 0 -- 类型：number，坐标y
end

--[[--
    描述：设置里程

    @param mile 类型：number，服务器里程，需转换成本地坐标

    @return none
]]
function Enemy:setMile(mile)
    self.mile_ = mile

    local percent = mile / 100 -- 转换百分比
    local realMile = TOTAL_MILE * percent
    if realMile <= LEFT_MILE then
        -- 在左边
        self.targetX_ = 0
        self.targetY_ = realMile
    elseif realMile > LEFT_MILE and realMile <= (LEFT_MILE + TOP_MILE) then
        -- 在上边
        self.targetX_ = realMile - LEFT_MILE
        self.targetY_ = LEFT_MILE
    elseif realMile > (LEFT_MILE + TOP_MILE) then
        -- 在右边
        self.targetX_ = TOP_MILE
        self.targetY_ = RIGHT_MILE - (realMile - LEFT_MILE - TOP_MILE)
    end
end

--[[--
    描述：帧刷新

    @param dt 类型：number，帧刷新间隔，单位：毫秒

    @return none
]]
function Enemy:onUpdate(dt)
    local alpha = dt * 10
    self.x_ = MathUtil.lerp(self.x_, self.targetX_, alpha)
    self.y_ = MathUtil.lerp(self.y_, self.targetY_, alpha)
end

return Enemy