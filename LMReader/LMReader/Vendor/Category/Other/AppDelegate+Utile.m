//
//  UIApplication+Utile.m
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "AppDelegate+Utile.h"
#import "LMBookShelfVC.h"
#import "LMPersonCenterVC.h"
#import "CNNavbarView.h"
#import "NavigationController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "LMLeftViewController.h"
#import "LMBookCityVC.h"
#import <RESideMenu/RESideMenu.h>

@implementation AppDelegate (Utile)

- (void)CGApplicationLaunchConfig;
{
    [DatebaseManage sharedDatebase];
    RDVTabBarController *tabbarVC = [[RDVTabBarController alloc]init];
    
    LMBookShelfVC *shelfVC = [[LMBookShelfVC alloc]init];
    shelfVC.title = @"书架";
    NavigationController *shelfNav = [[NavigationController alloc]initWithRootViewController:shelfVC];
    
    LMPersonCenterVC *personVC = [[LMPersonCenterVC alloc]init];
    personVC.title = @"我";
    NavigationController *personNav = [[NavigationController alloc]initWithRootViewController:personVC];
    
    LMBookCityVC *cityVC = [[LMBookCityVC alloc]init];
    cityVC.title = @"书城";
    NavigationController *cityVCNav = [[NavigationController alloc]initWithRootViewController:cityVC];
    
    [tabbarVC setViewControllers:@[shelfNav,cityVCNav,personNav]];
    [self _customizeTabBarForController:tabbarVC];
    RESideMenu *sideMenu = [[RESideMenu alloc] initWithContentViewController:tabbarVC leftMenuViewController:[LMLeftViewController new] rightMenuViewController:nil];
    sideMenu.contentViewShadowEnabled = YES;
    sideMenu.backgroundImage = [UIImage imageNamed:@"personalCenterBg"];
    sideMenu.panFromEdge = NO;
    sideMenu.fadeMenuView = YES;
    sideMenu.parallaxEnabled = NO;
    sideMenu.scaleBackgroundImageView = NO;
    sideMenu.scaleContentView = NO;
    sideMenu.scaleMenuView = NO;
    self.window.rootViewController = sideMenu;
}
- (void)_customizeTabBarForController:(RDVTabBarController *)tabBarController {
//    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
//    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"bookshelftab", @"bookstoretab", @"faxiantab"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] viewItems]) {
//        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_sl",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_nl",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        item.titlePositionAdjustment = UIOffsetMake(0, 3);
        item.selectedTitleAttributes = @{
                                                                      NSFontAttributeName: [UIFont systemFontOfSize:12],
                                                                      NSForegroundColorAttributeName: LMRED,
                                                                      };
        item.unselectedTitleAttributes = @{
                                         NSFontAttributeName: [UIFont systemFontOfSize:12],
                                         NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                         };
        index++;
    }
}
@end
