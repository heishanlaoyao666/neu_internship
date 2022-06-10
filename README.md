Northeastern University Internship Project

> 暂时的想法

## scene
包含所有的场景，在场景中进行Node节点的布置

## node
用来生成Node节点，每一个Node节点包括且仅包括一个Layout子控件。在Layout子控件中放置Sprite等控件
节点中有self.data指向model，用来存储控件的数据
虽然dataModel中的数据理论上等于控件的数据，但是为了尽量避免误差，我们尽可能优先使用控件的数据，仅仅将dataModel中的数据作为游戏进行暂时存储的备用数据

## model
~~实际的 类，所需要创建的Sprite等控件都是来自于这里~~
只用来提供model对应的控件所需要的数据，控件在创建之后需要的数据全部来自这些model
这样就可以实现数据与视图分离了！

## handler
作为node与model进行对接的桥梁，为了便于两者进行数据传输，并不要求两者的交互必须经过handler

## util
一些工具类，默认为Global
