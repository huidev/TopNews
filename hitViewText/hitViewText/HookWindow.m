    //
//  HookWindow.m
//  hitViewText
//
//  Created by 于君 on 15/10/15.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "HookWindow.h"

@implementation HookWindow
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *view in self.subviews) {
        if (!view.hidden && view.userInteractionEnabled && [view pointInside:[self convertPoint:point toView:view] withEvent:event])
            return YES;
    }
    return NO;
}
- (void)sendEvent:(UIEvent *)event;
{
//    if (event.type==UIEventTypeTouches) {
//        if ([[event.allTouches anyObject] phase]==UITouchPhaseBegan) {
//            //响应触摸事件（手指刚刚放上屏幕）
//            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"ddddddd" object:nil userInfo:[NSDictionary dictionaryWithObject:event forKey:@"data"]]];
//            //发送一个名为‘nScreenTouch’（自定义）的事件
//        }else if([[event.allTouches anyObject] phase]==UITouchPhaseEnded)
//        {
//            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"UITouchPhaseEnded" message:@"become key window" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
//            [alertV show];
//        }else if([[event.allTouches anyObject] phase]==UITouchPhaseCancelled)
//        {
//            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"UITouchPhaseCancelled" message:@"become key window" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
//            [alertV show];
//        }else if([[event.allTouches anyObject] phase]==UITouchPhaseStationary)
//        {
//            UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"UITouchPhaseStationary" message:@"become key window" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
//            [alertV show];
//        }
//            
//            
//    }else if (event.type == UIEventSubtypeMotionShake)
//    {
//        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"" message:@"shake" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
//        [alertV show];
//    }
    [super sendEvent:event];
    
}
- (BOOL)canBecomeFirstResponder;
{
    return NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
