//
//  WHTabPagerViewController.h
//  WHTabPagerViewController
//
//  Created by 于君 on 16/8/18.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WHTabPagerDataSource;
@protocol WHTabPagerDelegate;

@interface WHTabPagerViewController : UIViewController

@property (weak, nonatomic) id<WHTabPagerDataSource> dataSource;
@property (weak, nonatomic) id<WHTabPagerDelegate> delegate;

- (void)reloadData;
- (NSInteger)selectedIndex;

- (void)selectTabbarIndex:(NSInteger)index;
- (void)selectTabbarIndex:(NSInteger)index animation:(BOOL)animation;

@end

@protocol WHTabPagerDataSource <NSObject>

@required
- (NSInteger)numberOfViewControllers;
- (UIViewController *)viewControllerForIndex:(NSInteger)index;

@optional
- (CGRect)tabFrame;
- (UIView *)viewForTabAtIndex:(NSInteger)index;
- (NSString *)titleForTabAtIndex:(NSInteger)index;
- (CGFloat)tabHeight;
- (UIColor *)tabColor;
- (UIColor *)tabBackgroundColor;
- (UIFont *)titleFont;
- (UIColor *)titleColor;

@end

@protocol WHTabPagerDelegate <NSObject>

@optional
- (void)tabPager:(WHTabPagerViewController *)tabPager willTransitionToTabAtIndex:(NSInteger)index;
- (void)tabPager:(WHTabPagerViewController *)tabPager didTransitionToTabAtIndex:(NSInteger)index;

@end