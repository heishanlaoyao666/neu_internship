local BaseView = class("BaseView", cc.Node)

function BaseView:ctor(name)
    Log.i("BaseView ctor")
    self.name = name
    self:onCreate()
    self:bind()
    self.enableNodeEvents()
end

function BaseView:onCreate()
    -- body
end

function BaseView:bind()
    -- body
end

function BaseView:onExit()
    MvcManager:clearViewBind(self.name)
    Log.i(self.name .. "onExit()")
end

function BaseView:modelUpdate(model)
    -- body
end

function BaseView:Scene()
    local scene = display.newScene(self.name)
    scene.addChild(self)
    return scene
end

function BaseView:runScene()
    display.runScene(self:scene())
end

return BaseView
