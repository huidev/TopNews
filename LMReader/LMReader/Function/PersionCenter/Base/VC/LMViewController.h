//
//  LMViewController.h
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMBaseAnimtor.h"
#import <Masonry/Masonry.h>
#import "JDFPeekabooCoordinator.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "UIViewController+CustomNarbar.h"
#import "UIView+FrameAdjust.h"

typedef enum {
    UIModalTransitionStyleOpenBooks = 0x01 << 5,
    
} UIModalTransitionStyleCustom;

@interface LMViewController : UIViewController<UIGestureRecognizerDelegate>
@property (strong, nonatomic)UIView *brightnessView;
@end
