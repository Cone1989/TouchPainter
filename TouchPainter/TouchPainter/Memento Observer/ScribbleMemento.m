//
//  ScribbleMemento.m
//  TouchPainter
//
//  Created by hxsd on 2018/7/24.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "ScribbleMemento.h"
#import "ScribbleMemento+Friend.h"

@implementation ScribbleMemento
- (NSData *)data {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_mark];
    return data;
}
+ (instancetype)mementoWithData:(NSData *)data {
    id<Mark> restoredMark = (id<Mark>)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    ScribbleMemento *memento = [[ScribbleMemento alloc] initWithMark:restoredMark];
    return memento;
}
#pragma mark - private methods
- (instancetype)initWithMark:(id<Mark>)aMark {
    if (self = [super init]) {
        // 这是不对的，强引用，一个修改，另外一个也被修改
//        _mark = aMark;
        
        self.mark = aMark;
    }
    return self;
}
@end
