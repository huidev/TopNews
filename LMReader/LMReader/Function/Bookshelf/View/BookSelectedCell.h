//
//  BookSelectedCell.h
//  LMReader
//
//  Created by 于君 on 16/5/26.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookSelectedCell : UICollectionViewCell
{
    UIImageView *_coverImageV;
    UILabel *_bookNameLB;
}

@property (strong, nonatomic)UIImageView *coverImageV;

- (void)configNormalCell:(id)model;
@end
