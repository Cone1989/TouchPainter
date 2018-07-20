//
//  CanvasViewController.m
//  TouchPainter
//
//  Created by hxsd on 2018/7/18.
//  Copyright © 2018年 hxsd. All rights reserved.
//

#import "CanvasViewController.h"
#import "Dot.h"
#import "Stroke.h"

@interface CanvasViewController ()

@end

@implementation CanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _strokeColor = [UIColor redColor];
    _strokeSize = 5.0;
    
    Scribble *scribble = [[Scribble alloc] init];
    [self setScribble:scribble];
    
    CGRect aFrame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 200);
    CanvasView *aCanvasView = [[CanvasView alloc] initWithFrame:aFrame];
    [self setCanvasView:aCanvasView];
    
    [self.view addSubview:_canvasView];
}

- (void)setScribble:(Scribble *)scribble {
    _scribble = scribble;
    [_scribble addObserver:self forKeyPath:@"mark" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"mark"]) {
        id<Mark> mark = [change objectForKey:NSKeyValueChangeNewKey];
        [_canvasView setMark:mark];
        [_canvasView setNeedsDisplay];
    }
}
#pragma mark - Touch Event Handlers
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 记录起始点
    _startPoint = [[touches anyObject] locationInView:_canvasView];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint lastPoint = [[touches anyObject] previousLocationInView:_canvasView];
    // 添加线条
    if (CGPointEqualToPoint(lastPoint, _startPoint)) {
        id<Mark> newStroke = [[Stroke alloc] init];
        [newStroke setColor:_strokeColor];
        [newStroke setSize:_strokeSize];
        [_scribble addMark:newStroke shouldAddToPreviousMark:NO];
    }
    
    // 把当前点作为顶点添加到线条
    CGPoint thisPoint = [[touches anyObject] locationInView:_canvasView];
    Vertex *vertex = [[Vertex alloc] init];
    [vertex setLocation:thisPoint];
    [_scribble addMark:vertex shouldAddToPreviousMark:YES];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint lastPoint = [[touches anyObject] previousLocationInView:_canvasView];
    CGPoint thisPoint = [[touches anyObject] locationInView:_canvasView];
    // 如果前一个点和当前点是同一个点。则没有移动，添加一个点。
    if (CGPointEqualToPoint(lastPoint, thisPoint)) {
        Dot *singleDot = [[Dot alloc] init];
        [singleDot setLocation:thisPoint];
        [singleDot setColor:_strokeColor];
        [singleDot setSize:_strokeSize];
        [_scribble addMark:singleDot shouldAddToPreviousMark:NO];
    }
    _startPoint = CGPointZero;
    
    // 如果是线条的点，用不着画它，因为一个点的差别看不出来
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _startPoint = CGPointZero;
}
@end
