//
//  UIViewController+CustomNarbar.h
//  TopNews
//
//  Created by 于君 on 16/8/19.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "CNNavbarView.h"

@interface UIViewController (CustomNarbar)

@property (strong, nonatomic)CNNavbarView *navbar;

- (void)useCustomNarbar;

- (void)setBarTitle:(NSString *)title;
@end
