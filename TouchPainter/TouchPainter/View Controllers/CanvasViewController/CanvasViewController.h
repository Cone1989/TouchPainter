//
//  CanvasViewController.h
//  TouchPainter
//
//  Created by hxsd on 2018/7/18.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scribble.h"
#import "CanvasView.h"
@interface CanvasViewController : UIViewController
{
    @private
    CGPoint _startPoint;
    UIColor *_strokeColor;
    CGFloat _strokeSize;
}
@property(nonatomic, strong) CanvasView *canvasView;
@property(nonatomic, strong) Scribble *scribble;
@end
