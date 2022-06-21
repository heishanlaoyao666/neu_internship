
cGridSize = 32

cSceneWidth = 10 + 2

cSceneHeight = 20


-- 格子转位置
function Grid2Pos(x, y)

    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()
    local finalX = origin.x + visibleSize.width * 0.5 + x * cGridSize - cSceneWidth / 2 * cGridSize
    local finalY = origin.y + visibleSize.height * 0.5 + y * cGridSize - cSceneHeight / 2 * cGridSize

    return finalX, finalY
end

