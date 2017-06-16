//
//  AppDelegate.h
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CEReversibleAnimationController.h"
#import "CEHorizontalSwipeInteractionController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CEReversibleAnimationController *navigationControllerAnimationController;
@property (strong, nonatomic) CEHorizontalSwipeInteractionController *navigationControllerInteractionController;
@end

