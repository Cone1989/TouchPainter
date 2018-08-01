//
//  CommandBarButton.h
//  TouchPainter
//
//  Created by hxsd on 2018/7/26.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Command.h"

@interface CommandBarButton : UIBarButtonItem
@property(nonatomic, retain)IBOutlet Command *cmd;
@end
