//
//  SaveScribbleCommand.m
//  TouchPainter
//
//  Created by hxsd on 2018/7/31.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "SaveScribbleCommand.h"
#import "CoordinatingController.h"
#import "CanvasViewController.h"
#import "UIView+UIImage.h"
@implementation SaveScribbleCommand
- (void)execute {
    CoordinatingController *coordinator = [CoordinatingController sharedInstance];
    CanvasViewController *canvasVC = coordinator.canvasViewController;
    ScribbleManager *manager = [[ScribbleManager alloc] init];
    [manager saveScribble:canvasVC.scribble thumbnail:[canvasVC.canvasView image]];
    
}
@end
