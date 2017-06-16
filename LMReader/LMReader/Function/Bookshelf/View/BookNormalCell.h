//
//  BookNormalCell.h
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BookCellDelegate <NSObject>

@optional
- (void)bookCellMoveBeginPoint:(CGPoint )beginP andEndPoint:(CGPoint)endP;

@end

@interface BookNormalCell : UICollectionViewCell
{
    UIImageView *_coverImageV;
    UIImageView *_unreadImageV;
    UILabel *_bookNameLB;
    UILabel *_progressLB;
    CGPoint beginPoint;
}

@property (strong, nonatomic)UIImageView *coverImageV;
@property (strong, nonatomic)UIView *content;
@property (assign, nonatomic)id <BookCellDelegate>delegate;
- (void)configNormalCell:(id)model;
@end
