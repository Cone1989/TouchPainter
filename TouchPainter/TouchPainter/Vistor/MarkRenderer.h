//
//  MarkRenderer.h
//  TouchPainter
//
//  Created by hxsd on 2018/7/19.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarkVisitor.h"
#import "Dot.h"
#import "Vertex.h"
#import "Stroke.h"
@interface MarkRenderer : NSObject <MarkVisitor>
{
    @private
    CGContextRef _context;
    BOOL _shouldMoveContextToDot;
}
- (instancetype)initWithCGContext:(CGContextRef)context;
- (void)visitMark:(id<Mark>)mark;
- (void)visitDot:(Dot *)dot;
- (void)visitVertex:(Vertex *)vertex;
- (void)visitStroke:(Stroke *)stroke;

@end
