//
//  DrawScribbleCommand.h
//  TouchPainter
//
//  Created by hxsd on 2018/7/26.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "Command.h"
#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString * const ScribbleObjectUserInfoKey;
UIKIT_EXTERN NSString * const MarkObjectUserInfoKey;
UIKIT_EXTERN NSString * const AddToPreviousMarkUserInfoKey;

@interface DrawScribbleCommand : Command

@end
