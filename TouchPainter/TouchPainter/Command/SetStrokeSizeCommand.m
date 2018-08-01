//
//  SetStrokeSizeCommand.m
//  TouchPainter
//
//  Created by hxsd on 2018/7/31.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "SetStrokeSizeCommand.h"
#import "CoordinatingController.h"
#import "CanvasViewController.h"
@implementation SetStrokeSizeCommand
- (void)execute {
    CGFloat size = [self.dataSource commandDidRequestStrokeSize:self];
    
    CoordinatingController *coorinator = [CoordinatingController sharedInstance];
    CanvasViewController *canvasVC = [coorinator canvasViewController];
    [canvasVC setStrokeSize:size];
}
@end
