
local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)

function GameScene:ctor()

    local label = display.newTTFLabel({
        text = "No，Hello, World",
        size = 64,
    })
    label:align(display.CENTER, display.cx, display.cy)
    label:addTo(self)
end

function GameScene:onEnter()
end

function GameScene:onExit()
end

return GameScene
