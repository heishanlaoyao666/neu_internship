local PlaneModel = class("PlaneModel")

-- 构造函数
function PlaneModel:ctor()
    self.x = ConstantsUtil.INIT_PLANE_X
    self.y = ConstantsUtil.INIT_PLANE_Y
    self.hp = ConstantsUtil.DEFAULT_HP
    self.score = ConstantsUtil.DEFAULT_SCORE
end

return PlaneModel
