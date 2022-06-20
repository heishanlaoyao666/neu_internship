# Lua 编码规范


[TOC]


## 0. 前言 

制订编码规范的目的： 

- 统一编码标准，通用，提高开发效率； 
- 使代码通俗易懂，易于维护。 

## 1. 命名

***骆驼式命名法：*** 第一个单字以小写字母开始；第二个单字的首字母大写或每一个单字的首字母都采用大写字母。也称 ***小驼峰***。

***帕斯卡命名法：*** 和骆驼命名法很像，只有一点区别，就是首字母要大写。(单字之间不以空格断开或连接号)。也称 ***大驼峰***。

### 1.1. 目录命名

**小写** 英文单词，或者单词组合，单词组合中 **没有分隔符**。

注意，如无特殊必要，不要使用 ***拼音***，***数字***，***特殊字符***。

```lua
-- 一个单词
game/ui/controller/
game/ui/scene/

-- 单词组合，注意，gameitem = game + item，全部小写，且没有分割符
game/gameitem/
game/notemsg/
```

### 1.2. 文件命名

游戏中的lua文件，通常是 **类** 代码的承载，所以游戏中的lua文件名要与其承载的 **类** 同名，命名规则等同于 **类命名**。

举例：文件 `UserInfo.lua`，类 `UserInfo`。

注意，一个lua文件通常只对应 **一个模块** 或 **一个类**。切记，不要出现 ***文件名 ~= 类名*** 的情形。

### 1.3. 类命名

所有类名使用 **大驼峰** 方式命名，只能以 **字母** 开头，首字母大写，单词组合其他单词首字母也大写。举例：类名PlayScene，首字母“P”大写，其他单词首字母“S”大写。

类名的后缀要代表功能用途或继承关系，根据实际情形灵活选择即可，切不可 ***毫无意义*** 或者 ***词不达意***。如上例中的**PlayScene**，可以直观了解为**游戏场景**。

注意，如无特殊必要，不要使用 ***拼音***，***数字***，***特殊字符***。

### 1.4. 变量命名

变量的命名使用 **小驼峰** 方式命名，只能以 **字母** 开头，首字母小写，单词组合其他单词首字母大写。举例：matchData，首字母“m”小写，其他单词首字母“D”大写。

代码中经常使用的变量类型有如下几种：**类成员变量**，**文件内本地变量**，**函数内局部变量**，**全局变量**。

```lua
local UserInfo = class("UserInfo")

-- 全局变量 gVar
gVar = 0

-- 常量 MAX_SCORE
local MAX_SCORE = 999999

-- 文件内local变量 scoreArray_
local scoreArray_ = {}

function UserInfo:ctor()
	self.userId_ = 0 -- 类成员变量 userId_
end

function UserInfo:getUserId()
	return self.userId_
end

function UserInfo:getMinScore(score)
	-- 局部变量 minScore
	local minScore = MAX_SCORE
    for i = 1, #scoreArray do
    	minScore = math.min(scoreArray[i], minScore)
    end
    
    return minScore
end

return UserInfo
```

#### 1.4.1. 类成员变量

类中，有 **self.** 修饰的变量为 **类成员变量**，以下划线“_”为结尾。

注意，所有的类成员变量必须在类的构造函数中声明并赋默认值。
注意，类成员变量，在设计上应该都是私有的，应该使用get、set方法访问。

#### 1.4.2. 文件内local变量

lua文件内，使用**local**修饰的、文件内全局变量，以下划线“_”为结尾。

注意，如无特殊需求，尽量使用类成员变量以替代文件内local变量。

#### 1.4.2. 局部变量

在函数内部（或代码块）中使用的、函数结束变量生命周期截止的变量，无特殊要求，“信达雅”即可。

#### 1.4.3. 全局变量

没有local修饰、没有模块修饰（非table成员）的变量为全局变量。

***不允许定义全局变量！！！***
***不允许定义全局变量！！！***
***不允许定义全局变量！！！***

### 1.5. 常量命名

