//
//  DrawScribbleCommand.m
//  TouchPainter
//
//  Created by hxsd on 2018/7/26.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "DrawScribbleCommand.h"
#import "Scribble.h"
#import "Mark.h"

NSString * const ScribbleObjectUserInfoKey = @"ScribbleObjectUserInfoKey";
NSString * const MarkObjectUserInfoKey = @"MarkObjectUserInfoKey";
NSString * const AddToPreviousMarkUserInfoKey = @"AddToPreviousMarkUserInfoKey";


@interface DrawScribbleCommand()
@property(nonatomic, strong) Scribble *scribble;
@property(nonatomic, strong) id<Mark> mark;
@end

@implementation DrawScribbleCommand
- (void)execute {
    if (!self.userInfo) {
        return;
    }
    _scribble = [self.userInfo objectForKey:ScribbleObjectUserInfoKey];
    _mark = [self.userInfo objectForKey:MarkObjectUserInfoKey];
    BOOL shouldAddToPreviousMark = [[self.userInfo objectForKey:AddToPreviousMarkUserInfoKey] boolValue];
    [_scribble addMark:_mark shouldAddToPreviousMark:shouldAddToPreviousMark];
}
- (void)undo {
    [_scribble removeMark:_mark];
}
- (void)redo {
    [self execute];
}
@end
