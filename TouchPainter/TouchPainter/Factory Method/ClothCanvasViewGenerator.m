//
//  ClothCanvasViewGenerator.m
//  TouchPainter
//
//  Created by hxsd on 2018/8/1.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "ClothCanvasViewGenerator.h"
#import "ClothCanvasView.h"
@implementation ClothCanvasViewGenerator
- (CanvasView *)canvasViewWithFrame:(CGRect)aFrame {
    return [[ClothCanvasView alloc] initWithFrame:aFrame];
}
@end
