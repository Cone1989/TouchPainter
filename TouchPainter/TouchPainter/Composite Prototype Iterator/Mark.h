//
//  Mark.h
//  TouchPainter
//
//  Created by hxsd on 2018/7/19.
//  Copyright © 2018年 hxsd. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MarkVisitor.h"

@protocol Mark <NSObject,NSCoding,NSCopying>

@property(nonatomic, strong) UIColor *color;
@property(nonatomic , assign)CGFloat size;
@property(nonatomic , assign)CGPoint location;
@property(nonatomic , assign , readonly)NSUInteger count;
@property (nonatomic, readonly) id <Mark> lastChild;

/*
 原型模式:使用原型实例指定创建对象的种类，并通过复制这个原型创建新的对象。
 在CocoaTouch中，NSObject就是抽象类，定义了接口`-(id)copy`。子类通过遵守`NSCopying`协议，实现`-(id)copyWithZone:`方法即可复制自己。
 */
- (id)copy;

- (void)addMark:(id<Mark>)mark;
- (void)removeMark:(id<Mark>)mark;
- (id<Mark>)childMarkAtIndex:(NSUInteger)index;

- (void) acceptMarkVisitor:(id <MarkVisitor>) visitor;


/*
 一个不够好的示例，当要添加新功能时，总是要修改协议及其实现类。
 */
// 所有节点都可以绘制，添加一个公共绘制方法。
- (void)drawWithContext:(CGContextRef)context;
@end
