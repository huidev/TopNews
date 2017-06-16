//
//  LMViewController.m
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMViewController.h"



@implementation LMViewController

- (void)loadView
{
    [super loadView];
    self.view = [[UIView alloc]initWithFrame:SCREEN_BOUNDS];
    self.view.backgroundColor = [UIColor whiteColor];
//    _brightnessView = [[UIView alloc]initWithFrame:SCREEN_BOUNDS];
//    [self.view addSubview:_brightnessView];
//    _brightnessView.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navbar) {
        [self.view bringSubviewToFront:self.navbar];
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
}
@end
