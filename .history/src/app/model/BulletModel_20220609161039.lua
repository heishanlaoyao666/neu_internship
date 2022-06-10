local BulletModel = class("BulletModel")

-- 构造函数
function BulletModel:ctor(x, y)
    self.x = x
    self.y = y
end
 -- 每帧刷新一次
bullet:scheduleUpdateWithPriorityLua(bulletMove, 0)
table.insert(ConstantsUtil.bulletArray, bullet)

return BulletModel
