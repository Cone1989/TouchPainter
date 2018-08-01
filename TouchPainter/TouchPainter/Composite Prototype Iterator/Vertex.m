//
//  Vertex.m
//  TouchPainter
//
//  Created by hxsd on 2018/7/19.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "Vertex.h"

@implementation Vertex
@dynamic color,size;

// 默认属性什么也不做
- (void)setColor:(UIColor *)color {}
- (UIColor *)color {return nil;}
- (void)setSize:(CGFloat)size {}
- (CGFloat)size {return 0.0;}

// Mark操作什么也不做
- (void)addMark:(id<Mark>)mark {}
- (void)removeMark:(id<Mark>)mark {}
- (id<Mark>)childMarkAtIndex:(NSUInteger)index {return nil;}
- (id<Mark>)lastChild {return nil;}
- (NSUInteger)count {return 0;}

- (void)acceptMarkVisitor:(id<MarkVisitor>)visitor {
    [visitor visitVertex:self];
}

- (void)drawWithContext:(CGContextRef)context {
    CGFloat x = self.location.x;
    CGFloat y = self.location.y;
    CGContextAddLineToPoint(context, x, y);
}

#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _location = [[aDecoder decodeObjectForKey:@"VertexLocation"] CGPointValue];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[NSValue valueWithCGPoint:_location] forKey:@"VertexLocation"];
}
#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    Vertex *vertex = [[self class] allocWithZone:zone];
    vertex.location = _location;
    return vertex;
}
@end
