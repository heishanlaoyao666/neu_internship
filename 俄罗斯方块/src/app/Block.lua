
local cBlockArray = {
    {
        --T字形 黄色
        fileName="res\\美术资源\\t_4.png",
        {
            {1,1,1,0},
            {0,1,0,0},
            {0,0,0,0},
            {0,0,0,0}
        },
        {
            {0,1,0,0},
            {1,1,0,0},
            {0,1,0,0},
            {0,0,0,0}
        },
        {
            {0,1,0,0},
            {1,1,1,0},
            {0,0,0,0},
            {0,0,0,0}
        },
        {
            {0,1,0,0},
            {0,1,1,0},
            {0,1,0,0},
            {0,0,0,0}
        },
    },
    --方块 红色
    {
        fileName="res\\美术资源\\t_5.png",
        {
            {0,1,1,0},
            {0,1,1,0},
            {0,0,0,0},
            {0,0,0,0}
        },
    },
    --S字形 紫色
    {
        fileName="res\\美术资源\\t_2.png",
        {
            {0,1,1,0},
            {1,1,0,0},
            {0,0,0,0},
            {0,0,0,0}
        },
        {
            {0,1,0,0},
            {0,1,1,0},
            {0,0,1,0},
            {0,0,0,0}
        },
    },
    --Z字形 橙色
    {
        fileName="res\\美术资源\\t_3.png",
        {
            {1,1,0,0},
            {0,1,1,0},
            {0,0,0,0},
            {0,0,0,0}
        },
        {
            {0,0,1,0},
            {0,1,1,0},
            {0,1,0,0},
            {0,0,0,0}
        },
    },
     --I字形 青色
    {
        fileName="res\\美术资源\\t_7.png",
        initOffset=1,
        {
            {0,0,0,0},
            {1,1,1,1},
            {0,0,0,0},
            {0,0,0,0}
        },
        {
            {0,1,0,0},
            {0,1,0,0},
            {0,1,0,0},
            {0,1,0,0}
        },
    },
    --L形 绿色
    {
        initOffset=1,
        fileName="res\\美术资源\\t_1.png",
        {
            {0,0,0,0},
            {1,1,1,0},
            {1,0,0,0},
            {0,0,0,0}
        },
        {
            {1,1,0,0},
            {0,1,0,0},
            {0,1,0,0},
            {0,0,0,0}
        },
        {
            {0,0,1,0},
            {1,1,1,0},
            {0,0,0,0},
            {0,0,0,0}
        },
        {
            {0,1,0,0},
            {0,1,0,0},
            {0,1,1,0},
            {0,0,0,0}
        },
    },
     --J形 蓝色
     {
        fileName="res\\美术资源\\t_6.png",
        initOffset=1,
        {
            {0,0,0,0},
            {1,1,1,0},
            {0,0,1,0},
            {0,0,0,0}
        },
        {
            {0,1,0,0},
            {0,1,0,0},
            {1,1,0,0},
            {0,0,0,0}
        },
        {
            {1,0,0,0},
            {1,1,1,0},
            {0,0,0,0},
            {0,0,0,0}
        },
        {
            {0,1,1,0},
            {0,1,0,0},
            {0,1,0,0},
            {0,0,0,0}
        },
    }
}

local Block = class("Block")

local InitXOffset = cSceneWidth/2-3

function RandomStyle()
    -- body
    return math.random(1, #cBlockArray)
end

function Block:ctor(scene,index)
    -- body
    self.x=InitXOffset
    self.y=cSceneHeight

    local offset=cBlockArray[index].initOffset
    if offset then
        self.y=self.y+offset
    end

    self.scene=scene
    self.index=index
    self.fileName=cBlockArray[index].fileName
    self.trans=1
end

local function IterateBlock(index,trans,callback)
    local transArray = cBlockArray[index]
    local eachBlock = transArray[trans]

    for y=1,#eachBlock do
        local xdata = eachBlock[y]

        for x=1,#xdata do
            local data = xdata[x]

            if not callback(x,y,data~=0) then
                return false
            end
        end
    end
    return true
end

function RawPlace(index,trans,scene,newX,newY)
    -- body
    local result = {}

    if IterateBlock(index,trans,function(x,y,b)
        -- body
        if b then
            local finalX = newX+x
            local finalY = newY-y

            if scene:Get(finalX,finalY) then
                return false
            end

            table.insert(result,{x=finalX,y=finalY})
        end
        return true
    end) then

        for k,v in ipairs(result) do
            scene:Set(v.x,v.y,true)
        end
        return true
    end
end

function Block:Move(deltaX,deltaY)
    -- body
    self:Clear()

    local x = self.x+deltaX
    local y = self.y+deltaY

    if RawPlace(self.index,self.trans,self.scene,x,y) then
        self.x=x
        self.y=y
        return true
    else
        self:Place()
        return false
    end
end

function Block:Rotate(direction)
    -- body
    local offset = cBlockArray[self.index].initOffset
    if offset and self.y==0 then
        return
    end

    self:Clear()

    local transArray = cBlockArray[self.index]
    local trans
    if direction==1 then
        trans = self.trans+1
        if trans>#transArray then
            trans=1
        end
    else
        trans = self.trans-1
        if trans==0 then
            trans=#transArray
        end
    end

    -- local trans = self.trans+1

    -- if trans>#transArray then
    --     trans=1
    -- end

    if RawPlace(self.index,trans,self.scene,self.x,self.y) then
        self.trans=trans
    else
        self:Place()
    end
end

function Block:Place()
    -- body
    return RawPlace(self.index, self.trans, self.scene, self.x,self.y)
end

function Block:Clear()
    IterateBlock(self.index, self.trans, function(x,y,b)
        -- body
        local finalX = self.x+x
        local finalY = self.y-y
        if b then
            self.scene:Set(finalX,finalY,false)
        end
        return true
    end)
end


return Block
