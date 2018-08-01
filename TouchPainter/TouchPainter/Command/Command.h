//
//  Command.h
//  TouchPainter
//
//  Created by hxsd on 2018/7/26.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Command : NSObject
@property(nonatomic, strong) NSDictionary *userInfo;
- (void)execute;
- (void)undo;
- (void)redo;
@end
