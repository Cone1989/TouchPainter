//
//  CanvasView.m
//  TouchPainter
//
//  Created by hxsd on 2018/7/20.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "CanvasView.h"
#import "MarkRenderer.h"

@implementation CanvasView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 生成绘制访问者
    MarkRenderer *render = [[MarkRenderer alloc] initWithCGContext:context];
    // 组合对象接受访问者，递归传递给结构中每一个元素，在特定类型的元素中，访问者执行特定的绘制工作。
    if (_mark) {
        [_mark acceptMarkVisitor:render];
    }
}

@end
