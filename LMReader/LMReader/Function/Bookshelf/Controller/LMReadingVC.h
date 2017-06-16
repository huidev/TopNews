//
//  LMReadingVC.h
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMViewController.h"
#import "PageModelControll.h"
#import "BookEntity.h"
#import "LMOpenBookAnimtor.h"
#import "BookNormalCell.h"
#import "LMCatelogVCViewController.h"

@interface LMReadingVC : LMViewController<UIPageViewControllerDelegate,UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>


@property (strong, nonatomic)UITapGestureRecognizer *scrollTap;
@property (strong, nonatomic) LMCatelogVCViewController *catelogVC;//目录视图
@property (strong, nonatomic) UIView *coverView;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) BookNormalCell *bookCell;

@property (strong, nonatomic) BookEntity *currentBook;
@property (copy, nonatomic)void(^drivePercent)(UIPanGestureRecognizer *recognize ,UIViewController *vc);
- (void)_chagePageViewControllerStyle:(UIPageViewControllerTransitionStyle)type;
- (void)changeCompose;
- (void)showOrHideSettingView;
- (void)showOrHideFontSettingView;
- (void)hideSettingView;
@end
