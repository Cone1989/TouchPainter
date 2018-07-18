/*
 ### 何时使用中介者模式:
 * 对象间的交互虽定义明确然而非常复杂，导致一组对象彼此相互依赖而且难以理解；
 * 因为对象引用了许多其他对象并与其通讯，导致对象难以复用；
 * 想要定制一个分布在多个类中的逻辑或行为，又不想生成太多子类。
 */

#import <Foundation/Foundation.h>

/*
 中介者模式需要知道所有要调度的对象
 */
#import "CanvasViewController.h"
#import "PaletteViewController.h"
#import "ThumbnailViewController.h"

typedef enum {
    kButtonTagDone,
    kButtonTagOpenPaletteView,
    kButtonTagOpenThumbnailView,
}ButtonTag;

@interface CoordinatingController : NSObject
{
    @private
    CanvasViewController *_canvasViewController;
    UIViewController *_activeViewController;
}
@property(nonatomic, strong , readonly) UIViewController *activeViewController;
@property(nonatomic, strong , readonly) CanvasViewController *canvasViewController;

/**
 中介者只需要一个，因此这里使用单例模式
 */
+ (instancetype)sharedInstance;
- (IBAction)requestViewChangeByObject:(id)object;
@end
