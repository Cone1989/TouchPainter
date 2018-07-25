//
//  ScribbleManager.m
//  TouchPainter
//
//  Created by hxsd on 2018/7/25.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "ScribbleManager.h"

@implementation ScribbleManager
- (void)saveScribble:(Scribble *)scribble thumbnail:(UIImage *)image {
    
    // 为新的涂鸦数据及其缩略图取得新的索引值
    NSUInteger newIndex = [self numberOfScribbles] + 1;
    
    // 把索引值作为名字的一部分
    NSString *scribbleDataName = [NSString stringWithFormat:@"data_%lu",(unsigned long)newIndex];
    NSString *scribbleThumbnailName = [NSString stringWithFormat:@"thumbnail_%lu.png",(unsigned long)newIndex];
    
    // 从涂鸦获取备忘录，然后保存
    ScribbleMemento *memento = [scribble scribbleMemento];
    NSData *mementoData = [memento data];
    NSString *mementoPath = [[self scribbleDataPath] stringByAppendingPathComponent:scribbleDataName];
    [mementoData writeToFile:mementoPath atomically:YES];
    
    // 保存缩略图
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *imagePath = [[self scribbleThumbnailPath] stringByAppendingPathComponent:scribbleThumbnailName];
    [imageData writeToFile:imagePath atomically:YES];
    
}
- (NSUInteger)numberOfScribbles {
    NSString *dataPath = [self filePath:@"Data"];
    NSArray *array = [[NSFileManager defaultManager] subpathsAtPath:dataPath];
    return array.count;
}
- (NSString*)scribbleDataPath {
    return [self filePath:@"Data"];
}
- (NSString*)scribbleThumbnailPath {
    return [self filePath:@"Image"];
}
- (NSString *)filePath:(NSString*)directoryName {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    documentPath = [documentPath stringByAppendingPathComponent:directoryName];
    return documentPath;
}
@end
