//
//  TextTableViewCell.m
//  myDemo
//
//  Created by 于君 on 15/10/12.
//  Copyright (c) 2015年 yj. All rights reserved.
//

#import "TextTableViewCell.h"

@implementation TextTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // get the current context
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext() ;
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 1);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 8, self.bounds.size.height-1);
    CGContextAddLineToPoint(context, self.bounds.size.width-16, self.bounds.size.height-1);
    CGContextStrokePath(context);
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
