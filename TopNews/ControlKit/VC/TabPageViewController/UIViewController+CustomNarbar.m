//
//  UIViewController+CustomNarbar.m
//  TopNews
//
//  Created by 于君 on 16/8/19.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "UIViewController+CustomNarbar.h"

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

- (void)useCustomNarbar;
{
    self.navigationController.navigationBarHidden = YES;
    CNNavbarView * _viewNaviBar = [[CNNavbarView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [CNNavbarView barSize].width, [CNNavbarView barSize].height)];
    _viewNaviBar.m_viewCtrlParent = self;
    [self.view addSubview:_viewNaviBar];
    [self setNavbar:_viewNaviBar];
}
- (void)setNavbar:(CNNavbarView *)navbar
{
    // 存储新的
    [self willChangeValueForKey:@"mj_header"]; // KVO
    objc_setAssociatedObject(self, &CNNarbarKey,
                             navbar, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"mj_header"]; // KVO
}
- (CNNavbarView *)getNavbar
{
    return objc_getAssociatedObject(self, &CNNarbarKey);
}
- (void)setBarTitle:(NSString *)title;
{
    
}



@end
