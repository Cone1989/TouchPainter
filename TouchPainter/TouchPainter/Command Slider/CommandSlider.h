//
//  CommandSlider.h
//  TouchPainter
//
//  Created by hxsd on 2018/7/31.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Command.h"
@interface CommandSlider : UISlider
@property(nonatomic, strong) IBOutlet Command *cmd;
@end
