//
//  UIViewController+CustomNarbar.m
//  TopNews
//
//  Created by 于君 on 16/8/19.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "UIViewController+CustomNarbar.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "MacroFunctions.h"

@implementation NSObject (MJRefresh)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}
@end

@implementation UIViewController (CustomNarbar)
@dynamic navbar;

static const char CNNarbarKey = '\0';

- (void)setNavbar:(CNNavbarView *)navbar
{
    // 存储新的
    [self willChangeValueForKey:@"navbar"]; // KVO
    objc_setAssociatedObject(self, &CNNarbarKey,
                             navbar, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"navbar"]; // KVO
}
- (CNNavbarView *)navbar
{
    return objc_getAssociatedObject(self, &CNNarbarKey);
}
- (void)setWHBarTintcolor:(UIColor*)tintcolor;
{
    [self _createCustomBar];
//    self.navbar.barTintColor = LMRED;
}
- (void)setBarTitle:(NSString *)title;
{
    [self _createCustomBar];
    [self.navbar setTitle:title];
}

- (void)_createCustomBar
{
    CNNavbarView * _viewNaviBar =objc_getAssociatedObject(self, &CNNarbarKey);
    if (!_viewNaviBar) {
        self.fd_prefersNavigationBarHidden = YES;
        _viewNaviBar = [[CNNavbarView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CNNavbarView barSize].width, [CNNavbarView barSize].height)];
//        _viewNaviBar.barTintColor = LMRED;
        [_viewNaviBar setBackgroundImage:[UIImage imageNamed:@"topline"] forBarMetrics:UIBarMetricsDefault];
        _viewNaviBar.m_viewCtrlParent = self;
        [self.view addSubview:_viewNaviBar];
        [self setNavbar:_viewNaviBar];
    }
}

@end
