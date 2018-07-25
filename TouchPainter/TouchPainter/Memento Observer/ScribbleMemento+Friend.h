/*
    在扩展里面提供初始化方法，是为了对应备忘录模式中的宽接口。只有Scribble中导入该扩展，才可以使用初始化方法。
 */

#import "ScribbleMemento.h"
#import "Mark.h"

@interface ScribbleMemento ()
- (instancetype)initWithMark:(id<Mark>)aMark;
@property(nonatomic , copy)id<Mark> mark;
@property(nonatomic , assign)BOOL hasCompleteSnapshot;
@end
