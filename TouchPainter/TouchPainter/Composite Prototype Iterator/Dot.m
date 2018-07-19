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

@end
