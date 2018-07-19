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
@end
