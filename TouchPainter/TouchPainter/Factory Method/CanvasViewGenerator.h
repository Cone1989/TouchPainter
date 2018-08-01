/*
 使用工厂方法加载视图。
 传递不同的工厂，则生成不同的视图。
 
 简单工厂需要传入类型，在工厂类中根据判断生成对象，如果增加一种类型，则工厂需要修改。
 对于调用方，需要传递类型。
 
 工厂方式相对于简单工厂来说，业务逻辑在各个工厂内部实现。扩展只需要添加相应的工厂即可。
 对于调用方，需要传递工厂子类。
 
 工厂方式满足了开闭原则。
 */
#import <Foundation/Foundation.h>
#import "CanvasView.h"
@interface CanvasViewGenerator : NSObject
- (CanvasView*)canvasViewWithFrame:(CGRect)aFrame;
@end
