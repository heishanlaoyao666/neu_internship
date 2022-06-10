local PlaneModel = class("PlaneModel")

-- 构造函数
function PlaneModel:ctor()
    self.x = WinSize.width * ConstantsUtil.INIT_PLANE_X
    self.y = WinSize.height * ConstantsUtil.INIT_PLANE_Y
    self.hp = ConstantsUtil.DEFAULT_HP
    self.score = ConstantsUtil.DEFAULT_SCORE
end

function PlaneModel:data2Json()
    local planeModel = {
        x = self.x,
        y = self.y,
        hp = self.hp,
        score = self.score
    }
    return bulletModel
end

function PlaneModel:json2Data(bulletModel)
    self.x = bulletModel.x
    self.y = bulletModel.y
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
