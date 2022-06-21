-- 每个方块占32个像素 
cGridSize = 32
-- 场景宽度：10个方块共320px
cSceneWidth = 8 + 2
-- 场景高度：18个方块
cSceneHeight = 18
 
-- 方块坐标转换为屏幕坐标
-- function Gridpos(x, y)
--     local director = cc.Director:getInstance()
--     -- 获取可视区域宽高
--     local size = director:getVisibleSize()
--     -- 获取原点
--     local origin = director:getVisibleOrigin()
 
--     local posX = origin.x + size.width/2 + cGridSize*x - cSceneWidth/2*cGridSize 
--     local posY = origin.y + size.height/2 + cGridSize*y - cSceneHeight/2*cGridSize 
 
--     return posX, posY
-- end

function GridPos(x, y)
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local visibleOrigin = cc.Director:getInstance():getVisibleOrigin()
    local finalX = visibleOrigin.x + visibleSize.width/2 + x*cGridSize - cSceneWidth/2*cGridSize
    local finalY = visibleOrigin.y + visibleSize.height/2 + y*cGridSize - cSceneHeight/2*cGridSize
    return finalX, finalY
end