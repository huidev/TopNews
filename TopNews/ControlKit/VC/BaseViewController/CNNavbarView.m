//
//  CNNavbarView.m
//  xinjunshi
//
//  Created by 于君 on 16/8/16.
//  Copyright © 2016年 yj. All rights reserved.
//

#import "CNNavbarView.h"
#import "GlobalDefine.h"

#define FLOAT_TitleSizeNormal               19.0f
#define FLOAT_TitleSizeMini                 14.0f
#define RGB_TitleNormal                     RGB(80.0f, 80.0f, 80.0f)
#define RGB_TitleMini                       [UIColor blackColor]
#define Size(w, h)                          CGSizeMake(w, h)
#define Point(x, y)                         CGPointMake(x, y)
#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)

@interface CNNavbarView ()

@property (nonatomic, readonly) UIButton *m_btnBack;
@property (nonatomic, readonly) UILabel *m_labelTitle;
@property (nonatomic, readonly) UIImageView *m_imgViewBg;
@property (nonatomic, readonly) UIButton *m_btnLeft;
@property (nonatomic, readonly) UIButton *m_btnRight;
@property (nonatomic, readonly) BOOL m_bIsBlur;

@property (nonatomic, strong) CALayer *colorLayer;
@end

@implementation CNNavbarView

@synthesize m_btnBack = _btnBack;
@synthesize m_labelTitle = _labelTitle;
@synthesize m_imgViewBg = _imgViewBg;
@synthesize m_btnLeft = _btnLeft;
@synthesize m_btnRight = _btnRight;
@synthesize m_bIsBlur = _bIsBlur;

//static CGFloat const kDefaultColorLayerOpacity = 0.4f;
//static CGFloat const kSpaceToCoverStatusBars = 20.0f;

