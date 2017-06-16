//
//  LMBookShelfVC.m
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMBookShelfVC.h"
#import "MacroFunctions.h"
#import "LMReadingVC.h"
#import "BookEntity.h"

@interface LMBookShelfVC ()
{
    UICollectionView *_collectionView;
    NSMutableArray *_lBooks;
    LMOpenBookAnimtor *transition ;
    UIPercentDrivenInteractiveTransition *percentTransition;
}
@end

@implementation LMBookShelfVC

static NSString * const reuseIdentifier = @"CellNormal";

- (void)loadView
{
    [super loadView];
    self.view = [[UIView alloc]initWithFrame:SCREEN_BOUNDS];
    
    self.navbar.barTintColor = [UIColor redColor];
    [self setBarTitle:@"书架"];
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:SCREEN_BOUNDS collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [self.view addSubview:_collectionView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _lBooks = [NSMutableArray arrayWithArray:[[DatebaseManage sharedDatebase]fetchBooks]];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.title = @"书架";

    // Register cell classes
    [_collectionView registerClass:[BookNormalCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    self.navigationController.delegate = self;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -gesture delegate
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    if (touch.view != self.collectionView) {
//        return NO;
//    }
//    
//    return YES;
//}
#pragma mark <UICollectionViewDataSource>

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_lBooks count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BookNormalCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    [cell.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.delegate = self;
    }];
    
    [cell configNormalCell:[_lBooks objectAtIndex:indexPath.row]];
//    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    return cell;
    // Configure the cell

}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 160);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return 10;
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    self.selectedIndex = indexPath;
    BookEntity *selectBook = [_lBooks objectAtIndex:indexPath.row];
    
    LMReadingVC *readingVC = [[LMReadingVC alloc]init];
    readingVC.drivePercent = ^(UIPanGestureRecognizer *recognizer ,UIViewController*vc)
    {
        CGFloat per = [recognizer translationInView:vc.view].x / (self.view.bounds.size.width);
        per = MIN(1.0,(MAX(0.0, per)));
        
        if (recognizer.state == UIGestureRecognizerStateBegan) {
            percentTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }else if (recognizer.state == UIGestureRecognizerStateChanged){
            [percentTransition updateInteractiveTransition:per];
        }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
            if (per > 0.3) {
                [percentTransition finishInteractiveTransition];
            }else{
                [percentTransition cancelInteractiveTransition];
            }
            percentTransition = nil;
        }

    };
    UINavigationController *readNav =[[UINavigationController alloc] initWithRootViewController:readingVC];
    readingVC.currentBook = selectBook;
    readNav.transitioningDelegate = self;
    readNav.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:readNav animated:YES completion:^{
        [_lBooks removeObject:selectBook];
        [_lBooks insertObject:selectBook atIndex:0];
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        [_collectionView reloadData];
    }];
    
//    readingVC.hidesBottomBarWhenPushed = YES;
    
//    [self.navigationController pushViewController:readingVC animated:YES];
    return;
}

// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}



// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return YES;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
#pragma mark - 动画代理
#pragma mark - 定制转场动画 (Present 与 Dismiss动画代理)
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    
    // 推出控制器的动画
    BookNormalCell *cell = (BookNormalCell*)[_collectionView cellForItemAtIndexPath:self.selectedIndex];
    if (!transition) {
        transition = [[LMOpenBookAnimtor alloc] init];
    }
    transition.transitiontype = ControllerTransitionTypePresent;
    transition.animatedView = cell;
    // 退出控制器动画
    return transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    // 推出控制器的动画
    BookNormalCell *cell = (BookNormalCell*)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0 ]];
    if (!transition) {
        transition = [[LMOpenBookAnimtor alloc] init];
    }
    transition.transitiontype = ControllerTransitionTypeDismiss;
    transition.animatedView = cell;
    // 退出控制器动画
    return transition;
}
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator;
{
    return percentTransition;
}
- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return percentTransition;
}

#pragma mark - book cell delegate
- (void)bookCellMoveBeginPoint:(CGPoint )beginP andEndPoint:(CGPoint)endP;
{
    [self.collectionView moveItemAtIndexPath:[self.collectionView indexPathForItemAtPoint:beginP] toIndexPath:[self.collectionView indexPathForItemAtPoint:endP]];
}
@end
