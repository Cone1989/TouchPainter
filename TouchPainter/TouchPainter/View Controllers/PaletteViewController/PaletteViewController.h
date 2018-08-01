//
//  PaletteViewController.h
//  TouchPainter
//
//  Created by hxsd on 2018/7/18.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommandSlider.h"
#import "SetStrokeColorCommand.h"
#import "SetStrokeSizeCommand.h"
@interface PaletteViewController : UIViewController
<SetStrokeColorCommandDataSource,
SetStrokeColorCommandDelegate,
SetStrokeSizeCommandDataSource>
- (IBAction)commandSliderValueChanged:(CommandSlider*)sender;
@end
