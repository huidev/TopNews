//
//  CNCommentTableViewCell.h
//  xinjunshi
//
//  Created by 于君 on 15/9/30.
//  Copyright (c) 2015年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNCommentTableViewCell : UITableViewCell

@property (strong, nonatomic)IBOutlet UILabel *nameLB;
@property (strong, nonatomic)IBOutlet UILabel *locationLB;
@property (strong, nonatomic)IBOutlet UILabel *dateLB;
@property (strong, nonatomic)IBOutlet UILabel *contentLB;
@property (strong, nonatomic)NSDictionary *dataDic;

+ (CGFloat)calculateCellHeight:(NSString *)contentStr;
@end
