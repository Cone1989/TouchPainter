//
//  MarkVisitor.h
//  TouchPainter
//
//  Created by hxsd on 2018/7/19.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import <UIKit/UIKit.h>


// 这里使用协议，是因为不确定将来MarkVisitor的实现类是否需要子类化其他的类来提供服务。
@protocol Mark;
@class Dot,Vertex,Stroke;
@protocol MarkVisitor <NSObject>

- (void)visitMark:(id<Mark>)mark;
- (void)visitDot:(Dot*)dot;
- (void)visitVertex:(Vertex*)vertex;
- (void)visitStroke:(Stroke*)stroke;

@end
