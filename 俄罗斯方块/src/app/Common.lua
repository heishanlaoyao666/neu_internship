cGridSize=20

cSceneWidth=12

cSceneHeight=21


function Grid2Pos(x,y)
    -- body
    local visibleSize = cc.Director:getInstance():getVisibleSize()--获取手机可视屏幕尺寸

    local origin = cc.Director:getInstance():getVisibleOrigin() -- 获取手机可视屏原点的坐标

    local finalX = origin.x+visibleSize.width*0.5+x*cGridSize-cSceneWidth/2*cGridSize
    local finalY = origin.y+visibleSize.height*0.5+y*cGridSize-cSceneHeight/2*cGridSize

    return finalX,finalY
end
