//
//  CNNavbarView.h
//  xinjunshi
//
//  Created by 于君 on 16/8/16.
//  Copyright © 2016年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNNavbarView : UINavigationBar

@property (nonatomic, weak) UIViewController *m_viewCtrlParent;
@property (nonatomic, readonly) BOOL m_bIsCurrStateMiniMode;

- (void)layoutTheme;
+ (CGRect)rightBtnFrame;
+ (CGSize)barBtnSize;
+ (CGSize)barSize;
+ (CGRect)titleViewFrame;

// 创建一个导航条按钮：使用默认的按钮图片。
+ (UIButton *)createNormalNaviBarBtnByTitle:(NSString *)strTitle target:(id)target action:(SEL)action;

// 创建一个导航条按钮：自定义按钮图片。
+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight target:(id)target action:(SEL)action;
+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight imgSelected:(NSString *)strImgSelected target:(id)target action:(SEL)action;

// 用自定义的按钮和标题替换默认内容
- (void)setLeftBtn:(UIButton *)btn;
- (void)setRightBtn:(UIButton *)btn;
- (void)setTitle:(NSString *)strTitle;

// 在导航条上覆盖一层自定义视图。比如：输入搜索关键字时，覆盖一个输入框在上面。
- (void)showCoverView:(UIView *)view;
- (void)showCoverView:(UIView *)view animation:(BOOL)bIsAnimation;
- (void)showCoverViewOnTitleView:(UIView *)view;
- (void)hideCoverView:(UIView *)view;

@end
