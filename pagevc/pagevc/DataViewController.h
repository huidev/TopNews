//
//  DataViewController.h
//  pagevc
//
//  Created by 于君 on 16/7/26.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController<UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;

@end
