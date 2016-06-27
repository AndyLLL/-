//
//  MyView.m
//  手势
//
//  Created by Hao on 16/5/10.
//  Copyright © 2016年 xinguo. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //6种手势
        //Pan滑动 Pinch捏合 Tap点击 Swipe轻扫 LongPress长按 Rotation旋转
        
        //点击手势
        //创建一个手势识别器对象并绑定一个方法
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        //需要点击的次数
        //tapGesture.numberOfTapsRequired = 2;
        //需要手指的个数
        //tapGesture.numberOfTouchesRequired = 2;
        //把手势识别器添加给某一个视图
        [self addGestureRecognizer:tapGesture];
        
        //滑动手势
        UIPanGestureRecognizer *panGeture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:panGeture];
        
        //捏合手势
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
        [self addGestureRecognizer:pinchGesture];
        
        //轻扫手势
        UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe)];
        [self addGestureRecognizer:swipeGesture];
        
        //旋转手势
        UIRotationGestureRecognizer *rotationGeture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotation:)];
        rotationGeture.delegate = self;
        [self addGestureRecognizer:rotationGeture];
        
        //长按手势
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPressGesture];
    }
    return self;
    
}

- (void)tap
{
    NSLog(@"图片被点击了");
}

- (void)pan:(UIPanGestureRecognizer *)recognizer
{
    NSLog(@"pan");
    
    //获取到手势滑动之后相对于self.view的距离
    CGPoint point = [recognizer translationInView:[self superview]];
    
    CGPoint centerPoint = self.center;
    centerPoint.x += point.x;
    centerPoint.y += point.y;
    self.center = centerPoint;
    
    //每次让view跟着滑动之后就要把手势识别器中记录的距离清0
    [recognizer setTranslation:CGPointZero inView:[self superview]];
}

- (void)pinch:(UIPinchGestureRecognizer *)recognizer
{
    NSLog(@"pinch  %f",recognizer.scale);
    
    //从某一个状态持续缩放
    self.transform = CGAffineTransformScale(self.transform, recognizer.scale, recognizer.scale);
    
    recognizer.scale = 1;
}

- (void)swipe
{
    NSLog(@"swipe");
}

- (void)rotation:(UIRotationGestureRecognizer *)recognizer
{
    NSLog(@"rotation  %f",recognizer.rotation);
    
    self.transform = CGAffineTransformRotate(self.transform, recognizer.rotation);
    
    recognizer.rotation = 0;
}

//同时支持两个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)longPress:(UILongPressGestureRecognizer *)recognizer
{
    NSLog(@"longpress");
    
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        UIMenuItem *item1 = [[UIMenuItem alloc]initWithTitle:@"重置" action:@selector(reset)];
        UIMenuItem *item2 = [[UIMenuItem alloc]initWithTitle:@"复制文字" action:@selector(copyString)];
        
        UIMenuController *controller = [UIMenuController sharedMenuController];
        controller.menuItems = @[item1,item2];
        
        //获取到点击的位置
        CGPoint point = [recognizer locationInView:self];
        
        //让当前显示的view成为第一响应者
        [self becomeFirstResponder];
        
        //设置显示的位置
        [controller setTargetRect:CGRectMake(point.x, point.y, 0, 0) inView:self];
        
        //让这个controller可见
        [controller setMenuVisible:YES animated:YES];
    }
}

//重写方法，让view可以成为第一响应者
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)reset
{
    //回到最初的状态，把所有的变换都取消掉
    self.transform = CGAffineTransformIdentity;
}

- (void)copyString
{
    //复制文字到剪贴板
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = @"abc";
}

@end
