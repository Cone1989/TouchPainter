//
//  Mark.h
//  TouchPainter
//
//  Created by hxsd on 2018/7/19.
//  Copyright © 2018年 hxsd. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MarkVisitor.h"

@protocol Mark <NSObject,NSCoding>

@property(nonatomic, strong) UIColor *color;
@property(nonatomic , assign)CGFloat size;
@property(nonatomic , assign)CGPoint location;
@property(nonatomic , assign , readonly)NSUInteger count;
@property (nonatomic, readonly) id <Mark> lastChild;

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
