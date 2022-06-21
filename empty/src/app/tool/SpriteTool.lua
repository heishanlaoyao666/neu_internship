--[[--
    SpriteTool.lua
    帮助创建图片的自适应化
]]
local SpriteTool = class("SpriteTool")

--[[--
    获取缩放比例函数

    @param x 类型：number
    @param y 类型：number

    @return bgScale 类型:number
]]
function SpriteTool:getScaleInBg(x,y)
    local bgScale = 1
    if display.cx>display.cy then
        bgScale=display.top/y
    else
        bgScale=display.width/x
    end
    return bgScale
end
return SpriteTool