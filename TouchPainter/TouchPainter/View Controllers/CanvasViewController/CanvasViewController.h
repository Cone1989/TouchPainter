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
#import "CommandBarButton.h"
@interface CanvasViewController : UIViewController
{
    @private
    CGPoint _startPoint;
}
@property(nonatomic, strong) CanvasView *canvasView;
@property(nonatomic, strong) Scribble *scribble;
@property(nonatomic, strong) UIColor *strokeColor;
@property(nonatomic , assign)CGFloat strokeSize;
- (IBAction)onBarButtonHit:(UIBarButtonItem *)sender;
- (IBAction)onCustomBarButtonHit:(CommandBarButton*)sender;
@end
