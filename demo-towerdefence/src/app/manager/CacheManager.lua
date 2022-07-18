--[[--
    CacheManger.lua

    描述：缓存管理对象，管理数据对象
          为减少new对象的开支，在创建时向缓存池申请对象资源；删除时也先放到缓存池再进行移除
]]
local CacheManger = class("CacheManger")
local Log = require("app.util.Log")

--[[--
    描述：构造函数

    @param params 类型：table，参数定义如下：
    {
        newFunc = nil, -- 类型：function，通过此方法new新对象，用法newFunc()，非空
        delFunc = nil, -- 类型：function，通过此方法dle废弃对象，参数为newFunc创建的数据对象，用法delFunc(data)，非空
        maxNum = 0, -- 类型：number，缓存最大数量，超过此数量时不再继续缓存移除的数据，直接删除
        minNum = 0, -- 类型：number，缓存最小数量，初始化时也将根据此值初始化缓存池对象持有数量
        newNum = 0, -- 类型：number，缓存数量不足时，每次new对象数量
    }

    @return none
]]
function CacheManger:ctor(params)
    self.newFunc_ = params.newFunc -- 类型：function，通过此方法new新对象
    self.delFunc_ = params.delFunc -- 类型：function，通过此方法del废弃对象，参数为newFunc创建的数据对象
    self.maxNum_ = tonum(params.maxNum) -- 类型：number，缓存最大数量，超过此数量时不再继续缓存移除的数据，直接删除
    self.maxNum_ = math.max(1, self.maxNum_)
    self.minNum_ = tonum(params.minNum) -- 类型：number，缓存最小数量，初始化时也将根据此值初始化缓存池对象持有数量
    self.minNum_ = math.max(1, self.minNum_)
    self.newNum_ = tonum(params.newNum) -- 类型：number，缓存数量不足时，每次new对象数量
    self.newNum_ = math.max(1, self.newNum_)

    self.cacheDatas_ = {} -- 类型：table，缓存数据，数组形式读取
    self.dataMap_ = {} -- 类型：table，持久化数据，map形式读取，pair方式遍历
    self.dataNum_ = 0 -- 类型：number，持久化数据数量

    -- 重置
    self:reset()
end

--[[--
    描述：数据重置
    注意，重置不代表数据为空，缓存内容不会清理，而有可能根据最低缓存数量new新对象

    @param none

    @return none
]]
function CacheManger:reset()
    self.dataMap_ = {}
    self.dataNum_ = 0

    -- 检查缓存数量，如果缓存数量不足则补充，如果缓存充足则不做操作
    if #self.cacheDatas_ < self.minNum_ then
        local addNum = self.minNum_ - #self.cacheDatas_
        for i = 1, addNum do
            self.cacheDatas_[#self.cacheDatas_ + 1] = self.newFunc_()
        end
    end
end

--[[--
    描述：缓存池检查，根据配置数据检查缓存对象数量
    注意，每次新增的数量为输入参数中的newNum

    @param none

    @return none
]]
function CacheManger:check()
    if #self.cacheDatas_ < self.minNum_ then
        local addNum = math.min(self.newNum_, self.minNum_ - #self.cacheDatas_)
        for i = 1, addNum do
            self.cacheDatas_[#self.cacheDatas_ + 1] = self.newFunc_()
        end
    elseif #self.cacheDatas_ > self.maxNum_ then
        local data
        while #self.cacheDatas_ > self.maxNum_ do
            data = self.cacheDatas_[#self.cacheDatas_]
            self.cacheDatas_[#self.cacheDatas_] = nil
            self.delFunc_(data)
        end
    end
end

--[[--
    描述：持久化数据数量返回

    @param none

    @return number
]]
function CacheManger:getCount()
    return self.dataNum_
end

--[[--
    描述：持久化数据获取，map形式读取

    @param none

    @return table
]]
function CacheManger:getDataMap()
    return self.dataMap_
end

--[[--
    描述：通过id获取指定数据对象

    @param id 类型：number，数据对象唯一标识

    @return table
]]
function CacheManger:getData(id)
    return self.dataMap_[id]
end

--[[--
    描述：向缓存池申请一个对象的资源
    注意，此处返回的有可能是之前删除的数据，之前删除的数据有可能还保留着脏数据，需要重新赋值后才可使用，尤其是id
    注意，若是当前缓存池为空，则通过newFunc创建新的默认对象
    注意，pop之后一定要insert，将对象交给缓存池管理

    @param none

    @return table
]]
function CacheManger:pop()
    local data
    if #self.cacheDatas_ > 0 then
        -- 缓存池中有数据，倒序返回，方便操作
        data = self.cacheDatas_[#self.cacheDatas_]
        self.cacheDatas_[#self.cacheDatas_] = nil
    else
        -- 缓冲池中没有数据，创建默认元素
        data = self.newFunc_()
    end

    return data
end

--[[--
    描述：新增元素，新增的元素放置到持久化map中管理

    @param id 类型：number，数据对象唯一标识，同value方法中id
    @param data 类型：数据对象

    @return none
]]
function CacheManger:push(id, data)
    self.dataMap_[id] = data
    self.dataNum_ = self.dataNum_ + 1
end

--[[--
    描述：移除元素，移除的元素优先放置到缓存池中，若是缓存池已满，则直接清理

    @param id 类型：number，数据对象唯一标识，同value方法中id

    @return none
]]
function CacheManger:remove(id)
    local data = self.dataMap_[id]
    if not self.dataMap_[id] then
        return
    end

    if #self.cacheDatas_ >= self.maxNum_ then
        -- 缓存池已满，直接清理
        self.delFunc_(data)
    else
        -- 缓存池未满，将移除的元素从持久化中移到缓存池中
        self.cacheDatas_[#self.cacheDatas_ + 1] = data
    end

    -- 删除持久化数据
    self.dataMap_[id] = nil
    self.dataNum_ = self.dataNum_ - 1
end

return CacheManger