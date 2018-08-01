//
//  PaperCanvasViewGenerator.m
//  TouchPainter
//
//  Created by hxsd on 2018/8/1.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "PaperCanvasViewGenerator.h"
#import "PaperCanvasView.h"
@implementation PaperCanvasViewGenerator
- (CanvasView *)canvasViewWithFrame:(CGRect)aFrame {
    return [[PaperCanvasView alloc] initWithFrame:aFrame];
}
@end
