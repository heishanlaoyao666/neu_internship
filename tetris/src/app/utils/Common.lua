cGridSize = 33

cSceneWidth = 10 + 2

cSceneHeight = 20 + 1

--将格子坐标转换成屏幕像素坐标
function Grid2Pos(x, y)
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    -- dump(visibleSize)

    local origin = cc.Director:getInstance():getVisibleOrigin()
    -- dump(origin)

    local finalX = origin.x + visibleSize.width * 0.5 + x * cGridSize - cSceneWidth /2 * cGridSize
    local finalY = origin.y + visibleSize.height * 0.5 + y * cGridSize - cSceneHeight /2 * cGridSize
    -- print(finalX, finalY)
    return finalX, finalY
end

return Grid2Pos