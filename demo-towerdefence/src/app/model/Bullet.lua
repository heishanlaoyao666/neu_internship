--[[--
    Bullet.lua

    描述：子弹基类
]]
local Bullet = class("Bullet")
local Log = require("app.util.Log")

--[[--
    描述：构造函数

    @param id 类型：number，对象id
    @param bulletId 类型：number，子弹类型id
    @param towerId 类型：number，发射子弹的塔id
    @param enemyId 类型：number，射向的敌人id

    @return none
]]
function Bullet:ctor(id, bulletId, towerId, enemyId)
    self.id_ = id -- 类型：number，对象id
    self.bulletId_ = bulletId -- 类型：number，子弹种类id
    self.towerId_ = towerId -- 类型：number，发射子弹的塔id
    self.enemyId_ = enemyId -- 类型：number，要射击的敌人id
end

return Bullet