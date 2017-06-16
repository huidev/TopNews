//
//  LMBookShelfVC.h
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMViewController.h"
#import "BookNormalCell.h"
#import "LMOpenBookAnimtor.h"
#import "UIViewController+CustomNarbar.h"

@interface LMBookShelfVC : LMViewController  <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIViewControllerTransitioningDelegate,BookCellDelegate>

@property (strong, nonatomic)UICollectionView *collectionView;
@property (strong, nonatomic)NSIndexPath *selectedIndex;

@end
