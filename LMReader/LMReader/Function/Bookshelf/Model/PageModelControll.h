//
//  PageModelControll.h
//  LMReader
//
//  Created by 于君 on 16/5/26.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoTextViewController.h"
#import "LMReadingVC.h"

@interface PageModelControll : NSObject<UIPageViewControllerDataSource>

@property (readonly, strong, nonatomic) NSArray *pageData;
@property (strong, nonatomic) NSMutableDictionary *pageFrameset;
@property (weak, nonatomic)UITapGestureRecognizer *tap;
@property (assign, nonatomic) BOOL pageAnimationFinished;
@property (assign, nonatomic) NSInteger pageIndex;//scroll翻页时用到
@property (assign, nonatomic) NSInteger chapterIndex;
@property (nonatomic, strong) UIViewController *currentViewController;
- (DemoTextViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DemoTextViewController *)viewController;
- (void)setLastChapterToCurrent;
- (void)defaultConfig;
@end
