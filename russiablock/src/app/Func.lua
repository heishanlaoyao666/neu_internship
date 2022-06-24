local Func = class("Func")

PixelSize = 100--每个方块占100个像素
SceneWidth = 10 + 2--场景宽度，12个方块
SceneHeight = 20--场景高度，20个方块
function GridPos(x, y)--将方块坐标转换为屏幕坐标
    local visibleSize = cc.Director:getInstance():getVisibleSize()--可视区域的宽度和高度
    local X =visibleSize.width/2 + x*PixelSize - SceneWidth/2*PixelSize
    local Y =visibleSize.height/2 + y*PixelSize - SceneHeight/2*PixelSize
    return X, Y
end

function makeKey(x, y)--场景内方块坐标获取
    return x * 1000 + y
end

function Func:ctor(scene)--生成游戏场景
    self.key = {}
    for x = 0, SceneWidth-1 do
        for y = 0, SceneHeight-1 do
            local posX, posY = GridPos(x, y)
            local block = display.newSprite("ui/wall.png")
            block:setPosition(posX-200, posY+300)--场景填满方块
            scene:addChild(block)

            local visible = (x == 0 or x == SceneWidth-1) or y == 0
            block:setVisible(visible)--除了边缘，其他的方块都隐藏

            self.key[makeKey(x, y)] = block
        end
    end
end

--[[
    函数用途：播放音效
    --]]
function Func:playEffect(path)
    local effectPath = path
    local audio = require("framework.audio")
    audio.loadFile(effectPath,function()
        audio.playEffect(effectPath,false)
    end)
end

function Func:ClearALine(y)--清除一行
    for x = 1, SceneWidth-2 do
        self:Set(x, y, false)
    end
end
function Func:Clear()--清除整个屏幕
    for y = 1, SceneHeight-1 do
        self:ClearLine(y)
    end
end

function Func:Set(x, y, value)--场景内方块的显示与清除
    local block = self.key[makeKey(x, y)]
    if block == nil then
        return
    end
    block:setVisible(value)
end

function Func:Search(x,y)--查询是否可见
    local sp = self.key[makeKey(x, y)]
    if sp == nil then
        return
    end
    if sp:isVisible() then
        return true
    end
    return false
end

function Func:IsFullLine(y)--判断是否满行
    local count = 0
    for x = 1, SceneWidth - 2 do
        local block = self.key[makeKey(x, y)]
        if block:isVisible() then
            count = count+1
        else
            return
        end
        --print(count)
    end
    if count == 10 then
        return true
    else
        return false
    end
end

function  Func:CheckAndSweep()--查询是否有满行并清除
    local count = 0
    for y = 1, SceneHeight - 1 do--从第一行开始检查是否有满了的行
        if  self:IsFullLine(y) then--有一行满了
            self:ClearALine(y)--清除这行
            self:MoveDown(y)--下降
            count = count+1
        end
    end
    return count
end

function Func:MoveDown(y)--下沉
    for i = y, SceneHeight - 1 do
        for x = 1, SceneWidth - 2 do
            self:Set(x, i, self:Search(x, i + 1))
        end
    end
end

function Func:IsEmptyLine(y)--查询是否为空行
    local count = 10
    for x = 1, SceneWidth - 2 do
        local sp = self.key[makeKey(x, y)]
        if sp~=nil and not sp:isVisible() then
            count = count-1
            --print(count)
        else
            return
        end
    end

    if count == 0 then
        return true
    else
        return false
    end

end

return Func
