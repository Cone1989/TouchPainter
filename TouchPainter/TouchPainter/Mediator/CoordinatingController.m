//
//  CoordinatingController.m
//  TouchPainter
//
//  Created by hxsd on 2018/7/18.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "CoordinatingController.h"

@interface CoordinatingController()<NSCopying>

@end
static CoordinatingController *sharedCoordinator = nil;

@implementation CoordinatingController


/**
 **不能使用该方法做控制器的初始化。**
 init会执行两次:
 * sharedCoordinator = [[super allocWithZone:NULL] init];
 * initWithCoder:内部会调用一次。
 
 这样就导致控制器不是原来的哪一个
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
//        _canvasViewController = [[CanvasViewController alloc] init];
//        _activeViewController = _canvasViewController;
    }
    return self;
}
- (void)initialize {
    _canvasViewController = [[CanvasViewController alloc] init];
    _activeViewController = _canvasViewController;
}
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCoordinator = [[super allocWithZone:NULL] init];
        [sharedCoordinator initialize];
    });
    return sharedCoordinator;
}
// 从不同xib中加载的对象，最终都会在这里分配空间，为了保证单例，这里返回我们的单例对象。
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (IBAction)requestViewChangeByObject:(id)object {
    if ([object isKindOfClass:[UIBarButtonItem class]]) {
        UIBarButtonItem *item = (UIBarButtonItem*)object;
        switch (item.tag) {
            case kButtonTagOpenPaletteView:
            {
                PaletteViewController *controller = [[PaletteViewController alloc] init];
                [_canvasViewController presentViewController:controller animated:YES completion:nil];
                
                _activeViewController = controller;
            }
                break;
            case kButtonTagOpenThumbnailView:
            {
                ThumbnailViewController *controller = [[ThumbnailViewController alloc] init];
                [_canvasViewController presentViewController:controller animated:YES completion:nil];
                
                _activeViewController = controller;
            }
                break;
            default:
            {
                [_canvasViewController dismissViewControllerAnimated:YES completion:nil];
                
                _activeViewController = _canvasViewController;
            }
                break;
        }
    }else {
        [_canvasViewController dismissViewControllerAnimated:YES completion:nil];
        
        _activeViewController = _canvasViewController;
    }
}
@end
