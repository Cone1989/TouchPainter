//
//  SetStrokeColorCommand.m
//  TouchPainter
//
//  Created by hxsd on 2018/7/31.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "SetStrokeColorCommand.h"
#import "CoordinatingController.h"
#import "CanvasViewController.h"
@implementation SetStrokeColorCommand
- (void)execute {
    CGFloat redValue = 0;
    CGFloat greenValue = 0;
    CGFloat blueValue = 0;
    
    // 请求数据
    [self.dataSource command:self didRequestColorComponentsForRed:&redValue green:&greenValue blue:&blueValue];
    
    UIColor *color = [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1];
    
    CoordinatingController *coordinator = [CoordinatingController sharedInstance];
    CanvasViewController *canvasVC = coordinator.canvasViewController;
    [canvasVC setStrokeColor:color];
    
    [self.delegate command:self didFinishColorUpdateWithColor:color];
}
@end
