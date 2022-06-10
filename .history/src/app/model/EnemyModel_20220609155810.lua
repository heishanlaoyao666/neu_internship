local EnemyModel = class("EnemyModel")

-- 构造函数
function EnemyModel:ctor(x, y)
    self.x = x
    self.y = y
end

return EnemyModel
