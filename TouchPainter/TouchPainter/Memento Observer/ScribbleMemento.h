/*
 
 # 备忘录模式
 > 在不破坏封装的前提下，捕获一个对象的内部状态，并在该对象之外保存这个状态。这样以后就可将该对象恢复到原先保存的状态。
 这个模式有3个关键角色:原发器(originator)、备忘录(memento)和看管人(caretaker)。其思想非常简单。原发器创建一个包含其状态的备忘录，并传给看管人。看管人不知如何与备忘录交互，但会把备忘录放在安全之处保管好。
 这个设计的关键是维持Memento对象的私有性，只让Originator对象访问保存在Memento对象中的内部状态(即Originator过去的内部状态)。Memento类应该有两个接口:一个宽接口，给Originator用；一个窄接口，给其他对象用。
 **何时使用备忘录模式**
 * 需要保存一个对象(或某部分)在某一个时刻的状态，这样以后就可以恢复到先前的状态；
 * 用于获取状态的接口会暴露实现的细节，需要将其隐藏起来。
 
 
 # 备忘录对象
 **为什么需要一个备忘录对象，而不是直接的Scribble对象？**
 
 因为Scribble模型的主要作用是管理组合Mark结构。
 
 往往我们保存的信息比较复杂，一些中间态，一些额外的信息比如保存时间、创建时间等等。这些信息不适合放入到Scribble中，否则会破坏Scribble的结构，使Scribble变得复杂。
 
 这个时候，我们需要一个备忘录对象。
 
 备忘录对象中保存的信息可以非常复杂(只要Scribble对象能明白就行)。
 
 
 */
#import <Foundation/Foundation.h>

@interface ScribbleMemento : NSObject

/**
 通过保存的NSData生成备忘录对象

 @param data 保存在系统中的data
 @return 备忘录对象
 */
+ (instancetype)mementoWithData:(NSData*)data;
/**
 备忘录将自身打包，生成NSData供外界使用(可能去存储，也可能通过网络共享到另一个涂鸦应用)。

 @return 备忘录对象的data
 */
- (NSData*)data;
@end
