//
//  LMCatelogAnimtor.m
//  LMReader
//
//  Created by 于君 on 16/6/13.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMCatelogAnimtor.h"

@implementation LMCatelogAnimtor

- (void)animateTransitionEvent {
    [CATransaction flush];
    self.toViewController.view.alpha   = 1.f;
    [self.containerView addSubview:self.toViewController.view];
    if(self.transitiontype==ControllerTransitionTypePush)
    {
        self.toViewController.view.transform =
        CGAffineTransformMakeTranslation(-SCREEN_WIDTH+30, 0);
    }else
    {
        self.toViewController.view.transform =
        CGAffineTransformMakeTranslation(SCREEN_WIDTH-30, 0);
    }
    
    [UIView animateWithDuration:self.transitionDuration
                          delay:0.0f
         usingSpringWithDamping:3 initialSpringVelocity:0.f options:0 animations:^{
             if (self.transitiontype==ControllerTransitionTypePush) {
                 
                 self.fromViewController.view.transform =
                 CGAffineTransformMakeTranslation(SCREEN_WIDTH-30, 0);
                 self.toViewController.view.transform =
                 CGAffineTransformMakeTranslation(0, 0);
             }else
             {
                 self.toViewController.view.transform =
                 CGAffineTransformIdentity;
                 self.fromViewController.view.transform =
                 CGAffineTransformMakeTranslation(-SCREEN_WIDTH+30, 0);
                 
             }
         } completion:^(BOOL finished) {
             
             [self completeTransition];
         }];
}

@end
