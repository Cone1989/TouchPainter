/*
 对于绘图应用来说，组合总共有几层？
                Stroke(根节点,即_parentMark)
            Dot         Stroke
                     Vertex   Vertex  ....
 
 可以看到，结构共3层。
 这个涂鸦有点和线组成，线有顶点组成。点和线有一个共同的根节点。
 
 */

#import "Scribble.h"
#import "Stroke.h"
#import "ScribbleMemento+Friend.h"
@interface Scribble()
{
    id<Mark> _parentMark; // 完整模型
    id<Mark> _incrementMark; // 增量模型
}
// 用于触发kvo
@property(nonatomic, copy) id<Mark> mark;


@end

@implementation Scribble

/*
 对外部我们使用足够简单并且明确的key:@"mark"。在本类中，我们使用更符合作用的名称parentMark。因此这里使用@synthesize关联属性和成员变量。
 */
@synthesize mark = _parentMark;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 在我们的设计中，根节点应该是Stroke，当绘制到它的时候，因为没有顶节点Vertex，不会实际发生绘制。
        _parentMark = [[Stroke alloc] init];
    }
    return self;
}
- (void) addMark:(id <Mark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark {
    
    // 手动触发kvo
    [self willChangeValueForKey:@"mark"];
    
    // 是否是上一个结构的部分
    if (shouldAddToPreviousMark) {
        // 上一个结构应该是Stroke，aMark作为它的一个顶点
        [[_parentMark lastChild] addMark:aMark];
    }else{
        [_parentMark addMark:aMark];
        // 仅仅保存直接添加到父模型的模型。上面是一个线条的顶点，在实际绘图中，线条是一个整体。
        _incrementMark = aMark;
    }
    [self didChangeValueForKey:@"mark"];
}
- (void)removeMark:(id<Mark>)aMark {
    if (aMark == _parentMark) {
        return;
    }
    [self willChangeValueForKey:@"mark"];
    // 如果父结构不能处理，会递归到整个结构中
    [_parentMark removeMark:aMark];
    if (aMark == _incrementMark) {
        _incrementMark = nil;
    }
    [self didChangeValueForKey:@"mark"];
}

#pragma mark - methods for memento
- (instancetype)initWithMemento:(ScribbleMemento *)aMemento {
    if (self = [super init]) {
        if (aMemento.hasCompleteSnapshot) {
            // 如果是完整的结构，则赋值给_parentMark
            [self setMark:[aMemento mark]];
        }else {
            // 如果只是增量，那么创建容纳它的父节点
            // 结构中的根节点总是多余的，它在绘制的时候不会起作用。
            _parentMark = [[Stroke alloc] init];
            [self attachStateFromMemento:aMemento];
        }
    }
    return self;
}
+ (instancetype)scribbleWithMemento:(ScribbleMemento *)aMemento {
    Scribble *scribble = [[Scribble alloc] initWithMemento:aMemento];
    return scribble;
}
- (void)attachStateFromMemento:(ScribbleMemento *)memento {
    // mark组合添加到根节点上
    [self addMark:memento.mark shouldAddToPreviousMark:NO];
}

- (ScribbleMemento *)scribbleMemento {
    return [self scribbleMementoWithCompleteSnapshot:YES];
}
- (ScribbleMemento *)scribbleMementoWithCompleteSnapshot:(BOOL)hasCompleteSnapshot {
    // 先获取增量
    id<Mark> mementoMark = _incrementMark;
    if (hasCompleteSnapshot) {
        // 如果是完整的结构保存，则取_parentMark
        mementoMark = _parentMark;
    }else if (mementoMark == nil) {
        // 如果增量为nil，那么直接返回，不用保存
        return nil;
    }
    ScribbleMemento *memento = [[ScribbleMemento alloc] initWithMark:mementoMark];
    [memento setHasCompleteSnapshot:hasCompleteSnapshot];
    return memento;
}
@end
