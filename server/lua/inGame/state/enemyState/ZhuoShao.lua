--[[
    ZhuoShao.lua
    描述：在player中储存信息
    编写：李昊
]]

local ZhuoShao = {
    enemy_ = nil, --敌人
    attackCd_ = nil, --攻击cd
    hurt_ = nil, --伤害
    Cd_ = 1000,
    attackNum_ = nil, --攻击的次数
    time_ = nil, --内置时间
    id_ = nil,
    size_ = 1,
}

local id = 0

function ZhuoShao:new(hurt)
    local zhuoShao = {}
    self.__index = self
    setmetatable(zhuoShao,self)
    zhuoShao:init(hurt)
    return zhuoShao
end

function ZhuoShao:init(hurt)
    self.hurt_ = hurt
    self.attackCd_ = 1000
    self.attackNum_ = 2
    self.time_ = 0
    id = id + 1
    self.id_ = id
end

function ZhuoShao:destroy()
    local zhuoShao
    for i = 1,#self.enemy_.state_ do
        if self.enemy_.state_[i] == self then
            zhuoShao = i
            break
        end
    end
    table.remove(self.enemy_.state_,zhuoShao)
end

function ZhuoShao:attack()
    self.enemy_.hp_ = self.enemy_.hp_ - self.hurt_
end

function ZhuoShao:update(dt)
    self.time_ = self.time_ - dt
    if self.time_ <= 0 then
        self:attack()
        self.attackNum_ = self.attackNum_ - 1
        if self.attackNum_ <= 0 then
            self:destroy()
            return
        end
        self.time_ = self.Cd_
    end

end

return ZhuoShao