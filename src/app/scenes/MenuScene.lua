local MenuScene =
    class(
    "MenuScene",
    function()
        return display.newScene("MenuScene")
    end
)
---local

---

function MenuScene:ctor()
end

function MenuScene:onEnter()
    local menuScene = cc.CSLoader:getInstance():createNodeWithFlatBuffersFile("MenuScene.csb"):addTo(self, 1)
    local bg = ccui.Helper:seekWidgetByName(menuScene, StringUtil.getBackground())
    ccui.Helper:doLayout(bg)
end

function MenuScene:onExit()
end

return MenuScene
