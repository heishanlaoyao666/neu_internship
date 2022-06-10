local EnemyModel = class("EnemyModel")

-- 构造函数
function EnemyModel:ctor(x)
    self.x = x
    self.y = ConstantsUtil.BORN_PLACE_ENEMY * WinSize.height
end

function EnemyModel:data2Json()
    local enemyModel = {
        x = self.x,
        y = self.y
    }
    return enemyModel
end

function EnemyModel:json2Data(enemyModel)
    self.x = enemyModel.x
    self.y = enemyModel.y
end

return EnemyModel
