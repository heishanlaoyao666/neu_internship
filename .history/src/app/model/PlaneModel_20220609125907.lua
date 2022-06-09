local PlaneModel = class("PlaneModel")

-- 构造函数
function PlaneModel:ctor()
    self.x = WinSize.width / 2
    self.y = WinSize.height * -0.3
    self.hp = ConstantsUtil.DEFAULT_HP
    self.score = ConstantsUtil.DEFAULT_SCORE
end
