//
//  MarkPanGesture.m
//  LMReader
//
//  Created by 于君 on 16/8/31.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "MarkPanGesture.h"

@implementation MarkPanGesture
- (void)reset
{
    [super reset];
    _touchBeginPoint = CGPointZero;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
{
    [super touchesBegan:touches withEvent:event];
    _touchBeginPoint = [touches.anyObject locationInView:self.view];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if (self.state == UIGestureRecognizerStateFailed) {
        return;
    }
    CGPoint currentLocation = [touches.anyObject locationInView:self.view];
    if (fabs(currentLocation.x-_touchBeginPoint.x)<15) {
        self.failed = @NO;
        
    }else
    {
        self.failed = @YES;
        self.state = UIGestureRecognizerStateFailed;
    }
    // Determine direction
    
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
{
    [super touchesEnded:touches withEvent:event];
}
@end
