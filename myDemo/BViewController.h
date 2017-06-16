//
//  BViewController.h
//  myDemo
//
//  Created by 于君 on 15/3/16.
//  Copyright (c) 2015年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic)IBOutlet UITableView *m_tableview;
@property(copy, nonatomic) void(^myBlock)(NSString *str);
@property(strong, nonatomic)NSString *bControllerValue;
@end
