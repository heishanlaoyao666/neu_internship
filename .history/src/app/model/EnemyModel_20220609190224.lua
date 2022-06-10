local EnemyModel = class("EnemyModel")

-- 构造函数
function EnemyModel:ctor(x)
    self.x = x
    self.y = ConstantsUtil.BORN_PLACE_ENEMY
end

return EnemyModel
