local player = class("player", function()
    return display.newScene("player")
end)
local width
local height
function player:ctor()
    width, height = display.width, display.top

    --初始化
    player=cc.Sprite:create("player/red_plane.png")
    player:setAnchorPoint(0.5,0)
end
--移动
function player:playerMoveTo()
    
end

return player