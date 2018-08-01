//
//  ClothCanvasView.m
//  TouchPainter
//
//  Created by hxsd on 2018/8/1.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "ClothCanvasView.h"

@implementation ClothCanvasView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"background_texture"];
        self.backgroundColor = [UIColor colorWithPatternImage:image];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
