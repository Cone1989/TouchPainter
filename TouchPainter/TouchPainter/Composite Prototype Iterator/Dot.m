//
//  Dot.m
//  TouchPainter
//
//  Created by hxsd on 2018/7/19.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "Dot.h"

@implementation Dot
// 使用synthesize，使用系统提供的set和get方法。不会走父类的方法。
// 必须写，否则会走到父类的方法里面
@synthesize size = _size,color = _color;

- (void)acceptMarkVisitor:(id<MarkVisitor>)visitor {
    [visitor visitDot:self];
}

- (void)drawWithContext:(CGContextRef)context {
    CGFloat x = self.location.x;
    CGFloat y = self.location.y;
    CGFloat frameSize = self.size;
    CGRect frame = CGRectMake(x - frameSize / 2.0,
                              y - frameSize / 2.0,
                              frameSize,
                              frameSize);
    CGContextSetFillColorWithColor(context, [self.color CGColor]);
    CGContextFillEllipseInRect(context, frame);
}
#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _color = [aDecoder decodeObjectForKey:@"DotColor"];
        _size = [aDecoder decodeFloatForKey:@"DotSize"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_color forKey:@"DotColor"];
    [aCoder encodeFloat:_size forKey:@"DotSize"];
}
@end