常量使用全大写字母命名，单词之间使用下划线 “_” 分隔。

```lua
local UserInfo = class("UserInfo")

-- 全局函数 gFunc
function gFunc()
	...
end

-- 常量 MAX_SCORE，注意常量声明的位置，在类声明之下，在构造函数之上
local MAX_SCORE = 1024

-- 构造函数
function UserInfo:ctor()
    ...
end
```

### 1.6. 函数命名

函数的命名使用 **小驼峰** 方式命名，只能以 **字母** 开头，首字母小写，单词组合其他单词首字母大写。

经常遇到的函数，根据声明方式可以分为3种：**类成员函数**，**文件内本地函数**，**函数内内部函数**，**全局函数**。

```lua
...
local UserInfo = class("UserInfo")

local _initData -- 文件内local函数 _initData 声明

function UserInfo:ctor()
	...
end

-- 类成员函数 setScore
-- score为函数参数
function UserInfo:setScore(score)
	-- 函数内内部函数 innerFunc
	local innerFunc = function()
		...
	end
end

-- 文件内local函数 _initData 实现
function _initData(...)
    ...
end

return UserInfo
```

#### 1.6.1. 类成员函数

类中，有 **self.** 修饰的函数为 **类成员函数**，无特殊要求，“信达雅”即可。

#### 1.6.2. 文件内local函数

lua文件内，使用**local**修饰的、文件内全局函数，以下划线“_”作为前缀。

#### 1.6.3. 函数内内部函数

在函数内部定义的函数，无特殊要求，“信达雅”即可。

注意，如无特殊需求，不建议使用内部函数，可使用文件内local函数替代。

#### 1.6.4. 全局函数

没有local修饰、没有模块修饰（非table成员）的函数为全局函数。

***不允许定义全局函数！！！***
***不允许定义全局函数！！！***
***不允许定义全局函数！！！***

#### 1.6.5. 函数参数命名

作为函数传参的命名，使用 **小驼峰** 方式命名，只能以 **字母** 开头，首字母小写，单词组合其他单词首字母大写。

注意，若函数参数超过3个，可使用table将参数进行包装。

## 2. 注释

lua中的代码注释有2种形式：
- 单行注释：-- 注释内容
- 多行注释：--[[-- 注释内容 ]]，--[[ 注释内容 ]]

多行注释又有两种形态：
- 会导出 lua doc 的注释：--[[-- 注释内容 ]]，应用到类成员函数，也即对外暴露的接口
- 不会导出 lua doc 的注释：--[[ 注释内容 ]]，应用到文件local函数，也即被保护的函数

**哪些地方必须加上注释：**
1、文件注释，在lua文件最顶部，描述文件详情
2、函数注释，所有的函数，无论函数简单与否，一目了然与否，都要加上注释。
3、常量、类成员变量、文件内local变量，在声明处必须加上注释。
4、代码复杂处，建议加上注释加以说明。
5、多人维护的大型项目，代码修改处，建议加上注释说明修改原因和时间。

注意，游戏内的注释必须全部使用中文。

```lua
--[[-- 【文件注释】
	UserInfo.lua

	描述：用户信息类，封装用户个人信息数据。
]]
local UserInfo = class("UserInfo")

local MAX_SCORE = 999999 -- 积分最大值【常量注释】

local scoreArray_ = {} -- 类型：table，积分数组【文件内local变量注释】

---------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------
local _initData

--[[-- 【类成员函数注释】
	描述：构造函数
	
	@param none

	@return none
]]
function UserInfo:ctor()
	self.userId_ = 0 -- 类型：number，用户id 【成员变量注释】
	self.state_ = 0 -- 类型：number，用户状态
end

--[[-- 【类成员函数注释】
	描述：切换玩家状态
	
	@param state 类型：number，用户状态 【函数参数注释】

	@return boolean 【函数返回值注释】
]]
function UserInfo:changeState(userId)
	-- 内置函数，检查是否能够切换状态 【内置函数注释】
	local canChange = function(...)
		...
	end
	
	local ret = false

	-- 需要优先检查是否能够切换状态 【代码行注释】
	if canChange(state) then
		ret = true
		self.state_ = state
	end
	
	return ret
end

---------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------

--[[ 【文件local函数注释】
	描述：初始化数据
	
	@param self 类型：UserInfo，当前对象
	@param data 类型：table，参数定义如下：【复合参数注释】
	{ 
		userId = 0, -- 类型：number，用户id
		nickname = "", -- 类型：string，昵称
		figureId = 0, -- 类型：number，头像id
	}
	
	@return none
]]
function _initData(self, data)
	--[[ 【代码补丁注释】
		add by xxx 2021/7/13
		为解决bug10xx，此处做补丁处理，特殊判断，后续需要优化 todo
	]]
	...
end

return UserInfo
```

