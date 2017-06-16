//
//  AppDelegate.m
//  TopNews
//
//  Created by 于君 on 16/8/18.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "AppDelegate.h"
#import <RESideMenu/RESideMenu.h>
#import "ViewController.h"
#import "RDVTabBarController.h"
#import "UIViewController+CustomNarbar.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    self.window.rootViewController = [self rootViewController];
    [self.window makeKeyAndVisible];
    return YES;
}
- (UIViewController *)rootViewController
{
    RDVTabBarController *tabVC = [[RDVTabBarController alloc] init];
    [tabVC useCustomNarbar];
    ViewController *vc1 = [ViewController new];
    vc1.title = @"home";
    ViewController *vc2 = [ViewController new];
    vc2.title = @"home2";
    tabVC.viewControllers = @[vc1,vc2];
    UIViewController *vc3 = [UIViewController new];
    vc3.view.backgroundColor = [UIColor redColor];
    [vc3 useCustomNarbar];
    RESideMenu *sideMenu = [[RESideMenu alloc] initWithContentViewController:[[UINavigationController alloc] initWithRootViewController:tabVC] leftMenuViewController:vc3 rightMenuViewController:nil];
    
    sideMenu.panFromEdge = NO;
    sideMenu.fadeMenuView = YES;
    sideMenu.parallaxEnabled = NO;
    sideMenu.scaleBackgroundImageView = NO;
    sideMenu.scaleContentView = NO;
    sideMenu.scaleMenuView = NO;
    return sideMenu;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
