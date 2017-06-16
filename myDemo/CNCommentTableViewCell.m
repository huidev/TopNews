//
//  CNCommentTableViewCell.m
//  xinjunshi
//
//  Created by 于君 on 15/9/30.
//  Copyright (c) 2015年 yj. All rights reserved.
//

#import "CNCommentTableViewCell.h"

CGRect titleRect;
@implementation CNCommentTableViewCell

- (void)awakeFromNib {
    // Initialization code

}
- (void)drawRect:(CGRect)rect
{
    // get the current context
    CGContextRef context = UIGraphicsGetCurrentContext() ;

    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 1);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 8, self.bounds.size.height-1);
    CGContextAddLineToPoint(context, self.bounds.size.width-16, self.bounds.size.height-1);
    CGContextStrokePath(context);
}
- (void)setDataDic:(NSDictionary *)dataDic
{
    
    
}

+ (CGFloat)calculateCellHeight:(NSString *)contentStr;
{
    titleRect = [contentStr boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-16, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    CGFloat height = titleRect.size.height+28+1+18;
    return height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
