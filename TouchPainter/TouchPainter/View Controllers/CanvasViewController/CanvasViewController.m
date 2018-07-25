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

#define undoManagerType

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
#pragma mark -
- (IBAction) onBarButtonHit:(UIBarButtonItem*)sender
{
    if ([sender tag] == 4)
    {
        [self.undoManager undo];
    }
    else if ([sender tag] == 5)
    {
        [self.undoManager redo];
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
#ifndef undoManagerType
        [_scribble addMark:newStroke shouldAddToPreviousMark:NO];
#else
        // 绘图
        NSInvocation *drawInvocation = [self drawScribbleInvocation];
        [drawInvocation setArgument:&newStroke atIndex:2];
        
        // 撤销绘图
        NSInvocation *undrawInvocation = [self undrawScribbleInvocation];
        [undrawInvocation setArgument:&newStroke atIndex:2];
        
        // 注册
        [self executeInvocation:drawInvocation withUndoInvocation:undrawInvocation];
#endif
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
#ifndef undoManagerType
        [_scribble addMark:singleDot shouldAddToPreviousMark:NO];
#else
        // 绘图
        NSInvocation *drawInvocation = [self drawScribbleInvocation];
        [drawInvocation setArgument:&singleDot atIndex:2];
        
        // 撤销绘图
        NSInvocation *undrawInvocation = [self undrawScribbleInvocation];
        [undrawInvocation setArgument:&singleDot atIndex:2];
        
        // 注册
        [self executeInvocation:drawInvocation withUndoInvocation:undrawInvocation];
#endif
    }
    _startPoint = CGPointZero;
    
    // 如果是线条的点，用不着画它，因为一个点的差别看不出来
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _startPoint = CGPointZero;
}

#pragma mark - NSUndoManager
- (NSInvocation*)drawScribbleInvocation {
    // 生成方法签名
    NSMethodSignature *executeMethodSignature = [_scribble methodSignatureForSelector:@selector(addMark:shouldAddToPreviousMark:)];
    NSInvocation *drawInvocation = [NSInvocation invocationWithMethodSignature:executeMethodSignature];
    [drawInvocation setTarget:_scribble];
    [drawInvocation setSelector:@selector(addMark:shouldAddToPreviousMark:)];
    BOOL attachToPreviousMark = NO;
    [drawInvocation setArgument:&attachToPreviousMark atIndex:3];
    return drawInvocation;
}
- (NSInvocation*)undrawScribbleInvocation {
    NSMethodSignature *unexecuteMethodSignature = [_scribble methodSignatureForSelector:@selector(removeMark:)];
    NSInvocation *undrawInvocation = [NSInvocation invocationWithMethodSignature:unexecuteMethodSignature];
    [undrawInvocation setTarget:_scribble];
    [undrawInvocation setSelector:@selector(removeMark:)];
    return undrawInvocation;
}
- (void)executeInvocation:(NSInvocation *)invocation
        withUndoInvocation:(NSInvocation *)undoInvocation
{
    /*
     为了效率，NSInvocation默认不保存target和参数。
     因此这里需要调用retainArguments让NSInvocation对象保存这些对象，否则执行undo和redo操作的时候，如果对象被释放了就会导致崩溃。
     如果一个NSInvocation直接运行后不再使用则不需要保存。
     
     这里之所以只保存了invocation而不是连undoInvocation一起保存，是因为这两个对象的target和参数基本是一样的，保存一次不被释放即可。
     */
    [invocation retainArguments];
    // value为NSUndoManagerProxy对象
    id value = [self.undoManager prepareWithInvocationTarget:self];
    // 一开始，undo栈是空的，压入undo栈。后来是因为触发redo操作，因此也是压入undo栈
    // 给NSUndoManagerProxy对象设置撤销代理方法。
    [value
     unexecuteInvocation:undoInvocation
     withRedoInvocation:invocation];
    // 添加增量mark
    [invocation invoke];
}

- (void)unexecuteInvocation:(NSInvocation *)invocation
          withRedoInvocation:(NSInvocation *)redoInvocation
{
    // 通过undo触发，则本次的NSInvocation压入redo栈中。并设置redo代理方法。
    [[self.undoManager prepareWithInvocationTarget:self]
     executeInvocation:redoInvocation
     withUndoInvocation:invocation];
    // 删除增量mark
    [invocation invoke];
}
@end
