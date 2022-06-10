local BulletModel = class("BulletModel")

-- 构造函数
function BulletModel:ctor(x, y)
    self.x = x
    self.y = y
end

function BulletModel:data2Json()
    local bulletModel = {
        x = self.x,
        y = self.y
    }
    return bulletModel
end

function BulletModel:json2Data(bulletModel)
    self.x = bulletModel.x
    self.y = bulletModel.y
end

return BulletModel
