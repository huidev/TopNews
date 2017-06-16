//
//  ScrollViewController.m
//  myDemo
//
//  Created by 于君 on 17/4/26.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()
{
    UIScrollView *m_scrollview;
}
@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor redColor];
    m_scrollview = [[UIScrollView alloc]init];
    m_scrollview.backgroundColor = [UIColor yellowColor];
    
    m_scrollview.frame = CGRectMake(0, 80, 320, 320);
    m_scrollview.contentInset = UIEdgeInsetsMake(180, 0, 40, 0);
    m_scrollview.contentSize = CGSizeMake(320, 1000);
    [self.view addSubview:m_scrollview];
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 180)];
    lb.backgroundColor = [UIColor greenColor];
    lb.text = @"m_scrollviewlable";
    [m_scrollview addSubview:lb];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
