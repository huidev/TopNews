//
//  CustomView.h
//  myDemo
//
//  Created by 于君 on 15/3/16.
//  Copyright (c) 2015年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView

@property(strong, nonatomic) void(^myBlock)(UIButton *bt);
@property(weak, nonatomic) IBOutlet UIButton *bt1;
@property(weak, nonatomic) IBOutlet UIButton *bt2;

@end
