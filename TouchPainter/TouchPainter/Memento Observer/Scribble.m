//
//  Scribble.m
//  TouchPainter
//
//  Created by hxsd on 2018/7/20.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "Scribble.h"
#import "Stroke.h"

@interface Scribble()
{
    id<Mark> _parentMark;
}
// 用于触发kvo
@property(nonatomic, strong) id<Mark> mark;


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
    [self didChangeValueForKey:@"mark"];
}
@end
