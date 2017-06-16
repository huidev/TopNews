//
//  LMReadingVC.m
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMReadingVC.h"
#import "LMReadingVC+Helper.h"
#import "ReadingSettingView.h"
#import "ProgressSettingView.h"
#import "LMCatelogAnimtor.h"
#import "DTAttStringManage.h"
#import "MarkPanGesture.h"
static NSInteger kPullviewHeight = 55;

@class DemoTextViewController;
@interface LMReadingVC ()<UIGestureRecognizerDelegate,ReadingViewSettingDelegate,UIScrollViewDelegate>
{
    ReadingSettingView *_settingView;
    ProgressSettingView *_progressSettingView;
    DemoTextViewController *textVC;
    UIPercentDrivenInteractiveTransition *percentTransition;
    UIScreenEdgePanGestureRecognizer *edgeGes;
    UIView *_pullMarkView;//下拉添加书签
    UILabel *_bookmarkView;
    UIImageView *_arrowImageV;
    UIImageView *_markImageV;
    UIImageView *_logoImageV;
    BOOL showStatus;
}
@property (strong, nonatomic) PageModelControll *modelController;
@end

@implementation LMReadingVC
@synthesize modelController = _modelController;

- (void)dealloc
{
    [[UIApplication sharedApplication] removeObserver:self forKeyPath:@"statusBarHidden"];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
//    self.tabBarController.tabBar.hidden = NO;
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.delegate = self;
    self.fd_prefersNavigationBarHidden = YES;
    [[UIApplication sharedApplication] addObserver:self forKeyPath:@"statusBarHidden" options:NSKeyValueObservingOptionNew context:nil];
    edgeGes = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePan:)];
    edgeGes.edges = UIRectEdgeLeft;
    edgeGes.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
    // Configure the page view controller and add it as a child view controller.
    [self _chagePageViewControllerStyle:[LMGoble sharedGoble].pageTransition];
    [self addNavBar];
    [self addBottomToolBar];
    [self _layoutSettingView];
        // Do any additional setup after loading the view.
}
#pragma mark - KVO

//滑动返回
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSString*, id> *)change context:(nullable void *)context;
{
    showStatus = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
    if (!showStatus) {
        edgeGes.enabled = YES;
    }else
    {
        edgeGes.enabled = NO;
    }
    
}
- (void)_layoutSettingView
{
    _pullMarkView = [UIView new];
    _pullMarkView.frame = CGRectMake(0, -kPullviewHeight, SCREEN_WIDTH, kPullviewHeight);
    
    _bookmarkView = [UILabel new];
    _bookmarkView.font = [UIFont systemFontOfSize:15];
    _bookmarkView.text = @"下拉添加书签";
    
    _markImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_sousuokuang"]];
    _arrowImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    
    
    [_pullMarkView addSubview:_arrowImageV];
    [_pullMarkView addSubview:_markImageV];
    [_pullMarkView addSubview:_bookmarkView];
    
    [self.view addSubview:_pullMarkView];
    _logoImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"boy_nl"]];
    
    [_bookmarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_pullMarkView.mas_right).with.offset(-50);
        make.bottom.equalTo(_pullMarkView.mas_bottom).with.offset(-5);
    }];
    [_arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bookmarkView.mas_right).with.offset(5);
        make.bottom.equalTo(_bookmarkView.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(8, 17));
    }];
    [_markImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_pullMarkView.mas_right).with.offset(-15);
        make.bottom.equalTo(_pullMarkView.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(15, kPullviewHeight));
    }];
    _settingView = [[ReadingSettingView alloc]init];
    _settingView.delegate = self;
    _settingView.backgroundColor = RGBA(51,51,51,0.85);;
    [self.view insertSubview:_settingView belowSubview:self.bottomToolBar];
    [_settingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-49);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
    }];
    _settingView.transform = CGAffineTransformMakeTranslation(0, 100);
    
    _progressSettingView = [[ProgressSettingView alloc]init];
    _progressSettingView.delegate = self;
    _progressSettingView.backgroundColor = RGBA(51,51,51,0.85);;
    [self.view insertSubview:_progressSettingView belowSubview:self.bottomToolBar];
    [_progressSettingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-49);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
    }];
    _progressSettingView.transform = CGAffineTransformMakeTranslation(0, 100);
}

