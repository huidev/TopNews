//
//  CustomView.m
//  myDemo
//
//  Created by 于君 on 15/3/16.
//  Copyright (c) 2015年 yj. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

-(IBAction)myButtonAction:(UIButton *)sender
{
    self.myBlock(sender);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
