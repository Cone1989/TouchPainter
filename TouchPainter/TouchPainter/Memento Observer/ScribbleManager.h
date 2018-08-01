/*
 # 外观模式
 > 为系统中的一组接口提供一个统一的接口。外观定义一个高层接口，让子系统更易于使用。
 
 **何时使用外观模式**
 * 子系统正逐渐变得复杂。应用模式的过程中演化出许多类。可以使用外观为这些子系统类提供一个较简单的接口。
 * 可以使用外观对子系统进行分层。每个子系统级别有一个外观作为入口点。让它们通过其外观进行通信，可以简化它们的依赖关系。
 
 例子:有一位乘客和一辆出租车，出租车为驾驶出租车的一组复杂接口提供了一个简化了的接口。
 Car.h // 汽车
 @interface Car:NSObject
 - (void)releaseBrakes;
 - (void)changeGears;
 - (void)pressAccelerator;
 - (void)pressBrakes;
 - (void)releaseAccelerator;
 @end
 
 Taximeter.h // 计价器
 @interface Taximeter:NSObject
 - (void)start;
 - (void)stop;
 @end
 
 目前，出租车服务系统有两个子系统。需要一个CabDriver(出租车司机)作为外观以简化接口。
 CabDriver.h // 出租车司机
 #import "Car.h"
 #import "Taximeter.h"
 @interface CabDriver:NSObject
 - (void)driveToLocation:(CGPoint)x;
 @end
 
 CabDriver的外观方法决定了客户端可以用多简单的方式使用整个出租车服务系统。如前面提到的那样，客户只需要调用`driverToLocation:x`方法(这里的x是客户的目的地)，然后其余的操作就会在消息调用中发生。客户端不需要了解底层发生的一切。
 
 #import "CabDriver.h"
 @implementation CabDriver
 - (void)driveToLocation:(CGPoint)x {
    // .....
 
    // 启动计价器
    Taximeter *meter = [[Taximeter alloc] init];
    [meter start];
 
    // 操作车辆，直到抵达位置x
    Car *car = [[Car alloc] init];
    [car releaseBrakes];
    [car changeGears];
    [car pressAccelerator];
 
    // ......
 
    // 当到达了位置x，就停下车和计价器
    [car releaseAccelerator];
    [car pressBrakes];
    [meter stop];
 
    // ......
 }
 
 使用CabDriver作为外观，可以简化整个服务系统。
 
 
 在我们的应用中，将涂鸦Scribble保存起来，在必要的时候进行恢复。这个过程涉及到多个对象，它们组合在一起完成这一过程。如果不简化接口，将很容易失控，尤其是当以后需要在应用程序的其他地方对同样的操作进行复用的时候。因此需要一个ScribbleManager通过几个简化的接口来处理底层的所有复杂操作。
 
 ScribbleManager将这几个对象包装起来:
 * Scribble:涂鸦模型，保存与恢复。
 * ScribbleMemento:备忘录对象，是对Scribble要保存的结构的具体描述。
 * UIImage:缩略图，展示了保存的涂鸦的样子。
 * NSFileManager:文件管理，保存与恢复。
 
 
 */
#import <Foundation/Foundation.h>
#import "Scribble.h"
@interface ScribbleManager : NSObject
/**
 保存涂鸦模型与缩略图

 @param scribble 涂鸦模型
 @param image 缩略图
 */
- (void)saveScribble:(Scribble*)scribble thumbnail:(UIImage*)image;
/**
 当前保存的涂鸦模型的数量
 */
- (NSUInteger)numberOfScribbles;
@end
