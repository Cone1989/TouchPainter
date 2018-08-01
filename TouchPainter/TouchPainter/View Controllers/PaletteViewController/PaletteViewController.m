//
//  PaletteViewController.m
//  TouchPainter
//
//  Created by hxsd on 2018/7/18.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "PaletteViewController.h"

@interface PaletteViewController ()
@property (weak, nonatomic) IBOutlet CommandSlider *redSlider;
@property (weak, nonatomic) IBOutlet CommandSlider *greenSlider;
@property (weak, nonatomic) IBOutlet CommandSlider *blueSlider;
@property (weak, nonatomic) IBOutlet UIView *PaletteView;
@property (weak, nonatomic) IBOutlet CommandSlider *sizeSlider;

@end

@implementation PaletteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    CGFloat red = [userDefaults floatForKey:@"red"];
    CGFloat green = [userDefaults floatForKey:@"green"];
    CGFloat blue = [userDefaults floatForKey:@"blue"];
    CGFloat size = [userDefaults floatForKey:@"size"];
    _redSlider.value = red;
    _greenSlider.value = green;
    _blueSlider.value = blue;
    _sizeSlider.value = size == 0 ? 5 : size;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setFloat:_redSlider.value forKey:@"red"];
    [userDefaults setFloat:_greenSlider.value forKey:@"green"];
    [userDefaults setFloat:_blueSlider.value forKey:@"blue"];
    [userDefaults setFloat:_sizeSlider.value forKey:@"size"];
}
- (IBAction)commandSliderValueChanged:(CommandSlider *)sender {
    [sender.cmd execute];
}

#pragma mark - SetStrokeColorDataSource
- (void)command:(SetStrokeColorCommand *)command didRequestColorComponentsForRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue {
    *red = self.redSlider.value;
    *green = self.greenSlider.value;
    *blue = self.blueSlider.value;
}
#pragma mark - SetStrokeColorDelegate
- (void)command:(SetStrokeColorCommand *)command didFinishColorUpdateWithColor:(UIColor *)color {
    self.PaletteView.backgroundColor = color;
}
#pragma mark - SetStrokeSizeDataSource
- (CGFloat)commandDidRequestStrokeSize:(SetStrokeSizeCommand *)command {
    return self.sizeSlider.value;
}
@end
