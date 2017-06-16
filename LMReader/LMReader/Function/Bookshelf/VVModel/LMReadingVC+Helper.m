//
//  LMReadingVC+Helper.m
//  LMReader
//
//  Created by 于君 on 16/5/30.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMReadingVC+Helper.h"

#import <objc/runtime.h>

#define NSObject_key_TopTool @"topToolBar"
#define NSObject_key_BottomTool @"bottomToolBar"
@implementation LMReadingVC (Helper)

- (UIToolbar*)topToolBar
{
    return objc_getAssociatedObject(self, NSObject_key_TopTool);;
}

- (void)setTopToolBar:(UIToolbar *)topToolBar
{
    [self willChangeValueForKey:@"topToolBar"];
    objc_setAssociatedObject(self, NSObject_key_TopTool, topToolBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"topToolBar"];
}

- (void)setBottomToolBar:(UIToolbar *)bottomToolBar
{
    [self willChangeValueForKey:@"topToolBar"];
    objc_setAssociatedObject(self, NSObject_key_BottomTool, bottomToolBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"topToolBar"];
}

- (UIToolbar *)bottomToolBar
{
    return objc_getAssociatedObject(self, NSObject_key_BottomTool);;
}
- (void)addNavBar;
{
    if (!self.topToolBar) {
        UIToolbar *tool =[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        
        tool.delegate = self;
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"书架" style:UIBarButtonItemStylePlain target:self action:@selector(_toolAction:)];
        [tool setItems:@[item1]];
        
        self.topToolBar =tool;
        self.topToolBar.transform = CGAffineTransformMakeTranslation(0, -64);
        [self.view addSubview:self.topToolBar];
        
    }
    
}
- (void)addBottomToolBar;
{
    if (!self.bottomToolBar) {
        UIToolbar *tool =[[UIToolbar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49)];
        tool.delegate = self;
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"主题" style:UIBarButtonItemStylePlain target:self action:@selector(_toolAction:)];
        item1.tag = 20;

        UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"字体" style:UIBarButtonItemStylePlain target:self action:@selector(_toolAction:)];
        item2.tag = 21;

        UIBarButtonItem *item3 = [[UIBarButtonItem alloc]initWithTitle:@"目录" style:UIBarButtonItemStylePlain target:self action:@selector(_toolAction:)];
        item3.tag = 22;

        UIBarButtonItem *item4 = [[UIBarButtonItem alloc]initWithTitle:@"进度" style:UIBarButtonItemStylePlain target:self action:@selector(_toolAction:)];
        
        item4.tag = 23;
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [tool setItems:@[item3,spaceItem,item4,spaceItem,item1,spaceItem,item2]];
        self.bottomToolBar =tool;
        self.bottomToolBar.transform = CGAffineTransformMakeTranslation(0, 49);
        [self.view addSubview:self.bottomToolBar];
    }
}
- (void)tapShowHideToolBar;
{
    UIViewController *demovc = [self.pageViewController viewControllers][0];
//    UIViewController *demovc = [self.modelController currentViewController];
    UIScrollView *scrollview = [demovc.view viewWithTag:100];
    scrollview.scrollEnabled = CGAffineTransformIsIdentity(self.topToolBar.transform);
    [UIView animateWithDuration:0.3 animations:^{
        if (CGAffineTransformIsIdentity(self.topToolBar.transform)) {
            self.topToolBar.transform = CGAffineTransformMakeTranslation(0, -64);
            self.bottomToolBar.transform = CGAffineTransformMakeTranslation(0, 49);
            [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
            [UIApplication sharedApplication].statusBarHidden = YES;
            
        }else
        {
            self.topToolBar.transform = CGAffineTransformIdentity;
            self.bottomToolBar.transform = CGAffineTransformIdentity ;
            [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
            [UIApplication sharedApplication].statusBarHidden = NO;
            
        }
    }];
}
- (void)panHideToolBar;
{
    [UIView animateWithDuration:0.3 animations:^{
        self.topToolBar.transform = CGAffineTransformMakeTranslation(0, -64);
        self.bottomToolBar.transform = CGAffineTransformMakeTranslation(0, 49);
        [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }];
    
}

- (void)_toolAction:(UIBarButtonItem *)item
{
    if (item.tag==20) {
//        self.view.transform = CGAffineTransformIsIdentity(self.view.transform)?CGAffineTransformMakeTranslation(100, 0):CGAffineTransformIdentity;
        [LMGoble sharedGoble].theme = STThemeBlack;
        [self changeCompose];
    }else if (item.tag==21)
    {
        [self showOrHideSettingView];
    }else if (item.tag==22)
    {
        if (!self.coverView) {
            self.coverView = [[UIView alloc] init];
            self.coverView.frame = SCREEN_BOUNDS;
            self.coverView.backgroundColor = RGBA(0, 0, 0, 0);
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
            [self.coverView addGestureRecognizer:tapGesture];
            UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
            [self.coverView addGestureRecognizer:panGesture];
            
        }
        
        [self.view addSubview:self.coverView];
        
        if (!self.catelogVC) {
            self.catelogVC = [[LMCatelogVCViewController alloc] init];
        }
        LMCatelogVCViewController *cateVC = self.catelogVC;
        cateVC.view.frame = CGRectMake(-(SCREEN_WIDTH-40), 0, SCREEN_WIDTH-40, SCREEN_HEIGHT);
        [self addChildViewController:cateVC];
        [self.view addSubview:cateVC.view];
        [cateVC didMoveToParentViewController:self];
        [UIView animateWithDuration:0.5 animations:^{
            cateVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH-40, SCREEN_HEIGHT);
            self.coverView.backgroundColor = RGBA(0, 0, 0, 0.5);
        }];

    }else if (item.tag == 23)//
    {
        [self showOrHideFontSettingView];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma mark -toolbar delegate
CGPoint beginP;
- (void)handleTapGesture:(UIGestureRecognizer *)gesture
{
    if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
        [UIView animateWithDuration:0.5 animations:^{
            self.catelogVC.view.frame = CGRectMake(-(SCREEN_WIDTH-40), 0, SCREEN_WIDTH-40, SCREEN_HEIGHT);
            self.coverView.backgroundColor = RGBA(0, 0, 0, 0);

        } completion:^(BOOL finished) {
            [self.catelogVC willMoveToParentViewController:nil];
            [self.catelogVC.view removeFromSuperview];
            [self.catelogVC removeFromParentViewController];
            [self.coverView removeFromSuperview];
            
        }];
        return;
    }
    if (gesture.state==UIGestureRecognizerStateBegan) {
        beginP = [gesture locationInView:self.coverView];
    }else if (gesture.state==UIGestureRecognizerStateChanged)
    {
        CGPoint moveP = [gesture locationInView:self.coverView];
        if (moveP.x>beginP.x) {
            return;
        }
        self.catelogVC.view.x = 0 -beginP.x+moveP.x;
        self.coverView.backgroundColor = RGBA(0, 0, 0, 0.5-0.5*(beginP.x-moveP.x)/(SCREEN_WIDTH-40));
    }else if (gesture.state==UIGestureRecognizerStateEnded)
    {
        CGPoint moveP = [gesture locationInView:self.coverView];
        
        [UIView animateWithDuration:0.2 animations:^{
            if (beginP.x-moveP.x>SCREEN_WIDTH/4||beginP.x==moveP.x) {
                self.catelogVC.view.frame = CGRectMake(-(SCREEN_WIDTH-40), 0, SCREEN_WIDTH-40, SCREEN_HEIGHT);
                self.coverView.backgroundColor = RGBA(0, 0, 0, 0);
               
            }else
            {
                self.catelogVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH-40, SCREEN_HEIGHT);
                self.coverView.backgroundColor = RGBA(0, 0, 0, 0.5);
            }
        } completion:^(BOOL finished) {
            if (beginP.x-moveP.x>SCREEN_WIDTH/4||beginP.x==moveP.x)
            {
                [self.catelogVC willMoveToParentViewController:nil];
                [self.catelogVC.view removeFromSuperview];
                [self.catelogVC removeFromParentViewController];
                [self.coverView removeFromSuperview];
            }
            
        }];
    }
    
}
- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar;
{
    if (bar != self.bottomToolBar) {
        return UIBarPositionTopAttached;
    }
    return UIBarPositionBottom;
}
@end
