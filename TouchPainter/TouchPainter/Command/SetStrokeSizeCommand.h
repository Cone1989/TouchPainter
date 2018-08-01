//
//  SetStrokeSizeCommand.h
//  TouchPainter
//
//  Created by hxsd on 2018/7/31.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Command.h"

@class SetStrokeSizeCommand;

@protocol SetStrokeSizeCommandDataSource <NSObject>
- (CGFloat)commandDidRequestStrokeSize:(SetStrokeSizeCommand*)command;
@end

@interface SetStrokeSizeCommand : Command
@property(nonatomic , weak) IBOutlet id<SetStrokeSizeCommandDataSource> dataSource;
@end
