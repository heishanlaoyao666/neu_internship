local EnemyModel = class("EnemyModel")

-- 构造函数
function EnemyModel:ctor(x, y)
    self.x = ConstantsUtil.BORN_PLACE_ENEMY
    self.y = y
end

return EnemyModel
