//
//  WHTabScrollView.h
//  WHTabPagerViewController
//
//  Created by 于君 on 16/8/18.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WHTabScrollDelegate;

@interface WHTabScrollView : UIScrollView

@property (weak, nonatomic) id<WHTabScrollDelegate> tabScrollDelegate;

- (instancetype)initWithFrame:(CGRect)frame tabViews:(NSArray *)tabViews tabBarHeight:(CGFloat)height tabColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor selectedTabIndex:(NSInteger)index;
- (instancetype)initWithFrame:(CGRect)frame tabViews:(NSArray *)tabViews tabBarHeight:(CGFloat)height tabColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor;

- (void)animateToTabAtIndex:(NSInteger)index;
- (void)animateToTabAtIndex:(NSInteger)index animated:(BOOL)animated;

@end

@protocol WHTabScrollDelegate <NSObject>

- (void)tabScrollView:(WHTabScrollView *)tabScrollView didSelectTabAtIndex:(NSInteger)index;

@end