### 2.1. 文件注释

文件注释出现在文件顶部，使用 **--[[-- ]]** 注释方式，用以说明文件（类）的作用。

注释要素：

- 文件名称，也即 lua 文件名称 + 扩展名。
- 文件描述，说明这个文件的用途，以及必要的注意事项。

### 2.2. 函数注释

类成员函数使用 **--[[-- 注释内容 ]]** 注释方式。

文件local函数在函数实现处，使用**--[[ 注释内容 ]]** 注释方式，差别就在于比 **--[[--** 少了**--**，变成了**--[[**。

内置函数注释 同 代码行注释，简要说明功能用途。

注释要素：

- 函数描述，说明函数的用途。
- 函数参数，输入参数的基础类型、业务用途说明。
- 返回值，函数的返回值类型描述，如果返回值是“复杂”table，需要详细描述内部具体参数。

注意，文件local函数的self参数描述，永远都是 **“当前对象”**。
注意，复合参数（table类型），需要将参数内容展开，对每个内部变量进行单独注释。

### 2.3. 常量注释

常量定义的上一行，或同一行代码尾，简要描述常量的 **用途**。

### 2.4. 变量注释

变量定义的上一行，或同一行代码尾，简要描述变量的 **类型**、**用途**。

成员变量和文件内local变量的注释格式相同。

### 2.5. 代码行注释

代码行的上一行，或同一行代码尾，针对不易直观理解的代码、或需要格外关注的代码，简要描述注意事项。

### 2.6. 代码补丁注释

代码补丁的上面，描述清楚修改人、时间、事由。

## 3. 排版

### 3.1. 缩进

代码缩进为 **4** 个空格。为防止出错，可通过编辑器设置 **Tab = 4 个空格**。

在下述情况下应使用缩进 ：

- 方法体或语句块中的代码 。
- 换行时的非起始行的代码。

缩减量一般为在上一级代码的基础上，跑到下一个制表位。

### 3.2. 空行

在下述情况下使用单行的空白行来分隔：

- 函数之间加空行。
- 函数内部代码块之间加空行，逻辑段落小节之间加空行。
- 注释行之前加空行，如果注释行为本代码段的起始行，则不需要空行。
- 日志行上下加空行，如果日志行在代码段的起始行或结尾行，则对应的上、下不需要加空行。
- **end** 语句下方加空行，如果end语句在代码段的结尾行，则不需要在下方加空行。

在下述情况下不要加空行：

- 在一个函数体内，逻揖上密切相关的语句之间不加空行。
- 多行注释解释参数的时候，注释之间不加空行。
- lua check检查，不允许出现连续的两行空行。

### 3.3. 换行

一行代码最好只做一件事情，比如只写一个语句，或只定义一个变量。

```lua
-- 良好的风格
local x = 0
local y = 0

-- 不好的风格（不建议，但不强制）
local x, y = 0, 0

-- 非常不好的风格（不允许一行中声明的变量分属于不同的类型）
local x, name = 0, ""
```

```lua
-- 良好的风格
local btn = newButton({
    text = "submit",
    x = 10,
    y = 20,
    parent = self,
    images = {
        normal = "img/submit_btn.png",
    },
})

-- 不好的风格（不允许出现这种代码）
local btn = newButton({text = "submit", x = 10, y = 20, parent = self,
images = {normal = "img/submit_btn.png",},})
```

不建议在一行中写多条语句，一条语句的长度一般超过了120个字符时，应该换行。

**if、for、while、do、else、elseif** 等语句单独一行。

```lua
-- 良好的风格
if a > 0 then
    return true
end

-- 不好的风格
if a > 0 then return true end
```

长表达式要在低优先级操作符处拆分成新行，操作符放在新行之首（以便突出操作符）。

```lua
-- 良好的风格
if (msgCategory == HTTP_ACK_MSG and msgType == COMMON_HTTP_GET_NOTE_MSG_ACK)
        or (msgCategory == LOBBY_ACK_MSG and msgType == NOREG_LOGIN_ACK) then
    ...
end

-- 不好的风格（不允许出现这种不易区分优先级的代码）
if (msgCategory == HTTP_ACK_MSG and
        msgType == COMMON_HTTP_GET_NOTE_MSG_ACK) or
        (msgCategory == LOBBY_ACK_MSG and
        msgType == NOREG_LOGIN_ACK) then
    ...
end
```

### 3.4. 空格

除正常的成分之间以空格符分隔名（如数据类型和变量名之间），在下述情况下也应使用一个空格符来分隔：

- 比较符(!=、==、>、>=、<、<=)、 连接符(..)、运算符(+、-、*、/、%、^) 、and、or 等符号 **左右** 需要有空格。
- 逗号后面留一个空格。

注意，需要空格的地方也仅需要1个空格，不要加多个。且，行尾不需要空格。

```lua
-- 符号左右加空格
if a > b then
    local str = "a=" .. tostring(a)
end

-- 逗号后面加空格
local t = {1, 2, 3, 4}
```

- 括号内“()”首尾不要加空格。
```lua
-- 正确的写法
function func(a)
    ...
end

-- 错误的写法
function func( a )
    ...
end

-- 正确的写法
func(1)

-- 错误的写法
func( 1 )
```

## 4. 其它

### 4.1. 文件格式

文件采用 UTF-8 无 BOM 编码, 回车换行使用 unix 方式（仅包含 LF, 没有 CRLF）。

> ps：git 可以通过配置 .gitconfig 文件，进行自动换行符转换，笔者建议，配置好开发常用编辑器的字符集以及回车设置是最保险的解决方案。

### 4.2. require位置

文件中require导入的其它文件，需要在类声明的下边导入，不要在每次使用的时候导入，且导入声明为local变量，变量名称与导入的文件名一致。

目的：

- 防止在一些重复执行代码中，每次都执行require操作。
- 文件引用的其它文件清晰可查，有益于代码阅读。

### 4.3. 函数返回值需要赋初值

函数的返回值，建议在函数开始时声明，并赋初值。初值对应返回值类型。

```lua
function _getVersion()
    local version = 1
    ...
    return version
end
```

有一种特殊情形，如果是一个table返回值，且初始值期望是nil的时候，不需要赋初值。原因是在 IntelliJ IDEA 编辑器中，普通local变量赋初值nil，被认定是无用代码，有警告信息。

```lua
-- 不建议
local data = nil

-- 建议
local data
```

### 4.4. 类成员变量，在外部只能通过接口访问

```lua
-- 类 Player 定义
local Player = class("Player")

function Player:ctor()
    self.age_ = 0
end

function Player:getAge()
    return self.age_
end

-- 不建议的变量访问
local player = Player.new()
local age = player.age_

-- 建议的变量访问
local age = player:getAge()
```

有一种特殊的情形，比如在真循环逻辑或者在一个执行次数很高的循环体中，如果有较高的性能要求，可以直接访问成员，降低冒号“：”这个语法糖带来的性能损耗。

注意，在继承类中，对于基类的成员变量也应该尽量使用接口访问。
