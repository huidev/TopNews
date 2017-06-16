//
//  ModelController.h
//  pageviewController
//
//  Created by 于君 on 16/3/15.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoTextViewController.h"

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DemoTextViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DemoTextViewController *)viewController;

@end

