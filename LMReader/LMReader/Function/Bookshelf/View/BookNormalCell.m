//
//  BookNormalCell.m
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "BookNormalCell.h"
#import <Masonry/Masonry.h>
#import "BookEntity.h"

@interface BookNormalCell()
{
    CGPoint beginCenter;
}
@end

@implementation BookNormalCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _layoutSubview];
//        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)_layoutSubview
{
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureAction:)];
//    [self addGestureRecognizer:pan];
    _coverImageV = [[UIImageView alloc]init];
    _unreadImageV = [[UIImageView alloc]init];
    _unreadImageV.image = [UIImage imageNamed:@"bookShelfPopMenulist"];
    _bookNameLB = [[UILabel alloc]init];
    _bookNameLB.numberOfLines = 2;
    _bookNameLB.font = [UIFont systemFontOfSize:15];
    
    _progressLB = [[UILabel alloc]init];
    _progressLB.numberOfLines = 1;
    _progressLB.font = [UIFont systemFontOfSize:15];
    _progressLB.backgroundColor = RGBA(0, 0, 0, 0.7);
    _progressLB.textAlignment = NSTextAlignmentCenter;
    _progressLB.textColor = [UIColor whiteColor];
    _progressLB.text = @"更新第一章";
    
    [self addSubview:_coverImageV];
    [self addSubview:_unreadImageV];
    [self addSubview:_bookNameLB];
    [self addSubview:_progressLB];
    [self _updateConstraint];
}
- (void)_updateConstraint
{
    [_coverImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 45, 0));
    }];
    [_unreadImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(5);
        make.right.equalTo(self).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    [_bookNameLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.coverImageV.mas_bottom).with.offset(5);
        make.right.equalTo(self).with.offset(0);
        make.left.equalTo(self).with.offset(0);
    }];
    [_progressLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.coverImageV.mas_bottom).with.offset(0);
        make.right.equalTo(self).with.offset(0);
        make.left.equalTo(self).with.offset(0);
        make.height.mas_equalTo(20);
    }];
}

- (void)configNormalCell:(id)model;
{
    BookEntity *entity = model;
    _bookNameLB.text = entity.b_name;
    _coverImageV.image = [UIImage imageNamed:entity.b_id];
}
- (void)panGestureAction:(UIPanGestureRecognizer *)gesture
{
    
    if (gesture.state==UIGestureRecognizerStateChanged) {
        self.center =[gesture locationInView:self.superview];
    }else if (gesture.state == UIGestureRecognizerStateBegan)
    {
        [self.superview bringSubviewToFront:self];
        beginPoint = [gesture locationInView:self.superview];
        beginCenter = self.center;
        self.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        self.transform = CGAffineTransformIdentity;
        UICollectionView *collectV = (UICollectionView*)self.superview;
        if ([collectV indexPathForItemAtPoint:beginPoint]==[collectV indexPathForItemAtPoint:[gesture locationInView:self.superview]]) {
            self.center = beginCenter;
            return;
        }
        [self.delegate bookCellMoveBeginPoint:beginPoint andEndPoint:[gesture locationInView:self.superview]];
        
    }
}
@end
