//
//  UIView+UIImage.m
//  TouchPainter
//
//  Created by hxsd on 2018/7/31.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "UIView+UIImage.h"

@implementation UIView (UIImage)
- (UIImage*)image {
    CGSize imageSize = [self bounds].size;
    // 使用系统提供api判断版本
//    if (@available(iOS 4.0,*)) {
//        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
//    }else{
//        UIGraphicsBeginImageContext(imageSize);
//    }
    
    // 因为UIGraphicsBeginImageContextWithOptions是C函数，因此这里直接判断函数指针是否等于NULL
    if (NULL != UIGraphicsBeginImageContextWithOptions) {
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    }else {
        UIGraphicsBeginImageContext(imageSize);
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbnailImage;
}
@end
