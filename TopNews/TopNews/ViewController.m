//
//  ViewController.m
//  GUITabPagerViewController
//
//  Created by Guilherme Araújo on 27/02/15.
//  Copyright (c) 2015 Guilherme Araújo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <WHTabPagerDataSource, WHTabPagerDelegate>

@end

@implementation ViewController

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setDataSource:self];
  [self setDelegate:self];
    [self reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
}

#pragma mark - Tab Pager Data Source

- (NSInteger)numberOfViewControllers {
  return 5;
}

- (UIViewController *)viewControllerForIndex:(NSInteger)index {
  UIViewController *vc = [UIViewController new];
  [[vc view] setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(255) / 255.0f
                                                green:arc4random_uniform(255) / 255.0f
                                                 blue:arc4random_uniform(255) / 255.0f alpha:1]];
  return vc;
}

// Implement either viewForTabAtIndex: or titleForTabAtIndex:
//- (UIView *)viewForTabAtIndex:(NSInteger)index {
//  return <#UIView#>;
//}
//- (CGRect)tabFrame
//{
//    return CGRectMake(0, 64, 320, 44);
//}
- (NSString *)titleForTabAtIndex:(NSInteger)index {
  return [NSString stringWithFormat:@"Tab #%ld", (long) index + 1];
}

- (CGFloat)tabHeight {
  // Default: 44.0f
  return 44;
}

- (UIColor *)tabColor {
  // Default: [UIColor orangeColor];
  return [UIColor blueColor];
}

- (UIColor *)tabBackgroundColor {
  // Default: [UIColor colorWithWhite:0.95f alpha:1.0f];
  return [UIColor whiteColor];
}

- (UIFont *)titleFont {
  // Default: [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0f];
  return [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f];
}

- (UIColor *)titleColor {
  // Default: [UIColor blackColor];
  return [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
}

#pragma mark - Tab Pager Delegate

- (void)tabPager:(WHTabPagerViewController *)tabPager willTransitionToTabAtIndex:(NSInteger)index {
  NSLog(@"Will transition from tab %ld to %ld", [self selectedIndex], (long)index);
}

- (void)tabPager:(WHTabPagerViewController *)tabPager didTransitionToTabAtIndex:(NSInteger)index {
  NSLog(@"Did transition to tab %ld", (long)index);
}

@end
