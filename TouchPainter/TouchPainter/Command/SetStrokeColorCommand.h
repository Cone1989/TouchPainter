//
//  SetStrokeColorCommand.h
//  TouchPainter
//
//  Created by hxsd on 2018/7/31.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Command.h"

@class SetStrokeColorCommand;

@protocol SetStrokeColorCommandDataSource <NSObject>
- (void)command:(SetStrokeColorCommand*)command didRequestColorComponentsForRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue;
@end

@protocol SetStrokeColorCommandDelegate <NSObject>
- (void)command:(SetStrokeColorCommand*)command didFinishColorUpdateWithColor:(UIColor*)color;
@end

@interface SetStrokeColorCommand : Command
@property(nonatomic , weak)IBOutlet id<SetStrokeColorCommandDataSource> dataSource;
@property(nonatomic , weak)IBOutlet id<SetStrokeColorCommandDelegate> delegate;
@end
