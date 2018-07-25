//
//  Stroke.m
//  TouchPainter
//
//  Created by hxsd on 2018/7/19.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "Stroke.h"

@implementation Stroke

- (instancetype)init
{
    self = [super init];
    if (self) {
        _children = [NSMutableArray array];
    }
    return self;
}
- (void)setLocation:(CGPoint)location {
    // 不设定任何位置
}
- (CGPoint)location {
    // 返回第一个子节点的位置
    if ([_children count] > 0) {
        id<Mark> dot = [_children objectAtIndex:0];
        return [dot location];
    }
    // 否则返回原点
    return CGPointZero;
}
- (void)addMark:(id<Mark>)mark {
    [_children addObject:mark];
}
- (void)removeMark:(id<Mark>)mark {
    // 如果mark在这一层，将其移除并返回，否则让每个子节点去找它
    if ([_children containsObject:mark]) {
        [_children removeObject:mark];
    }else{
        [_children performSelector:@selector(removeMark:) withObject:mark];
    }
}
- (id<Mark>)childMarkAtIndex:(NSUInteger)index {
    if (index >= [_children count]) {
        return nil;
    }
    return [_children objectAtIndex:index];
}
- (id<Mark>)lastChild {
    return [_children lastObject];
}
- (NSUInteger)count {
    return [_children count];
}

- (void)acceptMarkVisitor:(id<MarkVisitor>)visitor {
    for (id<Mark> mark in _children) {
        [mark acceptMarkVisitor:visitor];
    }
    [visitor visitStroke:self];
}

- (void)drawWithContext:(CGContextRef)context {
    CGPoint point = self.location;
    CGFloat x = point.x;
    CGFloat y = point.y;
    CGContextMoveToPoint(context, x, y);
    for (id<Mark> mark in _children) {
        [mark drawWithContext:context];
    }
    CGContextSetStrokeColorWithColor(context, [self.color CGColor]);
    CGContextStrokePath(context);
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _color = [aDecoder decodeObjectForKey:@"StrokeColor"];
        _size = [aDecoder decodeFloatForKey:@"StrokeSize"];
        _children = [aDecoder decodeObjectForKey:@"StrokeChildren"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_color forKey:@"StrokeColor"];
    [aCoder encodeFloat:_size forKey:@"StrokeSize"];
    [aCoder encodeObject:_children forKey:@"StrokeChildren"];
}
@end
