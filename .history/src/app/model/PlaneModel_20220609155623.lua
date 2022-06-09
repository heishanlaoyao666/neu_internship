local PlaneModel = class("PlaneModel")

-- 构造函数
function PlaneModel:ctor()
    self.x = ConstantsUtil.INIT_PLANE_X
    self.y = ConstantsUtil.INIT_PLANE_Y
    self.hp = ConstantsUtil.DEFAULT_HP
    self.score = ConstantsUtil.DEFAULT_SCORE
end

function PlaneModel:getX()
    return self.x
end

function PlaneModel:getY()
    return self.y
end

function PlaneModel:getHp()
    return self.hp
end

function PlaneModel:getScore()
    return self.score
end

function PlaneModel:setHp(val)
    self.hp = val
end

function PlaneModel:setScore(val)
    self.score = val
end

return PlaneModel
