---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Asus.
--- DateTime: 2022/6/9 20:38
---
local Boom = require("src/app/models/pojo/Boom.lua")
local CollisionManage = class("CollisionManage")
CollisionManage.plain = nil
CollisionManage.bulletList = nil
CollisionManage.enemyList = nil
CollisionManage.index = 1
CollisionManage.booms = {}
CollisionManage.fireBooms = false
CollisionManage.lifeReduce = 20
CollisionManage.scoreAdd = 10
function CollisionManage:ctor()

end
function CollisionManage:init(plain, bulletList, enemyList)
    --print(plain, bulletList, enemyList)
    self.enemyList = enemyList
    self.bulletList = bulletList
    self.plain = plain

end
function CollisionManage:empty()
    self.index = 1
    self.booms = {}
    self.fireBooms = false
end
function CollisionManage:collisionDetect()
    local lifeReduce = 0
    local scoreAdd = 0

    for enemy in self.enemyList:iterator() do

        local enemyX, enemyY = enemy:getEnemyPosition()
        if enemy:isAlive() then
            --detect bullet and enemy
            for bullet in self.bulletList:iterator() do
                if bullet:isAlive() and enemyY < 960 then
                    --print(enemy:isAlive(), bullet:isAlive())
                    --print(self.enemyList.num, self.bulletList.num)
                    local bulletX, bulletY = bullet:getBulletPosition()
                    local resX = math.abs(bulletX - enemyX)
                    local resY = math.abs(bulletY - enemyY)
                    local res = resX + resY
                    if resX <= 20 and
                            resY <= 20 and
                            res < 30 then
                        --print("tu")
                        --print(resX, resY, res)
                        enemy:setAlive(false)
                        bullet:setAlive(false)
                        local boom = Boom:new()
                        boom:init(enemyX, enemyY)
                        self.booms[self.index] = boom
                        self.index = self.index + 1
                        scoreAdd = scoreAdd + self.scoreAdd
                        break
                    end
                end
            end
            --detect enemy and plain
            local plainX, plainY = self.plain:getLocation()
            --print(plainX, plainY)
            local resX = math.abs(enemyX - plainX)
            local resY = math.abs(enemyY - plainY)
            local res = resY + resX
            if resX < 20 and
                    resY < 20 and
                    res < 30 and
                    enemy:isAlive() then
                enemy:setAlive(false)
                lifeReduce = lifeReduce + self.lifeReduce
                local boom = Boom:new()
                boom:init(enemyX, enemyY)
                self.booms[self.index] = boom
                self.index = self.index + 1
                self.fireBooms = true
            end
        end


    end

    return self.booms, self.fireBooms, lifeReduce, scoreAdd
end


return CollisionManage
