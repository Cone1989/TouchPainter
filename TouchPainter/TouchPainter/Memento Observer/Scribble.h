//
//  Scribble.h
//  TouchPainter
//
//  Created by hxsd on 2018/7/20.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"
#import "ScribbleMemento.h"
/*
 涂鸦模型，对应于MVC中的M。
 */
@interface Scribble : NSObject

/**
 新增一个组合结构

 @param aMark 要新增的组合结构
 @param shouldAddToPreviousMark 是否增加到上一个组合结构?根据设计，上一个组合结构应该是Stroke。如果是，那么aMark就是Stroke的一个顶点。如果不是，那么aMark添加到主结构上，这个时候aMark可能是Dot，也可能是Stroke。
 */
- (void)addMark:(id <Mark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark;
- (void)removeMark:(id<Mark>)aMark;

#pragma mark - memento methods
/**
 通过备忘录生成涂鸦模型
 */
- (instancetype)initWithMemento:(ScribbleMemento*)aMemento;
+ (instancetype)scribbleWithMemento:(ScribbleMemento*)aMemento;
/**
 获取备忘录模型。使用完整结构
 */
- (ScribbleMemento*)scribbleMemento;
/**
 获取备忘录模型。

 @param hasCompleteSnapshot 是否使用完整模型？如果不是，则使用增量模型
 @return 备忘录模型
 */
- (ScribbleMemento*)scribbleMementoWithCompleteSnapshot:(BOOL)hasCompleteSnapshot;
/**
 追加备忘录模型到涂鸦模型
 */
- (void)attachStateFromMemento:(ScribbleMemento*)memento;
@end
