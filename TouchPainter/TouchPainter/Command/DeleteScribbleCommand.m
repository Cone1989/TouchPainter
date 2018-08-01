//
//  DeleteScribbleCommand.m
//  TouchPainter
//
//  Created by hxsd on 2018/7/26.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "DeleteScribbleCommand.h"
#import "CoordinatingController.h"
#import "CanvasViewController.h"
@implementation DeleteScribbleCommand
- (void)execute {
    CoordinatingController *coordinatingController = [CoordinatingController sharedInstance];
    CanvasViewController *canvasViewController = [coordinatingController canvasViewController];
    
    // create a new scribble for
    // canvasViewController
    Scribble *newScribble = [[Scribble alloc] init];
    [canvasViewController setScribble:newScribble];
}
@end
