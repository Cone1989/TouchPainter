//
//  Mark.h
//  TouchPainter
//
//  Created by hxsd on 2018/7/19.
//  Copyright © 2018年 hxsd. All rights reserved.
//


#import <UIKit/UIKit.h>


@protocol Mark <NSObject>

@property(nonatomic, strong) UIColor *color;
@property(nonatomic , assign)CGFloat size;
@property(nonatomic , assign)CGPoint location;
@property(nonatomic , assign , readonly)NSUInteger count;
@property (nonatomic, readonly) id <Mark> lastChild;

- (void)addMark:(id<Mark>)mark;
- (void)removeMark:(id<Mark>)mark;
- (id<Mark>)childMarkAtIndex:(NSUInteger)index;


@end