- (void)_chagePageViewControllerStyle:(UIPageViewControllerTransitionStyle)type
{
    if (self.pageViewController.transitionStyle!=type||!self.pageViewController) {
        self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:type navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        if (type == UIPageViewControllerTransitionStyleScroll) {
            _scrollTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_tapActionScrollTransition:)];
            [self.pageViewController.view addGestureRecognizer:_scrollTap];
            
        }
        for(UIScrollView *subview in [self.pageViewController.view subviews])
        {
            if([subview isKindOfClass:[UIScrollView class]]) {
                
//                subview.panGestureRecognizer.delegate = self;
            }
        }
        //反页页内容为正页的翻转反射
        self.pageViewController.doubleSided = YES;
        
        [self.pageViewController.view addGestureRecognizer:edgeGes];
        self.pageViewController.delegate = self;
        MarkPanGesture *pan = [[MarkPanGesture alloc] initWithTarget:self action:@selector(handlePan:)];
        
        [self.pageViewController.view addGestureRecognizer:pan];
        [[DTAttStringManage sharedManage] parseBook:self.currentBook finish:^{
            DemoTextViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
            self.modelController.currentViewController = startingViewController;
            NSArray *viewControllers ;
            if (startingViewController) {
               viewControllers = @[startingViewController];
            }
            
            
            [self.pageViewController setViewControllers:viewControllers direction:type==UIPageViewControllerTransitionStyleScroll?UIPageViewControllerNavigationDirectionForward:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
            
            self.pageViewController.dataSource = self.modelController;
            [self addChildViewController:self.pageViewController];
            [self.view insertSubview:self.pageViewController.view atIndex:0];
            textVC = self.pageViewController.viewControllers[0];
            // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
            CGRect pageViewRect = self.view.bounds;
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                pageViewRect = CGRectInset(pageViewRect, 0.0, 80.0);
            }
            pageViewRect = CGRectInset(pageViewRect, 0.0, 0.0);
            self.pageViewController.view.frame = pageViewRect;
            
            [self.pageViewController didMoveToParentViewController:self];
           
            [self.view insertSubview:_logoImageV atIndex:0];
            
            [_logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
                make.top.equalTo(self.view.mas_top).with.offset(90);
                make.size.mas_equalTo(CGSizeMake(60, 60));
            }];
            
            // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
//            self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
            [self.pageViewController.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIGestureRecognizer *recognize = obj;
                recognize.delegate = self;
                [recognize requireGestureRecognizerToFail:pan];
                [recognize requireGestureRecognizerToFail:edgeGes];
                if ([recognize isKindOfClass:[UITapGestureRecognizer class]]) {
                    UIView *view = [startingViewController.view viewWithTag:200];
                    for (UIGestureRecognizer *recogn in view.gestureRecognizers) {
                        [recogn requireGestureRecognizerToFail:recognize];
                        
                    }
                }
            }];
            
        }];

    }
}
#pragma mark - public
- (void)hideSettingView;
{
    [UIView animateWithDuration:0.3 animations:^{
        _settingView.transform = CGAffineTransformMakeTranslation(0, 100);
        _progressSettingView.transform = CGAffineTransformMakeTranslation(0, 100);
        ;
    }];
}
- (void)showOrHideSettingView;
{
    [UIView animateWithDuration:0.3 animations:^{
        if (CGAffineTransformIsIdentity(_settingView.transform)) {
            _settingView.transform = CGAffineTransformMakeTranslation(0, 100);
        }else
        {
            _settingView.transform = CGAffineTransformIdentity;
        }
    }];
    
}
- (void)showOrHideFontSettingView;
{
    [UIView animateWithDuration:0.3 animations:^{
        if (CGAffineTransformIsIdentity(_progressSettingView.transform)) {
            _progressSettingView.transform = CGAffineTransformMakeTranslation(0, 100);
        }else
        {
            _progressSettingView.transform = CGAffineTransformIdentity;
        }
    }];
    
}
- (void)changeCompose;
{
    NSInteger page = self.modelController.pageIndex;
    NSInteger chapter = self.modelController.chapterIndex;
    self.modelController = nil;
    self.modelController = [[PageModelControll alloc]init];
    self.modelController.pageIndex = page;
    self.modelController.chapterIndex = chapter;
    [self.modelController defaultConfig];
    DemoTextViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
    NSArray *viewControllers ;
    if (startingViewController) {
        viewControllers = @[startingViewController];
    }
    
    [self.pageViewController setViewControllers:viewControllers direction:[LMGoble sharedGoble].pageTransition==UIPageViewControllerTransitionStyleScroll?UIPageViewControllerNavigationDirectionForward:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    
    self.pageViewController.dataSource = self.modelController;
}
- (void)changeTheme:(STTheme)theme;
{
    switch (theme) {
        case STThemeBlack:
        {
            [self.pageViewController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.view.backgroundColor = COLOR_BG_DARK;
            }];
        }
            break;
        case STThemeWhite:
        {
            [self.pageViewController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.view.backgroundColor = COLOR_BG_DAY;
            }];
        }
            break;
        default:
            break;
    }
}
#pragma mark - setting delegate
- (void)handlePan:(MarkPanGesture *)gesture
{
    CGPoint location = [gesture locationInView:self.view];
    if (![UIApplication sharedApplication].statusBarHidden) {
        return;
    }
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        
    }
    else if(gesture.state == UIGestureRecognizerStateChanged)
    {
        
        if (fabs(location.x-gesture.touchBeginPoint.x)<15) {
            
            if (fabs(location.y-gesture.touchBeginPoint.y) < kPullviewHeight) {
                _pullMarkView.transform = CGAffineTransformMakeTranslation(0, location.y-gesture.touchBeginPoint.y);
                self.pageViewController.view.transform = CGAffineTransformMakeTranslation(0, location.y-gesture.touchBeginPoint.y);
                _bookmarkView.text = @"下拉添加书签";
                
                [UIView animateWithDuration:0.1 animations:^{
                    _arrowImageV.transform=CGAffineTransformIdentity;
                }];
            }else
            {
                
                _bookmarkView.text = @"松开添加书签";
                if (location.y-gesture.touchBeginPoint.y>0) {
                    [UIView animateWithDuration:0.1 animations:^{
                        _arrowImageV.transform=CGAffineTransformMakeRotation(M_PI);
                    }];
                    _pullMarkView.transform = CGAffineTransformMakeTranslation(0, kPullviewHeight);
                    self.pageViewController.view.transform = CGAffineTransformMakeTranslation(0, (location.y-gesture.touchBeginPoint.y-kPullviewHeight)/4+kPullviewHeight);
                }else
                {
                    _pullMarkView.transform = CGAffineTransformMakeTranslation(0, -kPullviewHeight);
                    self.pageViewController.view.transform = CGAffineTransformMakeTranslation(0, (location.y-gesture.touchBeginPoint.y-kPullviewHeight)/4-kPullviewHeight);
                }
                
            }
            
        }
    }else
    {
        //添加或取消书签
        if (location.y-gesture.touchBeginPoint.y>kPullviewHeight) {
            [textVC addBookMark];
        }else if (location.y-gesture.touchBeginPoint.y<-kPullviewHeight)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        [UIView animateWithDuration:0.3 animations:^{
            _pullMarkView.transform = CGAffineTransformIdentity;
            self.pageViewController.view.transform = CGAffineTransformIdentity;
        }];
        
    }
    return;
}
- (void)readingSettingChangeBrightness:(CGFloat)bright;
{
    [self.pageViewController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DemoTextViewController *vc = obj;
        vc.brightView.alpha = bright;
    }];
    self.topToolBar.backgroundColor = RGBA(0, 0, 0, bright);
    self.bottomToolBar.backgroundColor = RGBA(0, 0, 0, bright);
}
- (void)readingSettingChangeProgress:(CGFloat)pregress;
{
    [LMGoble sharedGoble].fontSize = 17+10*pregress;
    [self changeCompose];
    
}
#pragma mark -
- (PageModelControll *)modelController {
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[PageModelControll alloc] init];
        
    }
    return _modelController;
}
- (void)_tapActionScrollTransition:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:self.view];
    if (CGRectContainsPoint(CGRectInset(self.view.bounds, SCREEN_WIDTH/3, 0), touchPoint)) {
        
        [self tapShowHideToolBar];
        [self hideSettingView];
    }else if (CGRectContainsPoint(CGRectMake(0, 0, SCREEN_WIDTH/3, SCREEN_HEIGHT),touchPoint))//left
    {
        NSInteger index;
        if (!self.modelController.pageIndex) {
            [self.modelController setLastChapterToCurrent];
            index = self.modelController.pageData.count-1;
            DemoTextViewController *vc = [self.modelController viewControllerAtIndex:index storyboard:nil];
            WEAK_SELF
            if (vc) {
                [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
                    [weakSelf.modelController setLastChapterToCurrent];
                }];
            }
        }else
        {
            index = self.modelController.pageIndex-1;
            DemoTextViewController *vc = [self.modelController viewControllerAtIndex:index storyboard:nil];
            if (vc) {
                [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
                    
                }];
            }
        }
        
        
        
    }else
    {
        NSInteger index;
        if ([self.modelController indexOfViewController:self.pageViewController.viewControllers[0]]==NSNotFound||self.modelController.pageIndex ==NSNotFound) {
            index = 0;
        }else
        {
            index = self.modelController.pageIndex+1;
        }
        
        DemoTextViewController *vc = [self.modelController viewControllerAtIndex:index storyboard:nil];
        if (vc) {
            [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
                
            }];
        }

    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] &&
        
        [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]&&!CGAffineTransformIsIdentity(self.pageViewController.view.transform)) {
        
        return NO;
        
    }
    
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0);
{
    if([otherGestureRecognizer isKindOfClass:[MarkPanGesture class]])
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:self.view];
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {

        if (CGRectContainsPoint(CGRectInset(self.view.bounds, SCREEN_WIDTH/3, 0), touchPoint)) {
            [self tapShowHideToolBar];
            [self hideSettingView];
            
        }else if (CGRectContainsPoint(CGRectMake(0, 0, SCREEN_WIDTH/3, SCREEN_HEIGHT), touchPoint))
        {
            
        }else if (CGRectContainsPoint(CGRectMake(SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3, SCREEN_HEIGHT), touchPoint))
        {
            
        }
        
    }
    
    else if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
    {
//        if (CGRectContainsPoint(CGRectMake(0, 0, SCREEN_WIDTH/4, SCREEN_HEIGHT), touchPoint)&&!showStatus) {
//            return NO;
//        }
    }
    return YES;
}
-(BOOL)respondsToSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector])
        return YES;
    else if ([self.pageViewController respondsToSelector:aSelector])
        return YES;
    else
        return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) {
        return nil;
    }
    else if ([self.pageViewController respondsToSelector:aSelector]) {
        return self.pageViewController;
    }
    return nil;
}
#pragma mark -
#pragma mark - UIPageViewController delegate methods
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    self.modelController.pageAnimationFinished = NO;
    [self hideSettingView];
    [self panHideToolBar];
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed;
{
    textVC = pageViewController.viewControllers[0];
    self.modelController.pageAnimationFinished = YES;
}
- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    if (UIInterfaceOrientationIsPortrait(orientation) || ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)) {
        // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
//        if (self.pageViewController.viewControllers.count) {
//            UIViewController *currentViewController = self.pageViewController.viewControllers[0];
//            NSArray *viewControllers = @[currentViewController];
//            [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
//        }

        self.pageViewController.doubleSided = NO;
        return UIPageViewControllerSpineLocationMin;
    }
    
    // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
    DemoTextViewController *currentViewController = self.pageViewController.viewControllers[0];
    NSArray *viewControllers = nil;
    NSUInteger indexOfCurrentViewController = [self.modelController indexOfViewController:currentViewController];
    if (indexOfCurrentViewController == 0 || indexOfCurrentViewController % 2 == 0) {
        UIViewController *nextViewController = [self.modelController pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
        viewControllers = @[currentViewController, nextViewController];
    } else {
        UIViewController *previousViewController = [self.modelController pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
        viewControllers = @[previousViewController, currentViewController];
    }
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    return UIPageViewControllerSpineLocationMid;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)edgePan:(UIPanGestureRecognizer *)recognizer{
    self.drivePercent(recognizer,self);
}
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);
{
    if(operation ==UINavigationControllerOperationPush)
    {
        LMCatelogAnimtor *pushAnimtor = [[LMCatelogAnimtor alloc]init];
        pushAnimtor.transitiontype = ControllerTransitionTypePush;
        return pushAnimtor;
    }else if (operation == UINavigationControllerOperationPop)
    {
        LMCatelogAnimtor *popAnimtor = [[LMCatelogAnimtor alloc]init];
        popAnimtor.transitiontype = ControllerTransitionTypePop;
        return popAnimtor;
    }
    return nil;
}
#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
