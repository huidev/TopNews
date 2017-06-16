//
//  BookSelectedCell.m
//  LMReader
//
//  Created by 于君 on 16/5/26.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "BookSelectedCell.h"
#import <Masonry/Masonry.h>

@implementation BookSelectedCell

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
    _coverImageV = [[UIImageView alloc]init];
    _bookNameLB = [[UILabel alloc]init];
    
    [self addSubview:_coverImageV];
    [self addSubview:_bookNameLB];
    [self _updateConstraint];
}
- (void)_updateConstraint
{
    [_coverImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 50, 0));
    }];
    [_bookNameLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
        make.left.right.equalTo(self);
    }];
}

- (void)configNormalCell:(id)model;
{
    _bookNameLB.text = @"bookname";
    _coverImageV.image = [UIImage imageNamed:@"demo@2x"];
}
@end
