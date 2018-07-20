//
//  CanvasView.h
//  TouchPainter
//
//  Created by hxsd on 2018/7/20.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Mark;

@interface CanvasView : UIView

// 需要绘制的组合对象
@property(nonatomic, strong) id<Mark> mark;

@end