//- (void)setBarTintColor:(UIColor *)barTintColor {
//    CGFloat red, green, blue, alpha;
//    [barTintColor getRed:&red green:&green blue:&blue alpha:&alpha];
//    
//    UIColor *calibratedColor = [UIColor colorWithRed:red green:green blue:blue alpha:0.66];
//    [super setBarTintColor:calibratedColor];
//    
//    if (self.colorLayer == nil) {
//        self.colorLayer = [CALayer layer];
//        self.colorLayer.opacity = kDefaultColorLayerOpacity;
//        [self.layer addSublayer:self.colorLayer];
//    }
//    
//    CGFloat opacity = kDefaultColorLayerOpacity;
//    
//    CGFloat minVal = MIN(MIN(red, green), blue);
//    
//    if ([self convertValue:minVal withOpacity:opacity] < 0) {
//        opacity = [self minOpacityForValue:minVal];
//    }
//    
//    self.colorLayer.opacity = opacity;
//    
//    red = [self convertValue:red withOpacity:opacity];
//    green = [self convertValue:green withOpacity:opacity];
//    blue = [self convertValue:blue withOpacity:opacity];
//    
//    red = MAX(MIN(1.0, red), 0);
//    green = MAX(MIN(1.0, green), 0);
//    blue = MAX(MIN(1.0, blue), 0);
//    
//    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha].CGColor;
//}
//
//- (CGFloat)minOpacityForValue:(CGFloat)value
//{
//    return (0.4 - 0.4 * value) / (0.6 * value + 0.4);
//}
//
//- (CGFloat)convertValue:(CGFloat)value withOpacity:(CGFloat)opacity
//{
//    return 0.4 * value / opacity + 0.6 * value - 0.4 / opacity + 0.4;
//}
//
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    if (self.colorLayer != nil) {
//        self.colorLayer.frame = CGRectMake(0, 0 - kSpaceToCoverStatusBars, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + kSpaceToCoverStatusBars);
//        
//        [self.layer insertSublayer:self.colorLayer atIndex:1];
//    }
//}
//
//- (void)displayColorLayer:(BOOL)display {
//    self.colorLayer.hidden = !display;
//}
- (void)layoutTheme
{
//    self.barTintColor = ThemeBackgroundColor;
//    _labelTitle.textColor = ThemeTextNormalColor;
//    _btnLeft.titleLabel.textColor = ThemeTextNormalColor;
//    _btnRight.titleLabel.textColor = ThemeTextNormalColor;
//    [_btnBack setImage:[UIImage imageNamed:([ThemeManager sharedInstance].theme==CNThemeStyleDefault?@"nav_back":@"nav_back1")] forState:UIControlStateNormal];
}

+ (CGRect)rightBtnFrame
{
    return Rect(ScreenWidth-[[self class] barBtnSize].width-15, 22.0f, [[self class] barBtnSize].width, [[self class] barBtnSize].height);
}

+ (CGSize)barBtnSize
{
    return Size(50.0f, 40.0f);
}

+ (CGSize)barSize
{
    return Size(ScreenWidth, 44.0f);
}

+ (CGRect)titleViewFrame
{
    return Rect((ScreenWidth-190)/2, 22.0f, 190.0f, 40.0f);
}

// 创建一个导航条按钮：使用默认的按钮图片。
+ (UIButton *)createNormalNaviBarBtnByTitle:(NSString *)strTitle target:(id)target action:(SEL)action
{
    UIButton *btn = [[self class] createImgNaviBarBtnByImgNormal:@"NaviBtn_Normal" imgHighlight:@"NaviBtn_Normal_H" target:target action:action];
    [btn setTitle:strTitle forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    
    return btn;
}

// 创建一个导航条按钮：自定义按钮图片。
+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight target:(id)target action:(SEL)action
{
    return [[self class] createImgNaviBarBtnByImgNormal:strImg imgHighlight:strImgHighlight imgSelected:strImg target:target action:action];
}
+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight imgSelected:(NSString *)strImgSelected target:(id)target action:(SEL)action
{
    UIImage *imgNormal = [UIImage imageNamed:strImg];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:imgNormal forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:(strImgHighlight ? strImgHighlight : strImg)] forState:UIControlStateHighlighted];
//    [btn setImage:[UIImage imageNamed:(strImgSelected ? strImgSelected : strImg)] forState:UIControlStateSelected];
    
//    CGFloat fDeltaWidth = ([[self class] barBtnSize].width - imgNormal.size.width)/2.0f;
//    CGFloat fDeltaHeight = ([[self class] barBtnSize].height - imgNormal.size.height)/2.0f;
//    fDeltaWidth = (fDeltaWidth >= 2.0f) ? fDeltaWidth/2.0f : 0.0f;
//    fDeltaHeight = (fDeltaHeight >= 2.0f) ? fDeltaHeight/2.0f : 0.0f;
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(fDeltaHeight, fDeltaWidth, fDeltaHeight, fDeltaWidth)];
//    
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(fDeltaHeight, -imgNormal.size.width, fDeltaHeight, fDeltaWidth)];
    
    return btn;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _bIsBlur = YES;
        
        [self initUI];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initUI];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)initUI
{
    // 默认左侧显示返回按钮
    _btnBack = [[self class] createImgNaviBarBtnByImgNormal:@"nav_back" imgHighlight:@"nav_back" target:self action:@selector(btnBack:)];
    
    _labelTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    _labelTitle.backgroundColor = [UIColor clearColor];
    _labelTitle.textColor = RGB_TitleNormal;
    _labelTitle.font = [UIFont systemFontOfSize:FLOAT_TitleSizeNormal];
    _labelTitle.textAlignment = NSTextAlignmentCenter;
    
    _imgViewBg = [[UIImageView alloc] initWithFrame:self.bounds];
    _imgViewBg.image = [[UIImage imageNamed:@"NaviBar_Bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    _imgViewBg.alpha = 0.98f;
    
//    if (_bIsBlur)
//    {// iOS7可设置是否需要现实磨砂玻璃效果
//        _imgViewBg.alpha = 0.0f;
//        UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:self.bounds];
//        naviBar.barStyle = UIBarStyleBlack;
//        [self addSubview:naviBar];
//    }else{}
    
    _labelTitle.frame = [[self class] titleViewFrame];
    _imgViewBg.frame = self.bounds;
    
    [self addSubview:_imgViewBg];
    [self addSubview:_labelTitle];
    
    [self setLeftBtn:_btnBack];
}

- (void)setTitle:(NSString *)strTitle
{
    [_labelTitle setText:strTitle];
}

- (void)setLeftBtn:(UIButton *)btn
{
    if (_btnLeft)
    {
        [_btnLeft removeFromSuperview];
        _btnLeft = nil;
    }else{}
    
    _btnLeft = btn;
    if (_btnLeft)
    {
        _btnLeft.frame = Rect(0.0f, 22.0f, [[self class] barBtnSize].width, [[self class] barBtnSize].height);
        [self addSubview:_btnLeft];
    }else{}
}

- (void)setRightBtn:(UIButton *)btn
{
    if (_btnRight)
    {
        [_btnRight removeFromSuperview];
        _btnRight = nil;
    }else{}
    
    _btnRight = btn;
    if (_btnRight)
    {
        [self addSubview:_btnRight];
    }else{}
}

- (void)btnBack:(id)sender
{
    if (self.m_viewCtrlParent)
    {
        [self.m_viewCtrlParent.navigationController popViewControllerAnimated:YES];
    }else{
    }
}

- (void)showCoverView:(UIView *)view
{
    [self showCoverView:view animation:NO];
}
- (void)showCoverView:(UIView *)view animation:(BOOL)bIsAnimation
{
    if (view)
    {
//        [self hideOriginalBarItem:YES];
        
        [view removeFromSuperview];
        
        view.alpha = 0.4f;
        [self addSubview:view];
        if (bIsAnimation)
        {
            [UIView animateWithDuration:0.2f animations:^()
             {
                 view.alpha = 1.0f;
             }completion:^(BOOL f){}];
        }
        else
        {
            view.alpha = 1.0f;
        }
    }else{
    }
}

- (void)showCoverViewOnTitleView:(UIView *)view
{
    if (view)
    {
        if (_labelTitle)
        {
            _labelTitle.hidden = YES;
        }else{}
        
        [view removeFromSuperview];
        
        [self addSubview:view];
    }else{
    }
}

- (void)hideCoverView:(UIView *)view
{
    [self hideOriginalBarItem:NO];
    if (view && (view.superview == self))
    {
        [view removeFromSuperview];
    }else{}
}

#pragma mark -
- (void)hideOriginalBarItem:(BOOL)bIsHide
{
    if (_btnLeft)
    {
        _btnLeft.hidden = bIsHide;
    }else{}
    if (_btnBack)
    {
        _btnBack.hidden = bIsHide;
    }else{}
    if (_btnRight)
    {
        _btnRight.hidden = bIsHide;
    }else{}
    if (_labelTitle)
    {
        _labelTitle.hidden = bIsHide;
    }else{}
}



@end
